package com.gerantech.towercraft.models
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Textures
	{
		[Embed(source="../assets/images/digits.fnt", mimeType="application/octet-stream")]
		public static const FontXml:Class;
		[Embed(source="../assets/images/digits.png")]
		public static const FontTexture:Class;
		
		private static var fonts:Dictionary = new Dictionary();

		
		public static function getFont(name:String="font"):BitmapFont
		{
			if (fonts[name] == undefined)
			{
				var texture:Texture = Texture.fromEmbeddedAsset(FontTexture);
				var xml:XML = XML(new FontXml());
				fonts[name] = new BitmapFont(texture, xml);
			}
			return fonts[name];
		}
		
		
		/*[Embed(source="../assets/images/tower-type-0.png")]
		public static const tower_type_0:Class;
		[Embed(source="../assets/images/tower-type-1.png")]
		public static const tower_type_1:Class;
		[Embed(source="../assets/images/tower-type-2.png")]
		public static const tower_type_2:Class;
		[Embed(source="../assets/images/tower-type-3.png")]
		public static const tower_type_3:Class;
		[Embed(source="../assets/images/tower-type-4.png")]
		public static const tower_type_4:Class;
		[Embed(source="../assets/images/tower-type-5.png")]
		public static const tower_type_5:Class;
		[Embed(source="../assets/images/ground.png")]
		public static const ground:Class;
		[Embed(source="../assets/images/arrow.png")]
		public static const arrow:Class;*/
		private static var allTextures:Dictionary = new Dictionary();
		
		
		
		/**
		 * Texture Atlas 
		 */
		[Embed(source="../assets/images/skin.png")]
		public static const skinAtlasTexture:Class;
		[Embed(source="../assets/images/skin.xml", mimeType="application/octet-stream")]
		public static const skinAtlasXml:Class;

		private static var allTextureAtlases:Dictionary = new Dictionary();

		
		/**
		 * Returns a texture from this class based on a string key.
		 * @param name A key that matches a static constant of Bitmap type.
		 * @return a starling texture.
		 */
		private static function getTextureByBitmap(name:String):Texture
		{
			if (allTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Textures[name]();
				allTextures[name] = Texture.fromBitmap(bitmap);
			}
			return allTextures[name];
		}
		
		/**
		 * Returns the Texture atlas instance.
		 * @return the TextureAtlas instance (there is only oneinstance per app)
		 */
		private static function getAtlas(name:String):TextureAtlas
		{
			if (allTextureAtlases[name] == undefined)
			{
				var texture:Texture = getTextureByBitmap(name+"AtlasTexture");
				var xml:XML = XML(new Textures[name+"AtlasXml"]);
				allTextureAtlases[name] = new TextureAtlas(texture, xml);
			}
			return allTextureAtlases[name];
		}
		
		/**
		 * Returns a texture from this class based on a string key.
		 * @param name A key that found a texture from atlas.
		 * @return the Texture instance (there is only oneinstance per app).
		 */
		public static function get(name:String, atlasName:String ="skin" ):Texture
		{
			return getAtlas(atlasName).getTexture(name);
		} 
		/*public static function get(name:String):Texture
		{
			if (allTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Textures[name]();
				allTextures[name] = Texture.fromBitmap(bitmap);
			}
			return allTextures[name];
		}*/


	}
}