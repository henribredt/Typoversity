//
//  IAPStore.swift
//  TypographyCourse
//
//  Created by Henri Bredt on 29.05.22.
//

import Foundation
import StoreKit

class Store: ObservableObject {
    
    /// Error for transaction verification
    public enum StoreError: Error {
        case failedVerification
    }
    
    @Published private(set) var products: [Product] = []
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    init() {
        //Start a transaction listener as close to app launch as possible so you don't miss any transactions.
        updateListenerTask = listenForTransactions()
        
        // load products from App Store
        Task {
            await requestProducts()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func requestProducts() async {
        do {
            //Request products from the App Store using the identifiers
            let productIdentifiers = ["de.henribredt.Typoversity.tipSmall", "de.henribredt.Typoversity.tipMedium", "de.henribredt.Typoversity.tipLarge"]
            let storeProducts = try await Product.products(for: productIdentifiers)
            DispatchQueue.main.async {
                // Update products from main thread
                self.products = self.sortByPrice(storeProducts)
                print("Products loded")
            }
        } catch {
            print("Failed product request: \(error)")
        }
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        //Begin a purchase.
        let result = try await product.purchase()
        
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            
            //Always finish a transaction.
            await transaction.finish()
            
            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            //Iterate through any transactions which didn't come from a direct call to `purchase()`.
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    
                    //Always finish a transaction.
                    await transaction.finish()
                } catch {
                    //StoreKit has a receipt it can read but it failed verification. Don't deliver content to the user.
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //Check if the transaction passes StoreKit verification.
        switch result {
        case .unverified:
            //StoreKit has parsed the JWS but failed verification. Don't deliver content to the user.
            throw StoreError.failedVerification
        case .verified(let safe):
            //If the transaction is verified, unwrap and return it.
            return safe
        }
    }
    
    
    func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }
    
}
