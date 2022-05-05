import SwiftUI

// This file contains all content that app displays, organized with Pages
let BasicsCourse : [Page] = [welcome, fonts, hierarchy, alignment, spacing, detail, quiz]

/// All avalible PlaygroundViews that PageContentView can darw
/// The switch case in PageContentView must cover that case for a view to appear
enum PlaygroundViews {
    case welcomePlaygroundView
    case fontsPlaygroundView
    case hierarchyPlaygroundView
    case appPlaygroundView
    case alignmentPlaygroundView
    case kerningPlaygroundView
    case quizPlaygroundView
}

/// All avalible ContentCustomView that PageContentView can darw
/// The switch case in PageContentView must cover that case for a view to appear
enum ContentCustomView {
    case fontsContentCustomView
    case hierarchyContentCustomView
}

let welcome = Page(
    id: "basics_welcome",
    title: "Welcome",
    contentSubTitle: "Welcome",
    contentTitle: "Typography Basics Crashcourse",
    titleImageName: "graduationcap.fill",
    titleImageSizeAdjustment: 0,
    playgroundView: .welcomePlaygroundView,
    elements: [
        PageText("This course introduces you to some fundamental rules of typography. When you're done, you'll know how to work with text better than the vast majority of people. Please be aware that this course covers the basics, there's still a whole lot more to explore."),
        PageTask("To apply what you have learned, each lesson challenges you to accomplish a task. Interact with the controls in the Playground view on the right to solve the tasks. For now, simply click the blue button.", topSpacing: true),
        PageHeadline("Focus on readability", topSpacing: true),
        PageText("Good typography serves one purpose: It makes text greatly readable. It may also serve the purpose of creating an aesthetic visual appearance but readability is the major priority for every typographic work. Make sure that all your choices while working with text align with that goal."),
        PageDivider(topSpacing: true),
        PageHeadline("Break the rules", topSpacing: true),
        PageText("I have tried to write the fundamental rules of typography in such a way that they can help with decision-making in case of uncertainty. The rules are therefore much more a guideline than generally valid wisdom. If you know what you are doing, you can break these rules and still do great typographic work."),
    ]
)

let fonts = Page(
    id: "basics_fonts",
    title: "Fonts",
    contentSubTitle: "Lesson 1",
    contentTitle: "Use one font",
    titleImageName: "textformat",
    titleImageSizeAdjustment: 0,
    playgroundView: .fontsPlaygroundView,
    elements: [
        PageText("Fonts are the foundational building block of every typographic work. There are countless fonts available, but they all fall into a few font categories. You can discover the most common of those below."),
        PageCustomView(.fontsContentCustomView, topSpacing: true),
        PageText("Each kind has its use cases but the by far most common font categories and the ones you should be preferring are Sans Serif and Serif fonts. Speaking generally, Sans Serif fonts should be chosen for screens and Serif fonts work best for print."),
        PageDivider(topSpacing: true),
        PageHeadline("Keep it simple", topSpacing: true),
        PageText("As long as you are not absolutely sure what you are doing, it's best to stick to just one font for a project. You can still create hierarchy, as we will discover in the next lesson. Choose well established and perfectly readable fonts like Helvetica (Sans Serif) or Garamond (Serif). If you choose to work with two different typefaces for a project, make sure that these have a strong contrast and are easily distinguishable."),
        PageTask("You are designing an article preview for a newspaper app. In the playground on the right, apply what you have learned and select good fonts for that project.", topSpacing: true),
        PageHeadline("Summary", topSpacing: true),
        PageText("For screens use Sans Serif and for print use Serif fonts. Stick to one font for a project and prefer well-established typefaces."),
    ]
)

let hierarchy = Page(
    id: "basics_hierarchy",
    title: "Hierarchy",
    contentSubTitle: "Lesson 2",
    contentTitle: "Skip a weight and create hierarchy",
    titleImageName: "list.bullet", // text.alignleft
    titleImageSizeAdjustment: 0,
    playgroundView: .hierarchyPlaygroundView,
    elements: [
        PageText("Good typography lets readers easily understand the semantics of different paragraphs in a layout. We use hierarchy to achieve that desired effect."),
        PageHeadline("Font sizes", topSpacing: true),
        PageText("The first option to create hierarchy is the font size. The larger the font of a paragraph the more dominant and important it will appear. Make sure that you choose a consistent system of sizes which allows easy distinction. A good rule of thumb is to double the size for the next higher hierarchy."),
        //PageText("Keep in mind that we also pursue the goal of making text greatly readable, so don't choose too small font sizes. For body text, go for a point size larger than 13 pixels for digital and 10 points for print."),
        PageDivider(topSpacing: true),
        PageHeadline("Font styles", topSpacing: true),
        PageText("You probably already know that fonts can have different weights. Thin, Regular or Semibold just to name a few. In addition to working with different font sizes, you can also use these weights to create hierarchy and empathise different paragraphs. Whenever you use more than one style of a font, make sure to skip a weight, otherwise, the difference between those two weights is too subtle. You can for example choose a combination of regular and semibold, if there is a medium in between."),
        PageCustomView(.hierarchyContentCustomView, topSpacing: true),
        PageText("Above you can see an example of a very simple hierarchy, similar to the one used in this app. It's achieved through a combination of fonsizes and weights. For your projects, think about the diffrent kinds of paraghrahy you have, create a hierachry system and stick to it."),
        PageTask("The news app on the right currently lacks a clear hierarchy. The problem is the headline, adjust the font size and weight to fix that.", topSpacing: true),
        PageHeadline("Summary", topSpacing: true),
        PageText("Emphasise diffrent parahraphy with a consistent a hierarchy system. When working with font stiles, skip a weight for better differentiation."),
    ]
)

