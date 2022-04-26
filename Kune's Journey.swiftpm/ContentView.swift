import SwiftUI
import SpriteKit

struct ContentView: View {
    init(){
//        MyFonts.registerFonts()
    }
    var scene : StartGame{
        let scene = StartGame(fileNamed: "StartGame")
        scene?.scaleMode = .aspectFit
        return scene!
    }
    var scene1 : Scene1{
        let scene = Scene1(fileNamed: "Scene1")
        scene?.scaleMode = .aspectFit
        return scene!
    }
    var scene3 : Scene3{
        let scene = Scene3(fileNamed: "Scene3")
        scene?.scaleMode = .aspectFit
        return scene!
    }
    var body: some View {
        ZStack{
            SpriteView(scene: scene).ignoresSafeArea()
        }
    }
}
