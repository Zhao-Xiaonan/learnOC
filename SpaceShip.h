#import "Vehicle.h"				//Superclass
#import "Planet.h"

//接口关键字
@interface Spaceship:Vehicle


//deceration public method

//设置了setter和getter的方法，不是线程安全的
//如果不声明nonatomic则是线程安全的
@property (nonatomic) double topSpeed;

//name------robitPlanet:atAltitude
//argrument-----aplanet,km
- (void)robitPlanet:(Planet *)aPlanet
		atAltitude:(double)km;

+ (void)test:(NSString *)str;

//属性，property double topSpeed
//-(void)setTopSpeed:(double)percentSpeedOfLight;
//-(double)topSpeed;

@end