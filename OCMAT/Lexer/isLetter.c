//
//  isLetter.c
//  OCMAT
//
//  Created by mizu-bai on 2020/10/7.
//

#include "isLetter.h"

int isLetter(unsigned short charactor) {
    int res = 0;
    if((charactor >= 'a' && charactor <= 'z') || (charactor >= 'A' && charactor <= 'Z')) {
        res = 1;
    }
    return res;
}
