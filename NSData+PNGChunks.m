//
//  NSData+printBlocks.m
//  single0507
//
//  Created by n on 16/5/12.
//  Copyright © 2016年 summerwu. All rights reserved.
//

#import "NSData+PNGChunks.h"
typedef struct PNGChunk {
    UInt32 length;
    UInt8 chunkTypeCode[4];
    UInt8 *chunkData;
    UInt32 CRC;
} PNGChunk;

void printPNGChunk(PNGChunk c){
    printf(">>>>> printPNGChunk\n");
    printf("length:%u\n",(unsigned int)c.length);
    printf("chunkTypeCode:%c%c%c%c\n",c.chunkTypeCode[0],c.chunkTypeCode[1],c.chunkTypeCode[2],c.chunkTypeCode[3]);
    printf("chunkData:%p\n",c.chunkData);
    printf("CRC:%u\n",c.CRC);
    printf("<<<<< printPNGChunk\n");
    printf("\n");
}


/* Table of CRCs of all 8-bit messages. */
unsigned long crc_table[256];

/* Flag: has the table been computed? Initially false. */
int crc_table_computed = 0;

/* Make the table for a fast CRC. */
void make_crc_table(void)
{
    unsigned long c;
    int n, k;

    for (n = 0; n < 256; n++) {
        c = (unsigned long) n;
        for (k = 0; k < 8; k++) {
            if (c & 1)
                c = CFSwapInt32(0xedb88320L) ^ (c >> 1);
            else
                c = c >> 1;
        }
        crc_table[n] = c;
    }
    crc_table_computed = 1;
}

/* Update a running CRC with the bytes buf[0..len-1]--the CRC
 should be initialized to all 1's, and the transmitted value
 is the 1's complement of the final running CRC (see the
 crc() routine below)). */

unsigned long update_crc(unsigned long crc, unsigned char *buf,
                         int len)
{
    unsigned long c = crc;
    int n;

    if (!crc_table_computed)
        make_crc_table();
    for (n = 0; n < len; n++) {
        c = crc_table[(c ^ buf[n]) & 0xff] ^ (c >> 8);
    }
    return c;
}

/* Return the CRC of the bytes buf[0..len-1]. */
unsigned long crc(unsigned char *buf, int len)
{
    return update_crc(0xffffffffL, buf, len) ^ 0xffffffffL;
}

@implementation NSData (PNGChunks)
- (void)printPNGChunks{
    NSMutableArray *ma = [NSMutableArray array];
    UInt8 *bytes = (UInt8 *)[self bytes];
    NSInteger length = [self length];
    NSInteger i = 8;//前面8个字节是 file format signature，所以从第9个字节开始
    while (i<length) { //i<length说明还没有读取完继续读取
        NSLog(@"i==%ld,length==%ld",i,length);
        PNGChunk chunk = {};
        chunk.length = *((UInt32 *)(bytes+i));//bytes中是高位在前。mac是高位在后
        chunk.length = CFSwapInt32(chunk.length);//转换为高位在后
        i += 4;
        for (NSInteger j=0; j<4; j++) {
            chunk.chunkTypeCode[j] = bytes[i+j];
        }
        i += 4;
        chunk.chunkData = bytes+i;
        i += chunk.length;
        chunk.CRC = *((UInt32 *)(bytes+i));
//        chunk.CRC = CFSwapInt32(chunk.CRC);//转换存储顺序

        unsigned long computedCRC = crc(chunk.chunkData, chunk.length);
        BOOL crcMatch = (computedCRC == chunk.CRC)||(computedCRC == CFSwapInt32(chunk.CRC));
        NSLog(@"crcMatch:%d",crcMatch);

        i += 4;
        NSValue *value = [NSValue valueWithBytes:&chunk objCType:@encode(PNGChunk)];
        [ma addObject:value];
        printPNGChunk(chunk);
    }
    NSLog(@"%@",ma);
}
@end
