
package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import Discord.DiscordClient;

using StringTools;

class AchievementState extends MusicBeatState
{
		var Amount:Int = 0;
		var curSelected:Int = 0;
		var PerfectCollection:Bool = false;

	override function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue', 'preload'));
		bg.screenCenter();
		add(bg);
	
		if (FlxG.save.data.LoseToBarb == true)
		{
				var dabadge:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('badges/BarbLose'));
				dabadge.antialiasing = true;
				dabadge.scrollFactor.set(0.9, 0.9);
				dabadge.active = false;
				dabadge.x = 250;
				dabadge.y = -65;
				dabadge.setGraphicSize(Std.int(dabadge.width / 2.1));
				add(dabadge);
				Amount += 1;
		}

	if (Amount == 32)
		{
			PerfectCollection = true;	
		}
	
		var txt:FlxText = new FlxText(0, 0, FlxG.width, "Amount Of Achievements Out Of 32: " + Amount, 24);
			txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
			txt.borderColor = FlxColor.BLACK;
			txt.borderSize = 3;
			txt.borderStyle = FlxTextBorderStyle.OUTLINE;
			txt.screenCenter();
			txt.y -= 275;
			add(txt);


			if (PerfectCollection == true)
			{
				#if windows
				// Updating Discord Rich Presence
				DiscordClient.changePresence("Viewing Their Achievements (Perfect Collection)", null);
				#end
			}
				else
			{
				#if windows
				// Updating Discord Rich Presence
				DiscordClient.changePresence("Viewing Their Achievements " + Amount, null);
				#end	
			}
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.switchState(new MainMenuState());
		}

		if (controls.BACK)
			{
				//leftState = true;
				FlxG.switchState(new MainMenuState());
			}

		super.update(elapsed);
	}
}