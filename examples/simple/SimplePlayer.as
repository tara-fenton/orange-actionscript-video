package simple
{
	import com.factorylabs.orange.video.FVideo;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;

	/**
	 * Summary.
 	 * 
 	 * <p>Description.</p>
 	 *
 	 * <hr />
	 * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
	 * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
	 * 
	 * <p>Permission is hereby granted to use, modify, and distribute this file 
	 * in accordance with the terms of the license agreement accompanying it.</p>
 	 *
	 * @author		Grant Davis
	 * @version		1.0.0 :: Mar 2, 2010
	 */
	public class SimplePlayer 
		extends MovieClip
	{
		protected static const HOST							:String = "172.20.34.110/vod/stream";
		protected static const H264_1500k_MP4_RTMP_FILE		:String = "mp4:AdobeBand_1500K_H264";
		protected static const H264_800k_MP4_RTMP_FILE		:String = "mp4:AdobeBand_800K_H264";
		protected static const H264_1500k_HTTP_FILE		:String = "http://172.20.34.110/AdobeBand_640.flv";
		protected static const H264_800k_HTTP_FILE		:String = "http://172.20.34.110/sample.flv";
		
		private var _player		:FVideo;
	
		public function SimplePlayer()
		{
			stop();
			initialize();
		}
		
		public override function toString() :String 
		{
			return 'simple.SimplePlayer';
		}
		
		public function dispose() :void
		{
		}
		
		protected function initialize() :void
		{
			setStageModes();
			startup();
		}
		
		protected function setStageModes() :void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		protected function startup() :void
		{
			trace( "[SimplePlayer].startup()" );
			
			_player = new FVideo( this, { width:576, height:432, volume: .1 });
			
			this.graphics.beginFill( 0x333333 );
			this.graphics.drawRect( 0, 0, 576, 432);
			this.graphics.endFill();
			
//			_player.stateSignal.add( handleState );
			
//			testRTMP();
			testProgressive();
			
			buildUI();
		}
		
		//-----------------------------------------------------------------
		// Player State and Signals
		//-----------------------------------------------------------------
		
//		private function handleState( $state : String ) :void
//		{
//			trace( '[SimplePlayer].handleState() :: ' + $state );	
//		}
		
		
		//-----------------------------------------------------------------
		// Streaming Tests
		//-----------------------------------------------------------------
		
		private function testRTMP() :void
		{
//			_player.autoDetectBandwidth = false;
//			_player.connectSignal.add( playFileOnConnect );
			_player.connect( HOST );
			_player.play( H264_1500k_MP4_RTMP_FILE );
//			_player.pause();
//			setTimeout( testRTMP, 3000 );
//			setTimeout( playOtherRTMPFile, 6000 );
		}
		private function playFileOnConnect() :void
		{
			_player.play( H264_1500k_MP4_RTMP_FILE );
		}
		private function playOtherRTMPFile() :void
		{
			trace( '\n\n[SimplePlayer].playOtherRTMPFile()' );
			_player.connect( HOST );
			_player.play( H264_800k_MP4_RTMP_FILE );
		}
		
		
		//-----------------------------------------------------------------
		// Progressive Tests
		//-----------------------------------------------------------------
		
		private function testProgressive() :void
		{
//			_player.load( H264_1500k_MP4_HTTP_FILE );
//			setTimeout( _player.play, 2000 );
			_player.play( H264_1500k_HTTP_FILE );
//			_player.pause();
//			setTimeout( playOtherHTTPFile, 3000 );
		}
		private function playOtherHTTPFile() :void
		{
			_player.play( H264_800k_HTTP_FILE );
		}
		
		//-----------------------------------------------------------------
		// UI Helpers
		//-----------------------------------------------------------------
		
		private function buildUI() :void
		{
			var play : Sprite = buildButton( "Play", 596, 0 );
			var pause : Sprite = buildButton( "Pause", 596, play.y + play.height + 1 );
			var stop : Sprite = buildButton( "Stop", 596, pause.y + pause.height + 1 );
			play.addEventListener( MouseEvent.CLICK, handlePlayClick );
			pause.addEventListener( MouseEvent.CLICK, handlePauseClick );
			stop.addEventListener( MouseEvent.CLICK, handleStopClick );
		}
		private function handlePlayClick( $e :MouseEvent ) :void
		{
			_player.play();
		}
		private function handlePauseClick( $e :MouseEvent ) :void
		{
			_player.pause();
		}
		private function handleStopClick( $e :MouseEvent ) :void
		{
			_player.stop();
		}
		
		
		private function buildButton( $label :String, $x :int, $y :int ) :Sprite
		{
			var tf :TextField = new TextField();
			tf.embedFonts = false;
			tf.defaultTextFormat = new TextFormat( "Arial", 12, 0x000000 );
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			tf.text = $label;
			
			var sprite :Sprite = new Sprite();
			sprite.addChild( tf );
			sprite.x = $x;
			sprite.y = $y;
			sprite.buttonMode = true;
			sprite.mouseChildren = false;
			sprite.mouseEnabled = true;
			sprite.graphics.beginFill( 0x666666 );
			sprite.graphics.drawRect(0, 0, tf.width, tf.height);
			sprite.graphics.endFill();
			this.addChild( sprite );
			return sprite;
		}
		
	}
}