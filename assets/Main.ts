import {
    _decorator,
    Component,
    Node,
    native,
    assetManager,
    ImageAsset,
    SpriteFrame,
    Texture2D,
    Sprite,
    path,
} from "cc";
const { ccclass, property } = _decorator;

@ccclass("Main")
export class Main extends Component {
    @property({ type: Node })
    profilePhoto: Node = null;
    filePath: string = null;
    start() {}
    btnClicked() {
        console.log("btn clicked");
        var downLoadPath = native.reflection.callStaticMethod(
            "AppDelegate",
            "openGallery:andContent:",
            "https://drive.google.com/uc?export=download&id=14MVx2mgsInNdfYx8jQ-6QwwgbPASpxQt",
            "Yes! you call a Native UI from Reflection"
        );
        this.filePath = downLoadPath;
    }
    photos() {
        console.log("photos clicked");
        var downLoadPath = native.reflection.callStaticMethod(
            "AppDelegate",
            "openCamera:andContent:",
            "https://drive.google.com/uc?export=download&id=14MVx2mgsInNdfYx8jQ-6QwwgbPASpxQt",
            "Yes! you call a Native UI from Reflection"
        );
    }

    addImagePhoto() {
        console.log(this.filePath);
        var pathTemp = this.filePath;
        pathTemp = pathTemp.substring(8);

        console.log(pathTemp);
        this.filePath = native.reflection.callStaticMethod(
            "AppDelegate",
            "getPath:andContent:",
            `${pathTemp}`,
            "Yes! you call a Native UI from Reflection"
        );
        // console.log(this.filePath);
        pathTemp = pathTemp.concat(this.filePath);
        console.log("final path ");
        console.log(pathTemp);

        assetManager.loadRemote<ImageAsset>(pathTemp, (err, imageAsset) => {
            if (err) {
                console.log("ERROR");
                console.log(JSON.stringify(err));
                return;
            }
            console.log("NO ERROR");
            const spriteFrame = new SpriteFrame();
            const texture = new Texture2D();
            texture.image = imageAsset;
            spriteFrame.texture = texture;
            console.log("SPRITE", imageAsset);
            this.profilePhoto.getComponent(Sprite).spriteFrame = spriteFrame;
            //this.node.getComponent(Sprite).spriteFrame = spriteFrame;
        });
    }

    update(deltaTime: number) {}
}
