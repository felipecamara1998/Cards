//
//  Cards.swift
//  Cards
//
//  Created by Felipe Camara on 16/10/21.
//

import SwiftUI

struct CardsAlternativas: View {
    
    let coreDM: QuestionsCDManager
    @State var teste: Bool?
    @State var tela = false
    @State var porcentagem = ""
    @State var start = true
    
    private func testarPorcentagem(acertos: Double, tentativas: Double) -> Double {
    	if tentativas == 0 {
            return Double(0)
        } else {
            return (Double(acertos) / Double(tentativas)) * 100
        }
    }
    
    var body: some View {
        
        let actual = coreDM.randomPickQuestion()
        let porcentagem = String(format: "%.2f", (Double(actual!.acertos) / Double(actual!.tentativas)) * 100)
        if tela == false {
        
            VStack(alignment: .center, spacing:10){
                Spacer()
            
            HStack{
                
                Spacer()
                
            	Text("Rate: " + porcentagem + "%")
                	.font(.subheadline)
                	.frame(width: 150, height: 30, alignment: .center)
                    .background(Color(.white))
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .offset(x: -20, y: 0)

                Spacer()
                	
                NavigationLink("Ref.", destination:
                                VStack(alignment: .leading) {
                            if #available(iOS 14.0, *) {
                                VStack{
                                    Text((actual?.ref)!)
                                    .fontWeight(.semibold)
                                    .offset(x: 10, y: 10)
                                    .font(.title2)
                                Spacer()
                                }
                                .frame(width: 335, height: 680, alignment: .leading)
                                .padding(20)
                                
                            } else {
                                // Fallback on earlier versions
                            }
                            
                            Spacer()
                            
                                }.frame(width: 350, height: 700, alignment: .leading)
                                .background(Color(#colorLiteral(red: 0.4904763699, green: 0.8657391667, blue: 1, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                .shadow(color: .gray, radius: 10, x: 10, y: 10)
                )
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 60, height: 30, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.4904763699, green: 0.8657391667, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                )
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
                Spacer()
                 
            }
            
            Text((actual?.pergunta)!)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .frame(maxWidth: 400, minHeight: 60, maxHeight: 120)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8664111495, green: 0.8646816015, blue: 0.8928973079, alpha: 1)), Color(#colorLiteral(red: 0.9949908853, green: 0.9871428609, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                )
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), radius: 6, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
                .padding(20)

                VStack(alignment: .leading, spacing: 30)
                {
                    Button("A)" + "\((actual?.a)!)", action: {
                        teste = verificarResposta(selecionada: "A", correta: (actual?.certa)!)
                        coreDM.atualizarEstatisticas(correçao: teste!, questao: actual!)
                        tela = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            tela = false
                        }
                    })
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .frame(maxWidth: 380, minHeight: 65)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2052192986, green: 0.6120069027, blue: 0.9396465421, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .padding(10)
                    
                    Button("B)" + "\((actual?.b)!)", action: {
                        teste = verificarResposta(selecionada: "B", correta: (actual?.certa)!)
                        coreDM.atualizarEstatisticas(correçao: teste!, questao: actual!)
                        tela = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            tela = false
                        }
                    })
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .frame(maxWidth: 380, minHeight: 65)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2052192986, green: 0.6120069027, blue: 0.9396465421, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .padding(8)
                    
                    Button("C)" + "\((actual?.c)!)", action: {
                        teste = verificarResposta(selecionada: "C", correta: (actual?.certa)!)
                        coreDM.atualizarEstatisticas(correçao: teste!, questao: actual!)
                        tela = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            tela = false
                        }
                    })
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .frame(maxWidth: 380, minHeight: 65)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2052192986, green: 0.6120069027, blue: 0.9396465421, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .padding(8)
                    
                    Button("D)" + "\((actual?.d)!)", action: {
                        teste = verificarResposta(selecionada: "D", correta: (actual?.certa)!)
                        coreDM.atualizarEstatisticas(correçao: teste!, questao: actual!)
                        tela = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            tela = false
                        }
                    })
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .frame(maxWidth: 380, minHeight: 65)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2052192986, green: 0.6120069027, blue: 0.9396465421, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .padding(8)
                    
                }
                .foregroundColor(.black)
                Spacer()
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(
            
        	Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.7012532353, green: 0.6957245469, blue: 0.7054808736, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom)
                )
            
        )
            
        } else {
            if teste == true {
                VStack{
                Text("Right!")
                    .font(.largeTitle)
                    .foregroundColor(Color(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)))
                    .bold()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.7881746292, green: 0.9608092904, blue: 0.6588472724, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                        )
                )
                    
            } else {
                VStack{
                Text("Wrong!")
                    .font(.largeTitle)
                    .foregroundColor(Color(#colorLiteral(red: 0.7503991723, green: 0, blue: 0, alpha: 1)))
                    .bold()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.7701181769, blue: 0.8123152852, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                        )
                )
                    
            }
        }
    }
    }
    
    func verificarResposta (selecionada: String, correta: String) -> Bool {
        if selecionada == correta {
            return true
        } else {
            return false
        }
    }
    
        

struct CardsAlternativas_Previews: PreviewProvider {
    static var previews: some View {
        CardsAlternativas(coreDM: QuestionsCDManager())
    }
}
