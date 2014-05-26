//
//  FormatData.m
//  请求下来的数据转化成数据对象
//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "FormatData.h"
#import "Util.h"


static FormatData *fdata;

@implementation FormatData

+ (id)shareInstance
{
	if(fdata == nil)
	{
		fdata = [[self alloc] init];
	}
	return fdata;
}


- (NSMutableArray *)formatDictToQuestionData:(NSArray *)dictArray
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
//    for (int i = 0; i < [dictArray count]; i ++) {
//        QuestionData *data = [[QuestionData alloc]init];
//        
//        NSDictionary *dict = [dictArray objectAtIndex:i];
//        data.questionID = [[Util shareInstance] checkNullString:[dict objectForKey:Field_Name_Questionid]];
//        data.title = [[Util shareInstance] checkNullString:[dict objectForKey:Field_Name_TITLE]];
//        data.question_time = [[Util shareInstance] checkNullString:[dict objectForKey:Field_Name_QUESTIONTIME]];
//        data.text = [[Util shareInstance] checkNullString:[dict objectForKey:Field_Name_TEXT]];
//        data.pic_url = [[Util shareInstance] checkNullString:[dict objectForKey:Field_Name_PIC_URL]];
//        data.voice_url = [[Util shareInstance] checkNullString:[dict objectForKey:Field_Name_VOICE_Url]];
//
//        data.status = [[Util shareInstance] checkNullString:[dict objectForKey:Field_Name_STATUS]];
//
//        data.answer_count = [[Util shareInstance] checkNullString:[dict objectForKey:Field_Name_answer_count]];
//        
//        [tempArray addObject:data];
//        [data release];
//    }
    
    return tempArray;
}





@end
