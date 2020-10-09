//
//  isNum.c
//  OCMAT
//
//  Created by mizu-bai on 2020/10/8.
//

#include "isNum.h"

int isNum(unsigned short charactor) {
    int res = 0;
    if(charactor >= '0' && charactor <= '9') {
        res = 1;
    }
    return res;
}
