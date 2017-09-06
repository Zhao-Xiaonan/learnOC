#import "SpaceShip.h"

@interface Spaceship()
{
	int i;
	Wormhole *_nearestWormhole1;
}
//decleration private method
@property (nonatomic,strong)Wormhole *nearestWormhole;

@end


@implementation SpaceShip

//imlementation public/private method 

@synthesize topSpeed = _topSpeed;
@synthesize nearestWormhole = _nearestWormhole

//property
- (void)setTopSpeed:(double)percentSpeedOfLight
{
	if (/* condition */)
	{
		_topSpeed = percentSpeedOfLight;
	}
	
}

- (double)topSpeed
{
	return _topSpeed;
}


- (void)robitPlanet:(Planet *)aPlanet atAltitude:(double)km
{
	double speed = [self topSpeed];//[]发送消息，调取自己的getter接口，self是指向自己的指针
	if[speed > MAX_RELATIVE] speed = MAX_RELATIVE;
	[[self nearestWormhole] travelToPlanet:aPlanet
									atSpeed:speed];

	
	//重写了setter之后，调用重写的setter							
	self.speed = 3.0;
	//默认函数的实现
	self->_topSpeed = 3.0;
}

@end