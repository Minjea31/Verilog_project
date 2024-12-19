/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/xilinx_workspace/project/motor.v";
static unsigned int ng1[] = {960000U, 0U};
static unsigned int ng2[] = {0U, 0U};
static unsigned int ng3[] = {9U, 0U};
static int ng4[] = {1, 0};
static int ng5[] = {0, 0};
static unsigned int ng6[] = {5U, 0U};
static int ng7[] = {4, 0};
static unsigned int ng8[] = {6U, 0U};
static unsigned int ng9[] = {10U, 0U};
static int ng10[] = {2, 0};
static int ng11[] = {3, 0};



static void Cont_15_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t1 = (t0 + 3328U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(15, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4240);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t2, 8);
    xsi_driver_vfirst_trans(t3, 0, 31);

LAB1:    return;
}

static void Always_18_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;

LAB0:    t1 = (t0 + 3576U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(18, ng0);
    t2 = (t0 + 4144);
    *((int *)t2) = 1;
    t3 = (t0 + 3608);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(18, ng0);

LAB5:    xsi_set_current_line(19, ng0);
    t4 = (t0 + 1048U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(22, ng0);

LAB10:    xsi_set_current_line(23, ng0);
    t2 = (t0 + 2248);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(24, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 1, 0LL);

LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(19, ng0);

LAB9:    xsi_set_current_line(20, ng0);
    t11 = ((char*)((ng2)));
    t12 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 1, 0LL);
    xsi_set_current_line(21, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB8;

}

static void Always_29_2(char *t0)
{
    char t16[8];
    char t17[8];
    char t31[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t32;
    int t33;

LAB0:    t1 = (t0 + 3824U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(29, ng0);
    t2 = (t0 + 4160);
    *((int *)t2) = 1;
    t3 = (t0 + 3856);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(29, ng0);

LAB5:    xsi_set_current_line(30, ng0);
    t4 = (t0 + 1048U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (~(t6));
    t8 = *((unsigned int *)t4);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(64, ng0);

LAB44:    xsi_set_current_line(65, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(66, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);

LAB12:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(30, ng0);

LAB9:    xsi_set_current_line(31, ng0);
    t11 = ((char*)((ng2)));
    t12 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 32, 0LL);
    xsi_set_current_line(32, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);
    goto LAB8;

LAB10:    xsi_set_current_line(34, ng0);

LAB13:    xsi_set_current_line(35, ng0);
    t11 = (t0 + 2088);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t0 + 1528U);
    t15 = *((char **)t14);
    t14 = ((char*)((ng4)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_minus(t16, 32, t15, 32, t14, 32);
    memset(t17, 0, 8);
    t18 = (t13 + 4);
    if (*((unsigned int *)t18) != 0)
        goto LAB15;

LAB14:    t19 = (t16 + 4);
    if (*((unsigned int *)t19) != 0)
        goto LAB15;

LAB18:    if (*((unsigned int *)t13) < *((unsigned int *)t16))
        goto LAB16;

LAB17:    t21 = (t17 + 4);
    t22 = *((unsigned int *)t21);
    t23 = (~(t22));
    t24 = *((unsigned int *)t17);
    t25 = (t24 & t23);
    t26 = (t25 != 0);
    if (t26 > 0)
        goto LAB19;

LAB20:    xsi_set_current_line(38, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);

LAB21:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB22:    t5 = ((char*)((ng5)));
    t33 = xsi_vlog_unsigned_case_compare(t4, 32, t5, 32);
    if (t33 == 1)
        goto LAB23;

LAB24:    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng7)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_divide(t16, 32, t3, 32, t2, 32);
    t33 = xsi_vlog_unsigned_case_compare(t4, 32, t16, 32);
    if (t33 == 1)
        goto LAB25;

LAB26:    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng7)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_divide(t16, 32, t3, 32, t2, 32);
    t5 = ((char*)((ng10)));
    memset(t17, 0, 8);
    xsi_vlog_unsigned_multiply(t17, 32, t16, 32, t5, 32);
    t33 = xsi_vlog_unsigned_case_compare(t4, 32, t17, 32);
    if (t33 == 1)
        goto LAB27;

LAB28:    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng7)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_divide(t16, 32, t3, 32, t2, 32);
    t5 = ((char*)((ng11)));
    memset(t17, 0, 8);
    xsi_vlog_unsigned_multiply(t17, 32, t16, 32, t5, 32);
    t33 = xsi_vlog_unsigned_case_compare(t4, 32, t17, 32);
    if (t33 == 1)
        goto LAB29;

LAB30:
LAB31:    goto LAB12;

LAB15:    t20 = (t17 + 4);
    *((unsigned int *)t17) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB17;

LAB16:    *((unsigned int *)t17) = 1;
    goto LAB17;

LAB19:    xsi_set_current_line(36, ng0);
    t27 = (t0 + 2088);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = ((char*)((ng4)));
    memset(t31, 0, 8);
    xsi_vlog_unsigned_add(t31, 32, t29, 32, t30, 32);
    t32 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t32, t31, 0, 0, 32, 0LL);
    goto LAB21;

LAB23:    xsi_set_current_line(43, ng0);
    t11 = (t0 + 2248);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 4);
    t6 = *((unsigned int *)t14);
    t7 = (~(t6));
    t8 = *((unsigned int *)t13);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB32;

LAB33:    xsi_set_current_line(46, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);

LAB34:    goto LAB31;

LAB25:    xsi_set_current_line(48, ng0);
    t5 = (t0 + 2248);
    t11 = (t5 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 4);
    t6 = *((unsigned int *)t13);
    t7 = (~(t6));
    t8 = *((unsigned int *)t12);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB35;

LAB36:    xsi_set_current_line(51, ng0);
    t2 = ((char*)((ng9)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);

LAB37:    goto LAB31;

LAB27:    xsi_set_current_line(53, ng0);
    t11 = (t0 + 2248);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 4);
    t6 = *((unsigned int *)t14);
    t7 = (~(t6));
    t8 = *((unsigned int *)t13);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB38;

LAB39:    xsi_set_current_line(56, ng0);
    t2 = ((char*)((ng8)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);

LAB40:    goto LAB31;

LAB29:    xsi_set_current_line(58, ng0);
    t11 = (t0 + 2248);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 4);
    t6 = *((unsigned int *)t14);
    t7 = (~(t6));
    t8 = *((unsigned int *)t13);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB41;

LAB42:    xsi_set_current_line(61, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);

LAB43:    goto LAB31;

LAB32:    xsi_set_current_line(44, ng0);
    t15 = ((char*)((ng6)));
    t18 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t18, t15, 0, 0, 4, 0LL);
    goto LAB34;

LAB35:    xsi_set_current_line(49, ng0);
    t14 = ((char*)((ng8)));
    t15 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t15, t14, 0, 0, 4, 0LL);
    goto LAB37;

LAB38:    xsi_set_current_line(54, ng0);
    t15 = ((char*)((ng9)));
    t18 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t18, t15, 0, 0, 4, 0LL);
    goto LAB40;

LAB41:    xsi_set_current_line(59, ng0);
    t15 = ((char*)((ng3)));
    t18 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t18, t15, 0, 0, 4, 0LL);
    goto LAB43;

}


extern void work_m_00000000003228497726_3314646061_init()
{
	static char *pe[] = {(void *)Cont_15_0,(void *)Always_18_1,(void *)Always_29_2};
	xsi_register_didat("work_m_00000000003228497726_3314646061", "isim/top_isim_beh.exe.sim/work/m_00000000003228497726_3314646061.didat");
	xsi_register_executes(pe);
}
