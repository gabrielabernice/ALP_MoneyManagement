//
//  ArticleViewMac.swift
//  MacALP_MoneyManagement
//
//  Created by Nuzulul Salsabila on 03/06/23.
//

import SwiftUI

struct ArticleViewMac: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Articles")
                .font(.title2)
                .padding(.leading, 18)
                .padding(.top, 10)
                .padding(.bottom, -10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack(alignment: .top, spacing: 0) {
                        VStack(spacing: 20) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color(hex: 0x6DA3FF).opacity(0.3))
                                    .padding()
                                    .overlay(
                                        HStack(spacing: -38) {
                                            Image("MoneyManagement")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 200, height: 200)
                                            VStack(spacing: 5) {
                                                Text("Mastering Budget Management")
                                                    .multilineTextAlignment(.center)
                                                    .font(.system(size: 22))
                                                    .padding(.trailing)
                                                    .bold()
                                                NavigationLink(destination: Article1()) {
                                                    Text("Read")
                                                        .font(.title)
                                                        .padding()
                                                        .background(Color(hex: 0x6DA3FF))
                                                        .foregroundColor(.white)
                                                        .cornerRadius(10)
                                                        .padding(.trailing)
                                                }
                                                .buttonStyle(PlainButtonStyle()) // Remove the default button style
                                                .padding()
                                            }
                                        }
                                    )
                            }
                            .frame(width: 380, height: 280)
                            .padding(.horizontal, -12)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(hex: 0x6DA3FF).opacity(0.3))
                                .padding()
                                .overlay(
                                    HStack(spacing: -20) {
                                        Image("MoneySavings")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 180, height: 200)
                                        
                                        VStack(spacing: 5) {
                                            Text("The Art of Savings Money")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 22))
                                                .padding(.trailing)
                                                .bold()
                                            
                                            NavigationLink(destination: Article2()) {
                                                Text("Read")
                                                    .font(.title)
                                                    .padding()
                                                    .background(Color(hex: 0x6DA3FF))
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                                    .padding(.trailing)
                                            }
                                            .buttonStyle(PlainButtonStyle()) // Remove the default button style
                                            .padding()
                                        }
                                    }
                                )
                        }
                        .frame(width: 380, height: 280)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .frame(height: 185)
    }
}

