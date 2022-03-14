package;
import openfl.utils.Assets;
class PathsAndStuff
{
    public static inline function grabText(filename:String)
        {
            if (Assets.exists('assets/data/' + filename))
                return Assets.getText('assets/data/' + filename);
            else {
                trace('File not found: ' + filename);
                return null;
            }
        }
    public static inline function exists(filename:String)
        {
            return Assets.exists('assets/' + filename);
        }
}