// Frankenstein.hx
package;

/*
	Kind of just a brain for the enemies.
	Basically allows for there to be multiple "activity states". The rest is done in EnemyController.
 */
class Frankenstein
{
	public var activity:Float->Void;

	public function new(initialState:Float->Void)
	{
		activity = initialState;
	}

	public function update(elapsed:Float)
	{
		activity(elapsed);
	}
}