let alignment = Page(
    id: "basics_alignment",
    title: "Alignment",
    contentSubTitle: "Lesson 3",
    contentTitle: "Left align text",
    titleImageName: "align.horizontal.left", // align.horizontal.left.fill
    titleImageSizeAdjustment: 0,
    playgroundView: .alignmentPlaygroundView,
    elements: [
        PageText("Your text alignment choice has a huge influence on the readbility of a text. Most of the time, aligning text left is your best option, some times you can work with centered texts but avoid justified alignment, as the inconstent spacing between the words, makes reading more demanding — we don't care that I may look a bit sleeker sometimes."),
        PageHeadline("Right align", topSpacing: true),
        PageText("In left to right languages, don't align text to the right, however there are also languages, in which text is read from right to left. If you are designing for such a language, choose the right align. Supporting the natual language flow with you alignmend improves readability."),
        PageTask("There's a paragraph on the right, play around with the diffrent alignment options, and finally choose the best fitting one."),
        PageHeadline("Summary", topSpacing: true),
        PageText("In left to right languages, left align you're text. Body text should always be left aligned, other text may be centered, but be sure to stick to a consisten system."),
    ]
)

let spacing = Page(
    id: "basics_contrast",
    title: "Spacing",
    contentSubTitle: "Lesson 4",
    contentTitle: "The secret to fonts is use just one",
    titleImageName: "arrow.left.and.right", //mount ruler decrease.indent
    titleImageSizeAdjustment: -2,
    playgroundView: .kerningPlaygroundView,
    elements: [
        PageHeadline("Introduction to Fonts", topSpacing: true),
        PageText("Fonts are the foundational building block of every tyograhphy work. Typograyh is making art with letters, and yes, thats art too!"),
        PageTask("Be happy", subTasks: ["Whats good?"])
    ]
)
 

let detail = Page(
    id: "basics_detail",
    title: "Tracking",
    contentSubTitle: "Lesson 5",
    contentTitle: "Pay attention to detail",
    titleImageName: "textformat.abc.dottedunderline", // text.magnifyingglass
    titleImageSizeAdjustment: 2,
    playgroundView: .kerningPlaygroundView,
    elements: [
        PageText("For this last lesson, we will take a look at something more advanced in typography, kerning and tracking of letters and fonts."),
        PageHeadline("Make space", topSpacing: true),
        PageText("Both kerning and tracking improve the appearance and design of your text by adding or subtracting space between specific pairs of characters. With kerning, you can change the space between two characters and tracking changes the spacing of the whole paragraph. Adjust the tracking with great caution, as too much and too little can make reading a lot more difficult."),
        PageTask("Set the font size to about 60 px and then adjust the tracking to let the word appear a bit more spaced out.", topSpacing: true),
        PageHeadline("Summary", topSpacing: true),
        PageText("You can improve the readability of a font by adjusting its tracking. With kerning, you can change the distance between individual characters, that's often used for perfecting largely visible headlines."),
    ]
)

let quiz = Page(
    id: "basics_quiz",
    title: "Final Quiz",
    contentSubTitle: "Final Quiz",
    contentTitle: "Check your knowledge",
    titleImageName: "brain.head.profile",
    titleImageSizeAdjustment: 0,
    playgroundView: .quizPlaygroundView,
    elements: [
        PageText("Congratulations for making it that far! You've made your way through some of the most fundamental rules of typography, had the chance to apply them and now have a head start in typography. There's one last challenge for you that will put to the test, what you have learned."),
        PageTask("Check what you have learned and finish the final quiz on the right.", topSpacing: true),
        PageDivider(topSpacing: true),
        PageText("Thank you for taking the time to complete this course, I hope you enjoyed it and that you've learned something new. Have a great WWDC, see you there!", topSpacing: true),
    ]
)
