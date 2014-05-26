//
//  NSObject+RuntimeMethods.m
//
//  Created by Yang Xudong.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "NSObject+RuntimeMethods.h"
#import <objc/message.h>

@implementation NSObject (RuntimeMethods)

-(NSArray *)propertyList
{
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++)
    {
        const char *propertyName = property_getName(properties[i]);
        
        [list addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    if (list.count)
    {
        return list;
    }
    
    return nil;
}

-(NSDictionary *)propertyValues
{
    NSArray *propertyList = [self propertyList];
    
    if (!propertyList || !propertyList.count)
    {
        return nil;
    }
    
    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionaryWithCapacity:propertyList.count];
    
    for (NSString *valueKey in propertyList)
    {
        id value = [self valueForKey:valueKey];
        
        if (value)
        {
            [propertyValues setObject:value forKey:valueKey];
        }
    }
    
    if (propertyValues.count)
    {
        return propertyValues;
    }
    
    return nil;
}

-(NSDictionary *)allPropertyValues
{
    NSArray *propertyList = [self propertyList];
    
    if (!propertyList || !propertyList.count)
    {
        return nil;
    }
    
    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionaryWithCapacity:propertyList.count];
    
    for (NSString *valueKey in propertyList)
    {
        id value = [self valueForKey:valueKey];
        
        if (!value)
        {
            value = [NSNull null];
        }
        
        [propertyValues setObject:value forKey:valueKey];
    }
    
    return propertyValues;
}

-(void)voluationWithData:(id)data
{
    NSArray *propertyList = [self propertyList];
    
    if (!propertyList || !propertyList.count || !data || [data isKindOfClass:[NSNull class]])
    {
        return;
    }
    
    for (NSString *valueKey in propertyList)
    {
        BOOL valid;
        
        if ([data isKindOfClass:[NSDictionary class]])
        {
            valid = ([data valueForKey:valueKey] == nil)?NO:YES;
        }
        else
        {
            valid = [data respondsToSelector:NSSelectorFromString(valueKey)];
        }
        
        if (valid)
        {
            id value = [data valueForKey:valueKey];
            
            if (value && ![value isKindOfClass:[NSNull class]])
            {
                [self setValue:value forKey:valueKey];
            }
        }
    }
}

-(NSArray *)methodList
{
    unsigned int count;
    
    Method *methods = class_copyMethodList([self class], &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++)
    {
        NSString *methodName = NSStringFromSelector(method_getName(methods[i]));
        
        [list addObject:methodName];
    }
    
    if (list.count)
    {
        return list;
    }
    
    return nil;
}

-(NSArray *)ivarList
{
    unsigned int count;
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++)
    {
        const char *ivarName = ivar_getName(ivars[i]);
        
        [list addObject:[NSString stringWithUTF8String:ivarName]];
    }
    
    if (list.count)
    {
        return list;
    }
    
    return nil;
}

-(NSString *)getdescriptionOfobject:(id)object
{
    
    NSString  *strInfo = nil;
#if DEBUG
    const char *className = class_getName([object class]);
    NSString  *strClassName = [NSString stringWithCString:className encoding:NSUTF8StringEncoding];
    
    strInfo = [NSString stringWithFormat:@"baseclass:%@ <<%p>> %d",strClassName,object,__LINE__];
    
    //  @encode(NSDate);
    unsigned int  count = 0;
    Ivar *list  =   class_copyIvarList([object class], &count);
    for (int i = 0; i < count; i++)
    {
        Ivar ivar = list[i];
        
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSString  *ivarName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        NSString  *ivarTye = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        //id realType = nil; //id object_getIvar(id obj, Ivar ivar)
        //id value = object_getIvar(self, ivar);
        
        if ([ivarTye rangeOfString:@"@"].location != NSNotFound)
        {
            id value = object_getIvar(object, ivar);
            strInfo = [strInfo stringByAppendingFormat:@"\n%@: %@ ",ivarName,value];
            //  NSLog();
        }else
        {
            if ([ivarTye length] == 1)
            {
                switch (type[0])
                {
                    case 'c':
                    {
                        char c = (char)object_getIvar(object, ivar);
                        //  NSLog(@"%@: %c",ivarName,c);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %c",ivarName,c];
                    }
                        
                        break;
                    case 'i':
                    {
                        int c = (int)object_getIvar(object, ivar);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %i",ivarName,c];
                        // NSLog(@"%@: %i",ivarName,c);
                        
                    }
                        break;
                    case 's':
                    {
                        short c = (short)object_getIvar(object, ivar);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %i",ivarName,c];
                        // NSLog(@"%@: %i",ivarName,c);
                        
                    }
                        break;
                    case 'l':
                    {
                        long c = (long)object_getIvar(object, ivar);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %ld",ivarName,c];
                        // NSLog(@"%@: %ld",ivarName,c);
                        
                    }
                        break;
                    case 'q':
                    {
                        long long c = (long long)object_getIvar(object, ivar);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %lld",ivarName,c];
                        //   NSLog(@"%@: %lld",ivarName,c);
                        
                    }
                        
                        break;
                    case 'C':
                    {
                        unsigned char c = (unsigned char)object_getIvar(object, ivar);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %c",ivarName,c];
                        //  NSLog(@"%@: %c",ivarName,c);
                        
                    }
                        break;
                    case 'I':
                    {
                        unsigned int c = (unsigned int)object_getIvar(object, ivar);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %d",ivarName,c];
                        //  NSLog(@"%@: %d",ivarName,c);
                        
                    }
                        break;
                    case 'S':
                    {
                        unsigned short c = (unsigned short)object_getIvar(object, ivar);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %d",ivarName,c];
                        //  NSLog(@"%@: %d",ivarName,c);
                        
                    }
                        break;
                    case 'L':
                    {
                        unsigned long c = (unsigned long)object_getIvar(object, ivar);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %ld",ivarName,c];
                        // NSLog(@"%@: %ld",ivarName,c);
                        
                    }
                        break;
                    case 'Q':
                    {
                        unsigned long long c = (unsigned long long)object_getIvar(object, ivar);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %lld",ivarName,c];
                        // NSLog(@"%@: %lld",ivarName,c);
                        
                    }
                        break;
                    case 'f':
                    case 'd':
                    {
                        /*float  value = 0;
                        object_getInstanceVariable(object,name,(void*)&value);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %f",ivarName,value];*/
                        
                    }
                        break;
                    case 'B':
                    {
                        
                       /* int  value = 0;
                        object_getInstanceVariable(object,name,(void*)&value);
                        strInfo = [strInfo stringByAppendingFormat:@"\n%@: %d",ivarName,value];
                        //NSLog(@"%@: %d",ivarName,c);*/
                        
                    }
                        break;
                    default:
                        break;
                }
            }
        }
        
        // NSLog(@"name:%@ type:%@",ivarName,ivarTye);
    }
    
    free(list);
#endif
    
    if (strInfo)
    {
        debugLog(@"strInfo:%@",strInfo);
    }
    return strInfo;
}

@end
