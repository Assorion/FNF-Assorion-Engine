package ui;

import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import openfl.utils.Assets;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
#if desktop
import sys.FileSystem;
#end

using StringTools;

// YAY IT NO LONGER SUCKS!!!

#if !debug @:noDebug #end
#if desktop
class CachingState extends MusicBeatState {
    public static inline var barWidth:Int = 1150;
    public static inline var barTopLn:Int = 150; 
    public static inline var inBarWidth:Int = 1120;
    public static inline var inBarTopLn:Int = 120;

    private var loadingBarBG:FlxSprite;
    private var loadingBarPC:FlxSprite;
    private var keepGraphic:BitmapData;

    public var objects:Array<String> = [];

    private function findItems(path:String){
        var keepDirectories:Array<String> = [];
        var itemsInDir:Array<String> = FileSystem.readDirectory(path);

        for(i in 0...itemsInDir.length){
            var curItem:String = path + itemsInDir[i];

            if(FileSystem.isDirectory(curItem)){
                keepDirectories.push(curItem + '/');
                continue;
            }
            if(!Assets.exists(curItem)) continue;

            objects.push(curItem);
        }
        for(i in 0...keepDirectories.length)
            findItems(keepDirectories[i]);
    }

    public override function create(){
        FlxG.mouse.visible =
        persistentUpdate =
        correctMusic = false;

        findItems('assets/');

        var lbBG:BitmapData = new BitmapData(barWidth, barTopLn, true);
        lbBG.fillRect(new Rectangle(0 , 0 , barWidth   , barTopLn), 0xFFFFFFFF);
        lbBG.fillRect(new Rectangle(10, 10, barWidth-20, barTopLn-20), 0);

        keepGraphic = new BitmapData(inBarWidth, inBarTopLn, true);
        keepGraphic.fillRect(new Rectangle(0,0,inBarWidth,inBarTopLn), 0);

        loadingBarBG = new FlxSprite(0,0).loadGraphic(lbBG);
        loadingBarBG.antialiasing = Settings.pr.antialiasing;
        loadingBarBG.screenCenter();

        loadingBarPC = new FlxSprite(0,0).loadGraphic(keepGraphic);
        loadingBarPC.antialiasing = Settings.pr.antialiasing;
        loadingBarPC.screenCenter();
        add(loadingBarBG);
        add(loadingBarPC);

        super.create();
    }

    private inline function addAsset(objectPath:String, objFormat:String)
        switch(objFormat){
            case 'png':
                var tmpImg:FlxSprite = new FlxSprite(0,0).loadGraphic(objectPath);
                    tmpImg.graphic.persist = true;
                    tmpImg.graphic.destroyOnNoUse = false;
                add(tmpImg);
                remove(tmpImg);
            case 'xml':
                var tmpImg:FlxSprite = new FlxSprite(0,0);
                    tmpImg.frames = Paths.lSparrow(objectPath.substring(0, objectPath.length - 4), '');
                    tmpImg.graphic.persist = true;
                    tmpImg.graphic.destroyOnNoUse = false;
                add(tmpImg);
                remove(tmpImg);
            
            // since web browser doesn't work, we can just use this
            case 'ogg':
                var sound:FlxSound = new FlxSound().loadEmbedded(objectPath);
                    sound.volume = 0;
                    sound.play();
                    sound.stop();
            case 'txt', 'json':
                Paths.cLT(objectPath, '');
        }

    var index:Int = 0;
    override function update(elapsed:Float){
        if(index == objects.length - 1){
            objects = null;
            FlxG.switchState(new ui.TitleState());
            
            return;
        }
        
        var obj:String = objects[index];
        trace('Caching: $obj');

        // in case somehow it has multiple dots
        var tmp = obj.split('.');
        var ending:String = tmp[tmp.length - 1];

        addAsset(obj, ending);
        index++;

        // asthetic stuff. Please ignore
        var percent:Float = index / (objects.length - 1);

        var selColour:Int = FlxColor.fromRGB(
            Math.round(percent * 255), 
            180 + Math.round(75 * percent), 
            155 + Math.round(100 * percent)
        );

        keepGraphic.fillRect(new Rectangle(0,0,   Math.round(percent * inBarWidth), inBarTopLn), selColour);
        FlxG.camera.bgColor = FlxColor.fromRGB(0, Math.round(percent * 120), Math.round(percent * 103));
    }
}
#end