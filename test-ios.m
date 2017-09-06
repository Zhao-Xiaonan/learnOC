//set 
CGContextSetLineWidth(context,1.0);//line width in point
CGContextSetFillPattern(context,(CGPatternRef)pattern,(CGFoat[])components);

//push && pop 
//调用子函数时，有可能会改变context
- (void)drawGreenCircle:(CGContextRef)ctxt{
	UIGraphicsPushContext(ctxt);
	[[UIColor greenColor] setFill];
	//draw my circle
	UIGraphicsPopContext();
}
-(void)drawRect:(CGRect)aRect{
	CGContextRef context = UIGraphicsGetCurrentContext();
	[[UIColor redColor] setFill];
	//do some stuff
	[self drawGreenCircle:context];
	//do more stuff and expect fill to be red
	
}


//UIButton
avatarImage = [UIButton buttonWithType:UIButtonTypeCustom];
//给按钮加一个白色的板框
avatarImage.layer.borderColor = [[UIColor whiteColor] CGColor];
avatarImage.layer.borderWidth = 1.0f;
//给按钮设置弧度,这里将按钮变成了圆形
avatarImage.layer.cornerRadius = 25.0f;
avatarImage.backgroundColor = [UIColor redColor];
avatarImage.layer.masksToBounds = YES;
