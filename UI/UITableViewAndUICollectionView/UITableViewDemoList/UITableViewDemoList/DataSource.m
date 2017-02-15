// DataSource.m
// 
// Copyright (c) 2017年 hbzs
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "DataSource.h"

static DataSource *_dataSourceInstance;

@implementation DataSource

+ (instancetype)sharedDataSource {
  
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    _dataSourceInstance = [[DataSource alloc] init];
  });
  
  return _dataSourceInstance;
}

- (NSDictionary *)dataItemsAndTitles {
  
  NSString *dataPath               = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
  NSDictionary *dataItemsAndTitles = [NSDictionary dictionaryWithContentsOfFile:dataPath];
  
  return dataItemsAndTitles;
}

- (NSArray *)dataItems {
  
  NSArray *dataItems = [[DataSource sharedDataSource].dataItemsAndTitles allValues];
  
  return dataItems;
}

- (NSString *)titleByDataItem:(NSString *)dataItem {
  NSDictionary *dataItemsAndTitles = [DataSource sharedDataSource].dataItemsAndTitles;
  NSArray      *titles             = [dataItemsAndTitles allKeys];
  for (NSString *title in titles) {
    if ([dataItem isEqualToString:dataItemsAndTitles[title]]) {
      return title;
    }
  }
  return @"UI";
}

@end
