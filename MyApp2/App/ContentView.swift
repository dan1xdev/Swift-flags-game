import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["UK", "USA", "Bangladesh", "Germany", "Argentina", "Brazil", "Canada", "Greece","Russia", "Sweden"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTittle = ""
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.gray, .gray]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack{
                    Text("Выбери флаг: ")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3){ number in
                    Button(action: {
                        self.flagTapped(number) //на настройку алерта(правльно/неправильно)
                        self.showingScore=true //на вывод алерта
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 130)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 5).shadow(radius: 2))
                                }
                    }
                
            Text("Общий счет: \(score)").foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
                }

        }.alert(isPresented: $showingScore){ //тут написал что алерт сработает если шовскор тру, то есть кнопка нажата
            Alert(title: Text(scoreTittle), message: Text("Общий счет: \(score)"), dismissButton: .default(Text("Продолжить")){
                self.askQuestion() //перемешивание флагов
            })
        }
        }
        func askQuestion(){ //перемешал
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    func flagTapped(_ number: Int){ //функция для настройки алерта в случае правильного или неправильного ответа
        if number == correctAnswer{
            scoreTittle = "Правильный ответ!"
            score += 1
        } else{
            scoreTittle = "Неправильно! Это флаг \(countries[number])"
            score-=1
        }
    }
        }



#Preview {
    ContentView()
}
