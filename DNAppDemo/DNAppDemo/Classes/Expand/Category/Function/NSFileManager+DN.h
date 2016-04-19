//
//  NSFileManager+DN.h
//  MobileApp
//
//  Created by mainone on 16/3/1.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DirectoryType)
{
    DirectoryTypeMainBundle = 0,
    DirectoryTypeLibrary,
    DirectoryTypeDocuments,
    DirectoryTypeCache
};

@interface NSFileManager (DN)

/**
 *  读取文件内容
 *
 *  @param file 文件
 *  @param type 类型
 *
 *  @return 文件内容
 */
+ (NSString *)readTextFile:(NSString *)file
                    ofType:(NSString *)type;

/**
 *  将字典保存到本地
 *
 *  @param path       保存位置类型
 *  @param fileName   plist文件名
 *  @param dictionary 要保存的字典
 *
 *  @return 是否保存成功
 */
+ (BOOL)saveDictionaryToPath:(DirectoryType)path
                withFilename:(NSString *)fileName
                  dictionary:(NSDictionary *)dictionary;

/**
 *  从plist中读取dictionary
 *
 *  @param path     保存位置类型
 *  @param fileName plist文件名
 *
 *  @return 字典
 */
+ (NSDictionary *)loadDictionaryFromPath:(DirectoryType)path
                            withFilename:(NSString *)fileName;

/**
 * 将数组保存到本地
 *
 *  @param path     保存位置类型
 *  @param fileName plist文件名
 *  @param array    要保存的数组
 *
 *  @return 是否保存成功
 */
+ (BOOL)saveArrayToPath:(DirectoryType)path
           withFilename:(NSString *)fileName
                  array:(NSArray *)array;

/**
 *  从plist文件中读取数组
 *
 *  @param path     保存位置类型
 *  @param fileName plist文件名
 *
 *  @return 数组
 */
+ (NSArray *)loadArrayFromPath:(DirectoryType)path
                  withFilename:(NSString *)fileName;

/**
 *  获取bundle中名字为filename的路径
 *
 *  @param fileName fileName
 *
 *  @return 路径
 */
+ (NSString *)getBundlePathForFile:(NSString *)fileName;

/**
 *  获取Documents中filename的路径
 *
 *  @param fileName filename
 *
 *  @return 路径
 */
+ (NSString *)getDocumentsDirectoryForFile:(NSString *)fileName;

/**
 *  获取library中filename的路径
 *
 *  @param fileName fileName
 *
 *  @return 路径
 */
+ (NSString *)getLibraryDirectoryForFile:(NSString *)fileName;

/**
 *  获取cache中filename的路径
 *
 *  @param fileName fileName
 *
 *  @return 路径
 */
+ (NSString *)getCacheDirectoryForFile:(NSString *)fileName;

/**
 *  删除某个文件夹中名称为fileName的文件
 *
 *  @param fileName  fileName
 *  @param directory 保存位置类型
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleteFile:(NSString *)fileName fromDirectory:(DirectoryType)directory;

/**
 *  移动fileName文件
 *
 *  @param fileName    文件名
 *  @param origin      原位置
 *  @param destination 将要移动的位置
 *
 *  @return 移动是否成功
 */
+ (BOOL)moveLocalFile:(NSString *)fileName
        fromDirectory:(DirectoryType)origin
          toDirectory:(DirectoryType)destination;

/**
 *  移动文件
 *
 *  @param fileName    文件名
 *  @param origin      元位置
 *  @param destination 新位置
 *  @param folderName  重新命名
 *
 *  @return 移动是否成功
 */
+ (BOOL)moveLocalFile:(NSString *)fileName
        fromDirectory:(DirectoryType)origin
          toDirectory:(DirectoryType)destination
       withFolderName:(NSString *)folderName;

/**
 *  判断一个文件是否存在
 *
 *  @param filePath 文件路径
 *
 *  @return 是否存在
 */
+(BOOL)haveFilesInFilePath:(NSString *)filePath;

/**
 *  App设置文件路径
 *
 *  @return 文件路径
 */
+(NSString *)appSetingFilePath;

/**
 *  创建文件
 *
 *  @param setName 文件名
 *
 *  @return 路径
 */
+(NSString *)setingsFilePath:(NSString *)setName;

/**
 *  复制一个文件到另一个目录
 *
 *  @param origin      原位置
 *  @param destination 新位置
 *
 *  @return 是否复制成功
 */
+ (BOOL)duplicateFileAtPath:(NSString *)origin
                  toNewPath:(NSString *)destination;

/**
 *  重命名一个文件
 *
 *  @param origin  原路径
 *  @param path    子路径
 *  @param oldName 原名字
 *  @param newName 新名字
 *
 *  @return Return YES if the operation was successful, otherwise NO
 */
+ (BOOL)renameFileFromDirectory:(DirectoryType)origin
                         atPath:(NSString *)path
                    withOldName:(NSString *)oldName
                     andNewName:(NSString *)newName;

/**
 *  获取App设置文件中key对应得内容
 *
 *  @param objKey key
 *
 *  @return 内容
 */
+ (id)getAppSettingsForObjectWithKey:(NSString *)objKey;

/**
 *  设置APP设置文件中填入key value
 *
 *  @param value  value
 *  @param objKey key
 *
 *  @return 是否写入成功
 */
+ (BOOL)setAppSettingsForObject:(id)value forKey:(NSString *)objKey;

/**
 *  settings文件中找到key对应的值
 *
 *  @param settings settings文件名
 *  @param objKey   key
 *
 *  @return 值
 */
+ (id)getSettings:(NSString *)settings objectForKey:(NSString *)objKey;

/**
 *  将一对键值对写入到settings文件中
 *
 *  @param settings settings文件
 *  @param value    value
 *  @param objKey   key
 *
 *  @return 是否写入成功
 */
+ (BOOL)setSettings:(NSString *)settings
             object:(id)value forKey:(NSString *)objKey;

@end
