#import "cocos2d.h"

#import "ParticleEditor.h"

@implementation ParticleEditor

-(id) init
{
    if ((self == [super initWithStyle:UITableViewStyleGrouped])) {
        [self loadEditor];
        self.title = @"Editor";

        // right button
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Random" style:UIBarButtonItemStylePlain target:self action:@selector(randomize)] autorelease];
        //self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editRows)] autorelease];
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [m_componentManager setIsVisible:YES];
    [m_componentManager anyValueChanged];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [m_componentManager setIsVisible:NO];
}

-(void) unloadEditor
{
    if (m_componentManager) {
        [m_componentManager release];
        m_componentManager = nil;
    }
}

-(void) randomize
{
    [m_componentManager randomize];
}

-(void) loadEditor
{
    if (m_componentManager) {
        [m_componentManager release];
        m_componentManager = nil;
    }
    
    // add all the editable components
    m_componentManager = [[ParticleEditorComponentManager alloc] init];
    
    // base section
    ParticleEditorSection* base = [m_componentManager addSectionWithName:@"Base"];
    
    ParticleEditorComponent* name = [base addComponentWithName:@"Name" key:@"name"];
    [name setTextInputWithDefault:@"My New Particle"];
    m_name = name;
    
    ParticleEditorComponent* maxParticles = [base addComponentWithName:@"Max Particles" key:@"maxParticles"];
    [maxParticles setSliderWithMin:0 andMax:5000 andRespectMin:YES];
    
    ParticleEditorComponent* type = [base addComponentWithName:@"Particle Type" key:@"emitterType"];
    NSArray* typeNames = [NSArray arrayWithObjects:@"Gravity", @"Radius", nil];
    NSArray* typeValues = [NSArray arrayWithObjects:[NSNumber numberWithInt:kCCParticleModeGravity], [NSNumber numberWithInt:kCCParticleModeRadius], nil];
    [type setSegmentedControlWithChoices:[NSArray arrayWithObjects:typeNames, typeValues, nil]];
    
    ParticleEditorComponent* duration = [base addComponentWithName:@"System Duration" key:@"duration"];
    [duration setSliderWithMin:0 andMax:50 andRespectMin:YES];
    
    ParticleEditorComponent* life = [base addComponentWithName:@"Particle Lifespan" key:@"particleLifespan"];
    [life setSliderWithMin:0 andMax:50 andRespectMin:YES];
    ParticleEditorComponent* lifev = [base addComponentWithName:@"Particle Lifespan Variance" key:@"particleLifespanVariance"];
    [lifev setSliderWithMin:0 andMax:50 andRespectMin:YES];
    
    ParticleEditorComponent* eRate = [base addComponentWithName:@"Emission Rate" key:@"emissionRate"];
    [eRate setSliderWithMin:0 andMax:1000 andRespectMin:YES];
    
    
    // gravity mode
    ParticleEditorSection* gravity = [m_componentManager addSectionWithName:@"Gravity Mode"];
    
    ParticleEditorComponent* gravX = [gravity addComponentWithName:@"Gravity X" key:@"gravityx"];
    [gravX setSliderWithMin:-1000 andMax:1000];
    ParticleEditorComponent* gravY = [gravity addComponentWithName:@"Gravity Y" key:@"gravityy"];
    [gravY setSliderWithMin:-1000 andMax:1000];
    
    ParticleEditorComponent* speed = [gravity addComponentWithName:@"Speed" key:@"speed"];
    [speed setSliderWithMin:-1000 andMax:1000];
    ParticleEditorComponent* speedv = [gravity addComponentWithName:@"Speed Variance" key:@"speedVariance"];
    [speedv setSliderWithMin:0 andMax:1000 andRespectMin:YES];
    
    ParticleEditorComponent* tanga = [gravity addComponentWithName:@"Tangential Acceleration" key:@"tangentialAcceleration"];
    [tanga setSliderWithMin:-1000 andMax:1000];
    ParticleEditorComponent* tangav = [gravity addComponentWithName:@"Tangential Acceleration Variance" key:@"tangentialAccelVariance"];
    [tangav setSliderWithMin:0 andMax:1000 andRespectMin:YES];
    
    ParticleEditorComponent* rada = [gravity addComponentWithName:@"Radial Acceleration" key:@"radialAcceleration"];
    [rada setSliderWithMin:-1000 andMax:1000];
    ParticleEditorComponent* radav = [gravity addComponentWithName:@"Radial Acceleration Variance" key:@"radialAccelVariance"];
    [radav setSliderWithMin:0 andMax:1000 andRespectMin:YES];
    
    
    // radius mode
    ParticleEditorSection* radius = [m_componentManager addSectionWithName:@"Radius Mode"];
    
    ParticleEditorComponent* startradius = [radius addComponentWithName:@"Max Radius" key:@"maxRadius"];
    [startradius setSliderWithMin:0 andMax:1000 andRespectMin:YES];
    ParticleEditorComponent* startradiusv = [radius addComponentWithName:@"Max Radius Variance" key:@"maxRadiusVariance"];
    [startradiusv setSliderWithMin:0 andMax:1000 andRespectMin:YES];
    
    ParticleEditorComponent* endradius = [radius addComponentWithName:@"Min Radius" key:@"minRadius"];
    [endradius setSliderWithMin:0 andMax:1000 andRespectMin:YES];
    
    ParticleEditorComponent* rps = [radius addComponentWithName:@"Rotation Per Second" key:@"rotatePerSecond"];
    [rps setSliderWithMin:-360 andMax:360];
    ParticleEditorComponent* rpsv = [radius addComponentWithName:@"Rotation Per Second Variance" key:@"rotatePerSecondVariance"];
    [rpsv setSliderWithMin:0 andMax:360 andRespectMin:YES];
    
    
    // position
    ParticleEditorSection* position = [m_componentManager addSectionWithName:@"Start Position"];
    
    ParticleEditorComponent* startPositionX = [position addComponentWithName:@"X" key:@"sourcePositionx"];
    [startPositionX setSliderWithMin:-500 andMax:500];
    ParticleEditorComponent* startPositionXV = [position addComponentWithName:@"X Variance" key:@"sourcePositionVariancex"];
    [startPositionXV setSliderWithMin:0 andMax:500 andRespectMin:YES];
    
    ParticleEditorComponent* startPositionY = [position addComponentWithName:@"Y" key:@"sourcePositiony"];
    [startPositionY setSliderWithMin:-500 andMax:500];
    ParticleEditorComponent* startPositionYV = [position addComponentWithName:@"Y Variance" key:@"sourcePositionVariancey"];
    [startPositionYV setSliderWithMin:0 andMax:500 andRespectMin:YES];
    
    
    // spin & angle
    ParticleEditorSection* spinangle = [m_componentManager addSectionWithName:@"Spin & Angle"];
    
    ParticleEditorComponent* angle = [spinangle addComponentWithName:@"Angle" key:@"angle"];
    [angle setSliderWithMin:-360 andMax:360];
    ParticleEditorComponent* anglev = [spinangle addComponentWithName:@"Angle Variance" key:@"angleVariance"];
    [anglev setSliderWithMin:0 andMax:360 andRespectMin:YES];
    
    ParticleEditorComponent* startspin = [spinangle addComponentWithName:@"Start Spin" key:@"rotationStart"];
    [startspin setSliderWithMin:-1000 andMax:1000];
    ParticleEditorComponent* startspinv = [spinangle addComponentWithName:@"Start Spin Variance" key:@"rotationStartVariance"];
    [startspinv setSliderWithMin:0 andMax:1000 andRespectMin:YES];
    
    ParticleEditorComponent* endspin = [spinangle addComponentWithName:@"End Spin" key:@"rotationEnd"];
    [endspin setSliderWithMin:-1000 andMax:1000];
    ParticleEditorComponent* endspinv = [spinangle addComponentWithName:@"End Spin Variance" key:@"rotationEndVariance"];
    [endspinv setSliderWithMin:0 andMax:1000 andRespectMin:YES];
    
    
    // size
    ParticleEditorSection* size = [m_componentManager addSectionWithName:@"Size"];
    
    ParticleEditorComponent* startsize = [size addComponentWithName:@"Start Size" key:@"startParticleSize"];
    [startsize setSliderWithMin:0 andMax:200 andRespectMin:YES];
    ParticleEditorComponent* startsizev = [size addComponentWithName:@"Start Size Variance" key:@"startParticleSizeVariance"];
    [startsizev setSliderWithMin:0 andMax:200 andRespectMin:YES];
    
    ParticleEditorComponent* endsize = [size addComponentWithName:@"End Size" key:@"finishParticleSize"];
    [endsize setSliderWithMin:0 andMax:200 andRespectMin:YES];
    ParticleEditorComponent* endsizev = [size addComponentWithName:@"End Size Variance" key:@"finishParticleSizeVariance"];
    [endsizev setSliderWithMin:0 andMax:200 andRespectMin:YES];
    
    
    // start color
    ParticleEditorSection* startcolor = [m_componentManager addSectionWithName:@"Start Color"];
    
    ParticleEditorComponent* allParticlesSameColor = [startcolor addComponentWithName:@"All Particles Same Color" key:@"allParticlesSameColor"];
    [allParticlesSameColor setSegmentedControlWithChoices:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"No", @"Yes", nil], [NSArray arrayWithObjects:[NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES], nil], nil]];

    ParticleEditorComponent* startred = [startcolor addComponentWithName:@"Red" key:@"startColorRed"];
    [startred setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    ParticleEditorComponent* startredv = [startcolor addComponentWithName:@"Red Variance" key:@"startColorVarianceRed"];
    [startredv setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    
    ParticleEditorComponent* startblue = [startcolor addComponentWithName:@"Blue" key:@"startColorBlue"];
    [startblue setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    ParticleEditorComponent* startbluev = [startcolor addComponentWithName:@"Blue Variance" key:@"startColorVarianceBlue"];
    [startbluev setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    
    ParticleEditorComponent* startgreen = [startcolor addComponentWithName:@"Green" key:@"startColorGreen"];
    [startgreen setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    ParticleEditorComponent* startgreenv = [startcolor addComponentWithName:@"Green Variance" key:@"startColorVarianceGreen"];
    [startgreenv setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    
    ParticleEditorComponent* startalpha = [startcolor addComponentWithName:@"Alpha" key:@"startColorAlpha"];
    [startalpha setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    ParticleEditorComponent* startalphav = [startcolor addComponentWithName:@"Alpha Variance" key:@"startColorVarianceAlpha"];
    [startalphav setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    
    
    // finish color
    ParticleEditorSection* endcolor = [m_componentManager addSectionWithName:@"End Color"];
    
    ParticleEditorComponent* endcolorToggle = [endcolor addComponentWithName:@"Enabled" key:@"finishColorEnabled"];
    [endcolorToggle setSegmentedControlWithChoices:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"Off", @"On", nil], [NSArray arrayWithObjects:[NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES], nil], nil]];
    
    ParticleEditorComponent* endred = [endcolor addComponentWithName:@"Red" key:@"finishColorRed"];
    [endred setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    ParticleEditorComponent* endredv = [endcolor addComponentWithName:@"Red Variance" key:@"finishColorVarianceRed"];
    [endredv setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    
    ParticleEditorComponent* endblue = [endcolor addComponentWithName:@"Blue" key:@"finishColorBlue"];
    [endblue setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    ParticleEditorComponent* endbluev = [endcolor addComponentWithName:@"Blue Variance" key:@"finishColorVarianceBlue"];
    [endbluev setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    
    ParticleEditorComponent* endgreen = [endcolor addComponentWithName:@"Green" key:@"finishColorGreen"];
    [endgreen setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    ParticleEditorComponent* endgreenv = [endcolor addComponentWithName:@"Green Variance" key:@"finishColorVarianceGreen"];
    [endgreenv setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    
    ParticleEditorComponent* endalpha = [endcolor addComponentWithName:@"Alpha" key:@"finishColorAlpha"];
    [endalpha setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    ParticleEditorComponent* endalphav = [endcolor addComponentWithName:@"Alpha Variance" key:@"finishColorVarianceAlpha"];
    [endalphav setSliderWithMin:0 andMax:1 andScaleFlag:YES];
    
    
    ParticleEditorSection* texture = [m_componentManager addSectionWithName:@"Texture"];
    
    ParticleEditorComponent* textureName = [endcolor addComponentWithName:@"Texture Filename" key:@"textureFileName"];
    [textureName setTextInputWithDefault:@"fire.png"];
    
    ParticleEditorComponent* blendFuncSource = [texture addComponentWithName:@"Blend Func Sourc" key:@"blendFuncSource"];
    NSArray* bfsNames = [NSArray arrayWithObjects:@"GL 1", @"GL SRC ALPHA", nil];
    NSArray* bfsValues = [NSArray arrayWithObjects:[NSNumber numberWithInt:GL_ONE], [NSNumber numberWithInt:GL_SRC_ALPHA], nil];
    [blendFuncSource setSegmentedControlWithChoices:[NSArray arrayWithObjects:bfsNames, bfsValues, nil]];
    
    ParticleEditorComponent* blendFuncDest = [texture addComponentWithName:@"Blend Func Dest" key:@"blendFuncDestination"];
    NSArray* bfdNames = [NSArray arrayWithObjects:@"GL 1 - SRC ALPHA", @"GL 1 - SRC COLOR", nil];
    NSArray* bfdValues = [NSArray arrayWithObjects:[NSNumber numberWithInt:GL_ONE_MINUS_SRC_ALPHA], [NSNumber numberWithInt:GL_ONE_MINUS_SRC_COLOR], nil];
    [blendFuncDest setSegmentedControlWithChoices:[NSArray arrayWithObjects:bfdNames, bfdValues, nil]];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    return [m_componentManager getSectionCount];
}

-(NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    ParticleEditorSection* pSection = [m_componentManager getSection:section];
    return [pSection getComponentCount];
}

-(NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    ParticleEditorSection* pSection = [m_componentManager getSection:section];
    return pSection.m_name;
}

#define MAINLABEL_TAG 1
#define MAINWIDGET_TAG 2
#define MAINVALUE_TAG 3

-(UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    ParticleEditorSection* section = [m_componentManager getSection:indexPath.section];
    ParticleEditorComponent* component = [section getComponent:indexPath.row];

    //UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:component.m_componentType];
    UITableViewCell* cell = component.m_cell;
    if (cell) {
        return cell;
    }
    
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blah"] autorelease];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = component.m_name;

    UIView* widget = component.m_widget;
    if (widget) {
        // textLabel
        UILabel* name = [[[UILabel alloc] initWithFrame:CGRectMake(10, 5.0, cell.frame.size.width - 40, 25.0)] autorelease];
        name.tag = MAINLABEL_TAG;
        name.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        name.textColor = [UIColor blackColor];
        name.backgroundColor = [UIColor clearColor];
        name.font = [UIFont boldSystemFontOfSize:16.0];
        name.textAlignment = UITextAlignmentLeft;
        name.text = cell.textLabel.text;
        cell.textLabel.text = nil;
        [cell.contentView addSubview:name];

        CGFloat sizeMod = 0;

        // main widget
        widget.tag = MAINWIDGET_TAG;
        widget.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        CGRect frame = cell.contentView.frame;
        frame.origin.x = 10;
        frame.size.width = frame.size.width - frame.origin.x*2 - 80;
        frame.size.height = 35;
        frame.origin.y = name.frame.size.height + name.frame.origin.y - 5;
        if ([widget isMemberOfClass:[UITextField class]]) {
            frame.origin.y += 7;
        }
        else if ([widget isMemberOfClass:[UISegmentedControl class]]) {
            frame.origin.y += 10;
            sizeMod += 15;
        }
        widget.frame = frame;
        [cell.contentView addSubview:widget];
        
        // slide value widget
        UITextField* widgetValue = component.m_widgetValue;
        widgetValue.tag = MAINVALUE_TAG;
        widgetValue.frame = CGRectMake(frame.size.width + frame.origin.x*1.5, widget.frame.origin.y + 7, 80, frame.size.height);
        widgetValue.keyboardType = UIKeyboardTypeNumberPad;
        widgetValue.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        widgetValue.textAlignment = UITextAlignmentRight;
        widgetValue.textColor = [UIColor blackColor];
        widgetValue.backgroundColor = [UIColor clearColor];
        widgetValue.font = [UIFont systemFontOfSize:14.0];
        [cell.contentView addSubview:widgetValue];
        
        component.m_height = widget.frame.size.height + name.frame.size.height + sizeMod;
    }
    else {
        component.m_height = cell.contentView.bounds.size.height;
    }
    component.m_cell = cell;
    return cell;
}

-(CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self tableView:tableView cellForRowAtIndexPath:indexPath];
    ParticleEditorSection* section = [m_componentManager getSection:indexPath.section];
    ParticleEditorComponent* component = [section getComponent:indexPath.row];
    return component.m_height;
}

-(NSString*) getName
{
    if (m_name) {
        return [m_name getValue];
    }
    else {
        return @"No name set";
    }
}

-(NSDictionary*) toDict
{
    return [m_componentManager toDict];
}

-(void) readValuesFromDict:(NSDictionary*)dict
{
    [m_componentManager readValuesFromDict:dict];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(void) dealloc
{
    [m_componentManager release];
    m_componentManager = nil;
    [super dealloc];
}

@end