struct Article1: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView{
            VStack {
                Text("Mastering Budget Management")
                    .font(.title)
                    .padding(.horizontal)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Text("A Path to Financial Control and Success")
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .bold()
                
                Text("""
                 Managing a budget is a fundamental skill for achieving financial control and unlocking world of possibilities. A well-executed budget allows individuals to make informed financial decisions, live within their means, and allocate resources effectively. This article delves into the art of budget management, highlighting its significance and providing practical strategies to help you master this essential aspect of financial success.
                 
                 Understanding the Importance of Budget Management:
                 Budget management serves as a powerful tool for achieving financial goals and maintaining financial health. It provides a clear overview of your income and expenses, enabling you to track where your money is going and make conscious choices about how to allocate it. By actively managing your budget, you gain control over your finances and eliminate the stress of living paycheck to paycheck.
                 
                 Creating a Comprehensive Budget:
                 To embark on a successful budget management journey, begin by documenting all sources of income and categorizing your expenses. Start with fixed expenses, such as rent or mortgage payments, utilities, and insurance premiums. Next, consider variable expenses like groceries, transportation, entertainment, and discretionary spending. Don't forget to allocate a portion of your income towards savings and investments.
                 
                 As you create your budget, be realistic and honest with yourself about your spending habits. Review your previous financial statements or track your expenses for a month to identify areas where you may be overspending. Be mindful of unexpected or irregular expenses, such as medical bills or car repairs, and incorporate them into your budget as well.
                 
                 Making Informed Spending Decisions:
                 A well-managed budget empowers you to make conscious decisions about your spending. Evaluate each expense carefully and differentiate between needs and wants. Prioritize essential expenses, such as food, shelter, and healthcare, while considering areas where you can cut back on non-essential spending.
                 
                 When faced with discretionary expenses, consider their alignment with your financial goals and values. Is the purchase truly necessary? Can you find more cost-effective alternatives? By embracing mindful spending habits, you can optimize your budget and direct your money towards what truly matters to you.
                 
                 Tracking and Adjusting Your Budget:
                 Managing a budget is an ongoing process that requires regular tracking and adjustment. Stay actively engaged with your budget by monitoring your expenses and income consistently. Keep track of your spending through financial apps, spreadsheets, or specialized budgeting tools. Review your budget regularly to ensure that it remains aligned with your financial goals and adjust as needed.
                 
                 When evaluating your budget, look for areas where you can reduce expenses further. Explore opportunities to negotiate bills, seek out discounts or promotions, and be proactive in finding ways to save. Be open to reevaluating your spending patterns and adjusting your budget to accommodate changes in your financial circumstances or goals.
                 
                 Building an Emergency Fund:
                 A crucial aspect of budget management is building an emergency fund. Set aside a portion of your income specifically designated for unexpected expenses or emergencies. Aim to accumulate three to six months' worth of living expenses in this fund. Having an emergency fund provides peace of mind and acts as a financial safety net, protecting you from unexpected financial setbacks.
                 
                 Seeking Professional Guidance:
                 If you find budget management challenging or need assistance in achieving your financial goals, consider consulting a financial advisor or seeking guidance from financial literacy resources. These professionals can provide expert insights tailored to your specific needs, helping you optimize your budget, manage debt, and make informed financial decisions.
                 
                 Mastering budget management is a transformative skill that empowers individuals to take control of their finances and achieve their financial aspirations. By creating a comprehensive budget, making informed spending decisions, tracking and adjusting your budget regularly, building an emergency fund, and seeking professional guidance when needed, you can pave the way for financial success. Embrace budget management as a key pillar of your financial journey and enjoy the rewards of financial control, stability, and the ability to turn your dreams into reality.
                 """)
                .padding(.horizontal)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                }
                .padding()
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

struct Article2: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView{
            VStack {
                // title for article 2
                Text("The Art of Saving Money: Nurturing Financial Wellness and Building a Bright Future")
                    .font(.title)
                    .padding(.horizontal)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                // article 2 contents
                Text("""
                 In an era of economic uncertainty and ever-changing financial landscapes, the art of saving money has emerged as a cornerstone of financial stability and prosperity. It is a skill that empowers individuals to take control of their finances, overcome unexpected challenges, and realize their long-term aspirations. This article delves into the profound significance of saving money, delving into the multifaceted benefits it offers and providing insightful strategies to cultivate effective saving habits.
                 
                 The Power of Saving:
                 Saving money is not merely about accumulating wealth; it is about embracing a mindset that fosters financial well-being and peace of mind. One of the primary advantages of saving is the creation of an emergency fund, a financial safety net that cushions against unforeseen circumstances such as job loss, medical emergencies, or unexpected home repairs. By having a reserve of funds readily available, you can navigate these challenges without resorting to debt or feeling overwhelmed by financial strain.
                 
                 Moreover, saving money provides a pathway to reduce stress and anxiety related to financial matters. Knowing that you have savings to fall back on instills a sense of security and stability, enabling you to face life's uncertainties with confidence. Financial stress is a common burden that weighs heavily on individuals and relationships, but a robust saving habit alleviates this burden and fosters a greater sense of overall well-being.
                 
                 Setting Clear Saving Goals:
                 To embark on a successful saving journey, it is essential to set clear and tangible saving goals. These goals serve as guiding beacons, directing your financial decisions and actions. Whether you aspire to purchase a home, travel the world, start a business, or retire comfortably, articulating your objectives in specific and measurable terms provides focus and motivation.
                 
                 When defining your saving goals, consider their short-term and long-term aspects. Short-term goals might include saving for a dream vacation or purchasing a new vehicle, while long-term goals encompass building a retirement nest egg or funding your children's education. By establishing both types of goals, you create a balanced approach to saving that allows for immediate gratification while keeping a steadfast eye on the future.
                 
                 Crafting a Realistic Budget:
                 A well-crafted budget acts as a financial compass, guiding your spending and empowering you to make deliberate choices. It entails a thorough evaluation of your income and expenses, including fixed costs like rent or mortgage payments, utilities, and insurance, as well as variable expenses such as groceries, transportation, and entertainment. By gaining a comprehensive understanding of your cash flow, you can assess how much you can realistically allocate towards saving.
                 
                 While creating a budget, it is crucial to strike a balance between necessary expenses and discretionary spending. Differentiate between needs and wants, and critically evaluate your spending patterns. Look for areas where you can reduce expenses, such as cutting down on dining out, finding more affordable alternatives for everyday items, or renegotiating service contracts. Even small adjustments can yield significant savings over time.
                 
                 Automating Savings:
                 One of the most effective strategies for successful saving is automating the process. Take advantage of online banking and automatic transfer features to designate a specific portion of your income to be deposited directly into a separate savings account. By automating your savings, you remove the temptation to spend the allocated funds impulsively and create a disciplined approach to building wealth.
                 
                 Automating savings not only simplifies the saving process but also reinforces the habit. Treat your savings contribution as a non-negotiable expense, similar to paying bills or rent. Make it a priority to consistently contribute to your savings account, regardless of the amount. Over time, these incremental contributions will accumulate and yield substantial results.
                 
                 Embracing Frugality and Mindful Spending:
                 Another vital component of the art of saving money is embracing frugality and adopting mindful spending habits. Frugality does not imply deprivation or sacrificing your quality of life; instead, it entails making conscious choices and being intentional with your spending. Consider alternatives to expensive indulgences, prioritize experiences over material possessions, and find satisfaction in simple pleasures.
                 
                 Mindful spending involves assessing your purchases and evaluating their alignment with your values and long-term goals. Before making a purchase, ask yourself if it contributes to your overall well-being and aligns with your priorities. By reframing your perspective on spending, you can redirect funds towards saving, investing, or experiences that bring you genuine happiness and fulfillment.
                 
                 Seeking Professional Guidance:
                 For individuals who require additional support or guidance in saving money, seeking assistance from financial professionals can be invaluable. Financial advisors or coaches can provide personalized insights, offer strategies tailored to your circumstances, and help you overcome financial obstacles. They can assist with creating a comprehensive financial plan, optimizing your saving strategies, and navigating complex financial landscapes.
                 
                 The art of saving money is a transformative skill that nurtures financial wellness, builds resilience, and sets the stage for a brighter future. By setting clear saving goals, crafting a realistic budget, automating savings, embracing frugality and mindful spending, and seeking professional guidance when needed, you can embark on a successful saving journey. Cultivate effective saving habits, and unlock the power of financial freedom and abundance in your life.
                 """)
                .padding(.horizontal)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                }
                .padding()
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double(hex & 0xff) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}


struct ArticleViewMac_Previews: PreviewProvider {
    static var previews: some View {
        ArticleViewMac()
    }
}
