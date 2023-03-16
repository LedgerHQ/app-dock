
build/nanos/bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
#include "view.h"

#include <os_io_seproxyhal.h>

__attribute__((section(".boot"))) int
main(void) {
c0d00000:	b510      	push	{r4, lr}
c0d00002:	b08c      	sub	sp, #48	; 0x30
    // exit critical section
    __asm volatile("cpsie i");
c0d00004:	b662      	cpsie	i

    view_init();
c0d00006:	f006 fc65 	bl	c0d068d4 <view_init>
    os_boot();
c0d0000a:	f001 fb07 	bl	c0d0161c <os_boot>
c0d0000e:	466c      	mov	r4, sp

    BEGIN_TRY
    {
        TRY
c0d00010:	4620      	mov	r0, r4
c0d00012:	f007 fab3 	bl	c0d0757c <setjmp>
c0d00016:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00018:	0400      	lsls	r0, r0, #16
c0d0001a:	d006      	beq.n	c0d0002a <main+0x2a>
c0d0001c:	4668      	mov	r0, sp
c0d0001e:	2100      	movs	r1, #0
        {
            app_init();
            app_main();
        }
        CATCH_OTHER(e)
c0d00020:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d00022:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00024:	f004 ff5c 	bl	c0d04ee0 <try_context_set>
c0d00028:	e007      	b.n	c0d0003a <main+0x3a>
c0d0002a:	4668      	mov	r0, sp
        TRY
c0d0002c:	f004 ff58 	bl	c0d04ee0 <try_context_set>
c0d00030:	900a      	str	r0, [sp, #40]	; 0x28
            app_init();
c0d00032:	f000 fddd 	bl	c0d00bf0 <app_init>
            app_main();
c0d00036:	f000 fded 	bl	c0d00c14 <app_main>
        {}
        FINALLY
c0d0003a:	f004 ff45 	bl	c0d04ec8 <try_context_get>
c0d0003e:	4669      	mov	r1, sp
c0d00040:	4288      	cmp	r0, r1
c0d00042:	d102      	bne.n	c0d0004a <main+0x4a>
c0d00044:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00046:	f004 ff4b 	bl	c0d04ee0 <try_context_set>
c0d0004a:	4668      	mov	r0, sp
        {}
    }
    END_TRY;
c0d0004c:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d0004e:	2800      	cmp	r0, #0
c0d00050:	d102      	bne.n	c0d00058 <main+0x58>
c0d00052:	2000      	movs	r0, #0
}
c0d00054:	b00c      	add	sp, #48	; 0x30
c0d00056:	bd10      	pop	{r4, pc}
    END_TRY;
c0d00058:	f001 fae5 	bl	c0d01626 <os_longjmp>

c0d0005c <addr_getNumItems>:
#include "zxerror.h"
#include "zxmacros.h"
#include "app_mode.h"
#include "crypto.h"

zxerr_t addr_getNumItems(uint8_t *num_items) {
c0d0005c:	b510      	push	{r4, lr}
c0d0005e:	4604      	mov	r4, r0
    zemu_log_stack("addr_getNumItems");
c0d00060:	4806      	ldr	r0, [pc, #24]	; (c0d0007c <addr_getNumItems+0x20>)
c0d00062:	4478      	add	r0, pc
c0d00064:	f006 ffbc 	bl	c0d06fe0 <zemu_log_stack>
c0d00068:	2001      	movs	r0, #1
    *num_items = 1;
c0d0006a:	7020      	strb	r0, [r4, #0]
    if (app_mode_expert()) {
c0d0006c:	f000 fe52 	bl	c0d00d14 <app_mode_expert>
c0d00070:	2800      	cmp	r0, #0
c0d00072:	d001      	beq.n	c0d00078 <addr_getNumItems+0x1c>
c0d00074:	2002      	movs	r0, #2
        *num_items = 2;
c0d00076:	7020      	strb	r0, [r4, #0]
c0d00078:	2003      	movs	r0, #3
    }
    return zxerr_ok;
c0d0007a:	bd10      	pop	{r4, pc}
c0d0007c:	0000767a 	.word	0x0000767a

c0d00080 <addr_getItem>:
}

zxerr_t addr_getItem(int8_t displayIdx,
                     char *outKey, uint16_t outKeyLen,
                     char *outVal, uint16_t outValLen,
                     uint8_t pageIdx, uint8_t *pageCount) {
c0d00080:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00082:	b0db      	sub	sp, #364	; 0x16c
c0d00084:	9305      	str	r3, [sp, #20]
c0d00086:	9207      	str	r2, [sp, #28]
c0d00088:	460c      	mov	r4, r1
c0d0008a:	4605      	mov	r5, r0
c0d0008c:	9861      	ldr	r0, [sp, #388]	; 0x184
c0d0008e:	9003      	str	r0, [sp, #12]
    char buffer[30];
    snprintf(buffer, sizeof(buffer), "addr_getItem %d/%d", displayIdx, pageIdx);
c0d00090:	9000      	str	r0, [sp, #0]
c0d00092:	ae53      	add	r6, sp, #332	; 0x14c
c0d00094:	211e      	movs	r1, #30
c0d00096:	4a81      	ldr	r2, [pc, #516]	; (c0d0029c <addr_getItem+0x21c>)
c0d00098:	447a      	add	r2, pc
c0d0009a:	4630      	mov	r0, r6
c0d0009c:	462b      	mov	r3, r5
c0d0009e:	f002 f867 	bl	c0d02170 <snprintf>
    zemu_log_stack(buffer);
c0d000a2:	4630      	mov	r0, r6
c0d000a4:	f006 ff9c 	bl	c0d06fe0 <zemu_log_stack>
c0d000a8:	2605      	movs	r6, #5
c0d000aa:	9862      	ldr	r0, [sp, #392]	; 0x188
c0d000ac:	9006      	str	r0, [sp, #24]
c0d000ae:	9f60      	ldr	r7, [sp, #384]	; 0x180
    switch (displayIdx) {
c0d000b0:	2d01      	cmp	r5, #1
c0d000b2:	d03d      	beq.n	c0d00130 <addr_getItem+0xb0>
c0d000b4:	2d00      	cmp	r5, #0
c0d000b6:	d000      	beq.n	c0d000ba <addr_getItem+0x3a>
c0d000b8:	e0e5      	b.n	c0d00286 <addr_getItem+0x206>
        case 0:
            snprintf(outKey, outKeyLen, "Address");
c0d000ba:	4a79      	ldr	r2, [pc, #484]	; (c0d002a0 <addr_getItem+0x220>)
c0d000bc:	447a      	add	r2, pc
c0d000be:	4620      	mov	r0, r4
c0d000c0:	9907      	ldr	r1, [sp, #28]
c0d000c2:	f002 f855 	bl	c0d02170 <snprintf>
}

__Z_INLINE void pageString(char *outValue, uint16_t outValueLen,
                           const char *inValue,
                           uint8_t pageIdx, uint8_t *pageCount) {
    pageStringExt(outValue, outValueLen, inValue, (uint16_t) strlen(inValue), pageIdx, pageCount);
c0d000c6:	4874      	ldr	r0, [pc, #464]	; (c0d00298 <addr_getItem+0x218>)
c0d000c8:	3020      	adds	r0, #32
c0d000ca:	f007 fac3 	bl	c0d07654 <strlen>
c0d000ce:	4604      	mov	r4, r0
    MEMZERO(outValue, outValueLen);
c0d000d0:	9805      	ldr	r0, [sp, #20]
c0d000d2:	4639      	mov	r1, r7
c0d000d4:	f007 f92e 	bl	c0d07334 <explicit_bzero>
c0d000d8:	2000      	movs	r0, #0
    *pageCount = 0;
c0d000da:	9906      	ldr	r1, [sp, #24]
c0d000dc:	7008      	strb	r0, [r1, #0]
    outValueLen--;  // leave space for NULL termination
c0d000de:	1e7f      	subs	r7, r7, #1
c0d000e0:	b2bd      	uxth	r5, r7
c0d000e2:	2603      	movs	r6, #3
    if (outValueLen == 0) {
c0d000e4:	2d00      	cmp	r5, #0
c0d000e6:	d100      	bne.n	c0d000ea <addr_getItem+0x6a>
c0d000e8:	e0cd      	b.n	c0d00286 <addr_getItem+0x206>
c0d000ea:	0420      	lsls	r0, r4, #16
c0d000ec:	d100      	bne.n	c0d000f0 <addr_getItem+0x70>
c0d000ee:	e0ca      	b.n	c0d00286 <addr_getItem+0x206>
c0d000f0:	b2a0      	uxth	r0, r4
    *pageCount = (uint8_t) (inValueLen / outValueLen);
c0d000f2:	4629      	mov	r1, r5
c0d000f4:	f006 ff76 	bl	c0d06fe4 <__udivsi3>
c0d000f8:	4347      	muls	r7, r0
c0d000fa:	1be3      	subs	r3, r4, r7
c0d000fc:	b29a      	uxth	r2, r3
    if (lastChunkLen > 0) {
c0d000fe:	1e51      	subs	r1, r2, #1
c0d00100:	4614      	mov	r4, r2
c0d00102:	418c      	sbcs	r4, r1
c0d00104:	1820      	adds	r0, r4, r0
c0d00106:	9906      	ldr	r1, [sp, #24]
c0d00108:	7008      	strb	r0, [r1, #0]
c0d0010a:	b2c0      	uxtb	r0, r0
c0d0010c:	9c03      	ldr	r4, [sp, #12]
    if (pageIdx < *pageCount) {
c0d0010e:	42a0      	cmp	r0, r4
c0d00110:	d800      	bhi.n	c0d00114 <addr_getItem+0x94>
c0d00112:	e0b8      	b.n	c0d00286 <addr_getItem+0x206>
c0d00114:	4629      	mov	r1, r5
c0d00116:	4361      	muls	r1, r4
c0d00118:	4f5f      	ldr	r7, [pc, #380]	; (c0d00298 <addr_getItem+0x218>)
c0d0011a:	1879      	adds	r1, r7, r1
c0d0011c:	3120      	adds	r1, #32
        if (lastChunkLen > 0 && pageIdx == *pageCount - 1) {
c0d0011e:	041b      	lsls	r3, r3, #16
c0d00120:	d100      	bne.n	c0d00124 <addr_getItem+0xa4>
c0d00122:	e0a6      	b.n	c0d00272 <addr_getItem+0x1f2>
c0d00124:	1e40      	subs	r0, r0, #1
c0d00126:	42a0      	cmp	r0, r4
c0d00128:	d000      	beq.n	c0d0012c <addr_getItem+0xac>
c0d0012a:	e0a2      	b.n	c0d00272 <addr_getItem+0x1f2>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), lastChunkLen);
c0d0012c:	9805      	ldr	r0, [sp, #20]
c0d0012e:	e0a2      	b.n	c0d00276 <addr_getItem+0x1f6>
c0d00130:	9702      	str	r7, [sp, #8]
            pageString(outVal, outValLen, (char *) (G_io_apdu_buffer + PK_LEN_25519), pageIdx, pageCount);
            return zxerr_ok;
        case 1: {
            if (!app_mode_expert()) {
c0d00132:	f000 fdef 	bl	c0d00d14 <app_mode_expert>
c0d00136:	2800      	cmp	r0, #0
c0d00138:	d100      	bne.n	c0d0013c <addr_getItem+0xbc>
c0d0013a:	e0a4      	b.n	c0d00286 <addr_getItem+0x206>
                return zxerr_no_data;
            }

            snprintf(outKey, outKeyLen, "Your Path");
c0d0013c:	4a59      	ldr	r2, [pc, #356]	; (c0d002a4 <addr_getItem+0x224>)
c0d0013e:	447a      	add	r2, pc
c0d00140:	4620      	mov	r0, r4
c0d00142:	9907      	ldr	r1, [sp, #28]
c0d00144:	f002 f814 	bl	c0d02170 <snprintf>
c0d00148:	204b      	movs	r0, #75	; 0x4b
c0d0014a:	0085      	lsls	r5, r0, #2
c0d0014c:	ac08      	add	r4, sp, #32
    MEMZERO(s, max);
c0d0014e:	4620      	mov	r0, r4
c0d00150:	4629      	mov	r1, r5
c0d00152:	f007 f8ef 	bl	c0d07334 <explicit_bzero>
        snprintf(s + offset, max - offset, "%d", path[i] & 0x7FFFFFFFu);
c0d00156:	484d      	ldr	r0, [pc, #308]	; (c0d0028c <addr_getItem+0x20c>)
c0d00158:	6803      	ldr	r3, [r0, #0]
c0d0015a:	484d      	ldr	r0, [pc, #308]	; (c0d00290 <addr_getItem+0x210>)
c0d0015c:	4003      	ands	r3, r0
c0d0015e:	4a52      	ldr	r2, [pc, #328]	; (c0d002a8 <addr_getItem+0x228>)
c0d00160:	447a      	add	r2, pc
c0d00162:	4620      	mov	r0, r4
c0d00164:	4629      	mov	r1, r5
c0d00166:	f002 f803 	bl	c0d02170 <snprintf>
        written = strlen(s + offset);
c0d0016a:	4620      	mov	r0, r4
c0d0016c:	f007 fa72 	bl	c0d07654 <strlen>
c0d00170:	9507      	str	r5, [sp, #28]
        if (written == 0 || written >= max - offset) {
c0d00172:	1e69      	subs	r1, r5, #1
c0d00174:	1e42      	subs	r2, r0, #1
c0d00176:	428a      	cmp	r2, r1
c0d00178:	d248      	bcs.n	c0d0020c <addr_getItem+0x18c>
c0d0017a:	2100      	movs	r1, #0
c0d0017c:	460e      	mov	r6, r1
        offset += written;
c0d0017e:	1986      	adds	r6, r0, r6
        if ((path[i] & 0x80000000u) != 0) {
c0d00180:	4842      	ldr	r0, [pc, #264]	; (c0d0028c <addr_getItem+0x20c>)
c0d00182:	5840      	ldr	r0, [r0, r1]
c0d00184:	2800      	cmp	r0, #0
c0d00186:	d513      	bpl.n	c0d001b0 <addr_getItem+0x130>
c0d00188:	a808      	add	r0, sp, #32
            snprintf(s + offset, max - offset, "'");
c0d0018a:	1985      	adds	r5, r0, r6
c0d0018c:	9807      	ldr	r0, [sp, #28]
c0d0018e:	1b84      	subs	r4, r0, r6
c0d00190:	4a46      	ldr	r2, [pc, #280]	; (c0d002ac <addr_getItem+0x22c>)
c0d00192:	447a      	add	r2, pc
c0d00194:	4628      	mov	r0, r5
c0d00196:	460f      	mov	r7, r1
c0d00198:	4621      	mov	r1, r4
c0d0019a:	f001 ffe9 	bl	c0d02170 <snprintf>
            written = strlen(s + offset);
c0d0019e:	4628      	mov	r0, r5
c0d001a0:	f007 fa58 	bl	c0d07654 <strlen>
            if (written == 0 || written >= max - offset) {
c0d001a4:	2800      	cmp	r0, #0
c0d001a6:	d031      	beq.n	c0d0020c <addr_getItem+0x18c>
c0d001a8:	42a0      	cmp	r0, r4
c0d001aa:	d22f      	bcs.n	c0d0020c <addr_getItem+0x18c>
c0d001ac:	4639      	mov	r1, r7
            offset += written;
c0d001ae:	1986      	adds	r6, r0, r6
        if (i != pathLen - 1) {
c0d001b0:	1d0f      	adds	r7, r1, #4
c0d001b2:	2f14      	cmp	r7, #20
c0d001b4:	d02f      	beq.n	c0d00216 <addr_getItem+0x196>
c0d001b6:	a808      	add	r0, sp, #32
            snprintf(s + offset, max - offset, "/");
c0d001b8:	1985      	adds	r5, r0, r6
c0d001ba:	9807      	ldr	r0, [sp, #28]
c0d001bc:	1b84      	subs	r4, r0, r6
c0d001be:	4a3c      	ldr	r2, [pc, #240]	; (c0d002b0 <addr_getItem+0x230>)
c0d001c0:	447a      	add	r2, pc
c0d001c2:	4628      	mov	r0, r5
c0d001c4:	9104      	str	r1, [sp, #16]
c0d001c6:	4621      	mov	r1, r4
c0d001c8:	f001 ffd2 	bl	c0d02170 <snprintf>
            written = strlen(s + offset);
c0d001cc:	4628      	mov	r0, r5
c0d001ce:	f007 fa41 	bl	c0d07654 <strlen>
c0d001d2:	9904      	ldr	r1, [sp, #16]
            if (written == 0 || written >= max - offset) {
c0d001d4:	2800      	cmp	r0, #0
c0d001d6:	d019      	beq.n	c0d0020c <addr_getItem+0x18c>
c0d001d8:	42a0      	cmp	r0, r4
c0d001da:	d217      	bcs.n	c0d0020c <addr_getItem+0x18c>
            offset += written;
c0d001dc:	1986      	adds	r6, r0, r6
c0d001de:	a808      	add	r0, sp, #32
        snprintf(s + offset, max - offset, "%d", path[i] & 0x7FFFFFFFu);
c0d001e0:	1985      	adds	r5, r0, r6
c0d001e2:	9807      	ldr	r0, [sp, #28]
c0d001e4:	1b84      	subs	r4, r0, r6
c0d001e6:	4829      	ldr	r0, [pc, #164]	; (c0d0028c <addr_getItem+0x20c>)
c0d001e8:	1840      	adds	r0, r0, r1
c0d001ea:	6843      	ldr	r3, [r0, #4]
c0d001ec:	4828      	ldr	r0, [pc, #160]	; (c0d00290 <addr_getItem+0x210>)
c0d001ee:	4003      	ands	r3, r0
c0d001f0:	4a30      	ldr	r2, [pc, #192]	; (c0d002b4 <addr_getItem+0x234>)
c0d001f2:	447a      	add	r2, pc
c0d001f4:	4628      	mov	r0, r5
c0d001f6:	4621      	mov	r1, r4
c0d001f8:	f001 ffba 	bl	c0d02170 <snprintf>
        written = strlen(s + offset);
c0d001fc:	4628      	mov	r0, r5
c0d001fe:	f007 fa29 	bl	c0d07654 <strlen>
        if (written == 0 || written >= max - offset) {
c0d00202:	2800      	cmp	r0, #0
c0d00204:	d002      	beq.n	c0d0020c <addr_getItem+0x18c>
c0d00206:	42a0      	cmp	r0, r4
c0d00208:	4639      	mov	r1, r7
c0d0020a:	d3b8      	bcc.n	c0d0017e <addr_getItem+0xfe>
c0d0020c:	a808      	add	r0, sp, #32
c0d0020e:	2152      	movs	r1, #82	; 0x52
c0d00210:	8081      	strh	r1, [r0, #4]
c0d00212:	4820      	ldr	r0, [pc, #128]	; (c0d00294 <addr_getItem+0x214>)
c0d00214:	9008      	str	r0, [sp, #32]
c0d00216:	a808      	add	r0, sp, #32
    pageStringExt(outValue, outValueLen, inValue, (uint16_t) strlen(inValue), pageIdx, pageCount);
c0d00218:	f007 fa1c 	bl	c0d07654 <strlen>
c0d0021c:	4604      	mov	r4, r0
    MEMZERO(outValue, outValueLen);
c0d0021e:	9805      	ldr	r0, [sp, #20]
c0d00220:	9d02      	ldr	r5, [sp, #8]
c0d00222:	4629      	mov	r1, r5
c0d00224:	f007 f886 	bl	c0d07334 <explicit_bzero>
c0d00228:	2000      	movs	r0, #0
    *pageCount = 0;
c0d0022a:	9906      	ldr	r1, [sp, #24]
c0d0022c:	7008      	strb	r0, [r1, #0]
    outValueLen--;  // leave space for NULL termination
c0d0022e:	1e6e      	subs	r6, r5, #1
c0d00230:	b2b5      	uxth	r5, r6
    if (outValueLen == 0) {
c0d00232:	2d00      	cmp	r5, #0
c0d00234:	9f03      	ldr	r7, [sp, #12]
c0d00236:	d025      	beq.n	c0d00284 <addr_getItem+0x204>
c0d00238:	0420      	lsls	r0, r4, #16
c0d0023a:	d023      	beq.n	c0d00284 <addr_getItem+0x204>
c0d0023c:	b2a0      	uxth	r0, r4
    *pageCount = (uint8_t) (inValueLen / outValueLen);
c0d0023e:	4629      	mov	r1, r5
c0d00240:	f006 fed0 	bl	c0d06fe4 <__udivsi3>
c0d00244:	4346      	muls	r6, r0
c0d00246:	1ba3      	subs	r3, r4, r6
c0d00248:	b29a      	uxth	r2, r3
    if (lastChunkLen > 0) {
c0d0024a:	1e51      	subs	r1, r2, #1
c0d0024c:	4614      	mov	r4, r2
c0d0024e:	418c      	sbcs	r4, r1
c0d00250:	1820      	adds	r0, r4, r0
c0d00252:	9906      	ldr	r1, [sp, #24]
c0d00254:	7008      	strb	r0, [r1, #0]
c0d00256:	b2c0      	uxtb	r0, r0
    if (pageIdx < *pageCount) {
c0d00258:	42b8      	cmp	r0, r7
c0d0025a:	d913      	bls.n	c0d00284 <addr_getItem+0x204>
c0d0025c:	4629      	mov	r1, r5
c0d0025e:	4379      	muls	r1, r7
c0d00260:	ac08      	add	r4, sp, #32
c0d00262:	1861      	adds	r1, r4, r1
        if (lastChunkLen > 0 && pageIdx == *pageCount - 1) {
c0d00264:	041b      	lsls	r3, r3, #16
c0d00266:	d009      	beq.n	c0d0027c <addr_getItem+0x1fc>
c0d00268:	1e40      	subs	r0, r0, #1
c0d0026a:	42b8      	cmp	r0, r7
c0d0026c:	d106      	bne.n	c0d0027c <addr_getItem+0x1fc>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), lastChunkLen);
c0d0026e:	9805      	ldr	r0, [sp, #20]
c0d00270:	e006      	b.n	c0d00280 <addr_getItem+0x200>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), outValueLen);
c0d00272:	9805      	ldr	r0, [sp, #20]
c0d00274:	462a      	mov	r2, r5
c0d00276:	f007 f84d 	bl	c0d07314 <__aeabi_memcpy>
c0d0027a:	e004      	b.n	c0d00286 <addr_getItem+0x206>
c0d0027c:	9805      	ldr	r0, [sp, #20]
c0d0027e:	462a      	mov	r2, r5
c0d00280:	f007 f848 	bl	c0d07314 <__aeabi_memcpy>
c0d00284:	2603      	movs	r6, #3
            return zxerr_ok;
        }
        default:
            return zxerr_no_data;
    }
}
c0d00286:	4630      	mov	r0, r6
c0d00288:	b05b      	add	sp, #364	; 0x16c
c0d0028a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0028c:	2000029c 	.word	0x2000029c
c0d00290:	7fffffff 	.word	0x7fffffff
c0d00294:	4f525245 	.word	0x4f525245
c0d00298:	200002b0 	.word	0x200002b0
c0d0029c:	00007655 	.word	0x00007655
c0d002a0:	00007644 	.word	0x00007644
c0d002a4:	000075ca 	.word	0x000075ca
c0d002a8:	000080ff 	.word	0x000080ff
c0d002ac:	00007586 	.word	0x00007586
c0d002b0:	0000755a 	.word	0x0000755a
c0d002b4:	0000806d 	.word	0x0000806d

c0d002b8 <extractHDPath>:
#include "coin.h"
#include "zxmacros.h"
#include "secret.h"
#include "app_mode.h"

void extractHDPath(uint32_t rx, uint32_t offset) {
c0d002b8:	b5b0      	push	{r4, r5, r7, lr}
    if ((rx - offset) < sizeof(uint32_t) * HDPATH_LEN_DEFAULT) {
c0d002ba:	1a40      	subs	r0, r0, r1
c0d002bc:	2813      	cmp	r0, #19
c0d002be:	d916      	bls.n	c0d002ee <extractHDPath+0x36>
        THROW(APDU_CODE_WRONG_LENGTH);
    }

    MEMCPY(hdPath, G_io_apdu_buffer + offset, sizeof(uint32_t) * HDPATH_LEN_DEFAULT);
c0d002c0:	480e      	ldr	r0, [pc, #56]	; (c0d002fc <extractHDPath+0x44>)
c0d002c2:	1841      	adds	r1, r0, r1
c0d002c4:	4c0e      	ldr	r4, [pc, #56]	; (c0d00300 <extractHDPath+0x48>)
c0d002c6:	2214      	movs	r2, #20
c0d002c8:	4620      	mov	r0, r4
c0d002ca:	f007 f823 	bl	c0d07314 <__aeabi_memcpy>

    const bool mainnet = hdPath[0] == HDPATH_0_DEFAULT &&
c0d002ce:	6820      	ldr	r0, [r4, #0]
c0d002d0:	490d      	ldr	r1, [pc, #52]	; (c0d00308 <extractHDPath+0x50>)
                         hdPath[1] == HDPATH_1_DEFAULT;

    if (!mainnet) {
c0d002d2:	4288      	cmp	r0, r1
c0d002d4:	d10f      	bne.n	c0d002f6 <extractHDPath+0x3e>
c0d002d6:	4d0b      	ldr	r5, [pc, #44]	; (c0d00304 <extractHDPath+0x4c>)
c0d002d8:	4628      	mov	r0, r5
c0d002da:	30f0      	adds	r0, #240	; 0xf0
c0d002dc:	6861      	ldr	r1, [r4, #4]
c0d002de:	4281      	cmp	r1, r0
c0d002e0:	d109      	bne.n	c0d002f6 <extractHDPath+0x3e>
        THROW(APDU_CODE_DATA_INVALID);
    }

#ifdef APP_SECRET_MODE_ENABLED
    if (app_mode_secret()) {
c0d002e2:	f000 fd31 	bl	c0d00d48 <app_mode_secret>
c0d002e6:	2800      	cmp	r0, #0
c0d002e8:	d000      	beq.n	c0d002ec <extractHDPath+0x34>
        hdPath[1] = HDPATH_1_RECOVERY;
c0d002ea:	6065      	str	r5, [r4, #4]
    }
#endif
}
c0d002ec:	bdb0      	pop	{r4, r5, r7, pc}
c0d002ee:	2067      	movs	r0, #103	; 0x67
c0d002f0:	0200      	lsls	r0, r0, #8
        THROW(APDU_CODE_WRONG_LENGTH);
c0d002f2:	f001 f998 	bl	c0d01626 <os_longjmp>
c0d002f6:	4805      	ldr	r0, [pc, #20]	; (c0d0030c <extractHDPath+0x54>)
        THROW(APDU_CODE_DATA_INVALID);
c0d002f8:	f001 f995 	bl	c0d01626 <os_longjmp>
c0d002fc:	200002b0 	.word	0x200002b0
c0d00300:	2000029c 	.word	0x2000029c
c0d00304:	80000162 	.word	0x80000162
c0d00308:	8000002c 	.word	0x8000002c
c0d0030c:	00006984 	.word	0x00006984

c0d00310 <handleApdu>:
void handleTest(volatile uint32_t *flags, volatile uint32_t *tx, uint32_t rx) {
    THROW(APDU_CODE_OK);
}
#endif

void handleApdu(volatile uint32_t *flags, volatile uint32_t *tx, uint32_t rx) {
c0d00310:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00312:	b08d      	sub	sp, #52	; 0x34
c0d00314:	4617      	mov	r7, r2
c0d00316:	460c      	mov	r4, r1
c0d00318:	9000      	str	r0, [sp, #0]
c0d0031a:	ad01      	add	r5, sp, #4
    uint16_t sw = 0;

    BEGIN_TRY
    {
        TRY
c0d0031c:	4628      	mov	r0, r5
c0d0031e:	f007 f92d 	bl	c0d0757c <setjmp>
c0d00322:	4606      	mov	r6, r0
c0d00324:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d00326:	b280      	uxth	r0, r0
c0d00328:	2800      	cmp	r0, #0
c0d0032a:	d016      	beq.n	c0d0035a <handleApdu+0x4a>
c0d0032c:	2805      	cmp	r0, #5
c0d0032e:	d100      	bne.n	c0d00332 <handleApdu+0x22>
c0d00330:	e0ab      	b.n	c0d0048a <handleApdu+0x17a>
c0d00332:	4635      	mov	r5, r6
c0d00334:	a801      	add	r0, sp, #4
c0d00336:	2100      	movs	r1, #0
        }
        CATCH(EXCEPTION_IO_RESET)
        {
            THROW(EXCEPTION_IO_RESET);
        }
        CATCH_OTHER(e)
c0d00338:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d0033a:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0033c:	f004 fdd0 	bl	c0d04ee0 <try_context_set>
c0d00340:	200f      	movs	r0, #15
c0d00342:	0300      	lsls	r0, r0, #12
        {
            switch (e & 0xF000) {
c0d00344:	4030      	ands	r0, r6
c0d00346:	2109      	movs	r1, #9
c0d00348:	0309      	lsls	r1, r1, #12
c0d0034a:	4288      	cmp	r0, r1
c0d0034c:	d003      	beq.n	c0d00356 <handleApdu+0x46>
c0d0034e:	2103      	movs	r1, #3
c0d00350:	0349      	lsls	r1, r1, #13
c0d00352:	4288      	cmp	r0, r1
c0d00354:	d156      	bne.n	c0d00404 <handleApdu+0xf4>
                case 0x6000:
                case APDU_CODE_OK:
                    sw = e;
                    break;
c0d00356:	0a30      	lsrs	r0, r6, #8
c0d00358:	e057      	b.n	c0d0040a <handleApdu+0xfa>
c0d0035a:	a801      	add	r0, sp, #4
        TRY
c0d0035c:	f004 fdc0 	bl	c0d04ee0 <try_context_set>
c0d00360:	900b      	str	r0, [sp, #44]	; 0x2c
            if (G_io_apdu_buffer[OFFSET_CLA] != CLA) {
c0d00362:	4e78      	ldr	r6, [pc, #480]	; (c0d00544 <handleApdu+0x234>)
c0d00364:	7830      	ldrb	r0, [r6, #0]
c0d00366:	2892      	cmp	r0, #146	; 0x92
c0d00368:	d000      	beq.n	c0d0036c <handleApdu+0x5c>
c0d0036a:	e097      	b.n	c0d0049c <handleApdu+0x18c>
            if (rx < APDU_MIN_LENGTH) {
c0d0036c:	2f04      	cmp	r7, #4
c0d0036e:	d800      	bhi.n	c0d00372 <handleApdu+0x62>
c0d00370:	e098      	b.n	c0d004a4 <handleApdu+0x194>
            switch (G_io_apdu_buffer[OFFSET_INS]) {
c0d00372:	7870      	ldrb	r0, [r6, #1]
c0d00374:	2801      	cmp	r0, #1
c0d00376:	d032      	beq.n	c0d003de <handleApdu+0xce>
c0d00378:	2802      	cmp	r0, #2
c0d0037a:	d000      	beq.n	c0d0037e <handleApdu+0x6e>
c0d0037c:	e094      	b.n	c0d004a8 <handleApdu+0x198>
                    if( os_global_pin_is_validated() != BOLOS_UX_OK ) {
c0d0037e:	f004 fd23 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d00382:	28aa      	cmp	r0, #170	; 0xaa
c0d00384:	d000      	beq.n	c0d00388 <handleApdu+0x78>
c0d00386:	e0ae      	b.n	c0d004e6 <handleApdu+0x1d6>
    if (G_io_apdu_buffer[OFFSET_P2] != 0) {
c0d00388:	78f0      	ldrb	r0, [r6, #3]
c0d0038a:	2800      	cmp	r0, #0
c0d0038c:	d000      	beq.n	c0d00390 <handleApdu+0x80>
c0d0038e:	e0ae      	b.n	c0d004ee <handleApdu+0x1de>
    const uint8_t payloadType = G_io_apdu_buffer[OFFSET_PAYLOAD_TYPE];
c0d00390:	78b0      	ldrb	r0, [r6, #2]
    switch (payloadType) {
c0d00392:	2802      	cmp	r0, #2
c0d00394:	d16c      	bne.n	c0d00470 <handleApdu+0x160>
            added = tx_append(&(G_io_apdu_buffer[OFFSET_DATA]), rx - OFFSET_DATA);
c0d00396:	1d70      	adds	r0, r6, #5
c0d00398:	1f7d      	subs	r5, r7, #5
c0d0039a:	4629      	mov	r1, r5
c0d0039c:	f004 fdd0 	bl	c0d04f40 <tx_append>
            if (added != rx - OFFSET_DATA) {
c0d003a0:	42a8      	cmp	r0, r5
c0d003a2:	d000      	beq.n	c0d003a6 <handleApdu+0x96>
c0d003a4:	e0c7      	b.n	c0d00536 <handleApdu+0x226>
    if (app_mode_secret()) {
c0d003a6:	f000 fccf 	bl	c0d00d48 <app_mode_secret>
c0d003aa:	2800      	cmp	r0, #0
c0d003ac:	d002      	beq.n	c0d003b4 <handleApdu+0xa4>
c0d003ae:	2000      	movs	r0, #0
        app_mode_set_secret(false);
c0d003b0:	f000 fcd2 	bl	c0d00d58 <app_mode_set_secret>
    const uint8_t addr_type = G_io_apdu_buffer[OFFSET_P2];
c0d003b4:	78f0      	ldrb	r0, [r6, #3]
c0d003b6:	2100      	movs	r1, #0
    *tx = 0;
c0d003b8:	6021      	str	r1, [r4, #0]
    switch (key_type) {
c0d003ba:	2800      	cmp	r0, #0
c0d003bc:	d000      	beq.n	c0d003c0 <handleApdu+0xb0>
c0d003be:	e0a8      	b.n	c0d00512 <handleApdu+0x202>
    const char *error_msg = tx_parse();
c0d003c0:	f004 fdcc 	bl	c0d04f5c <tx_parse>
c0d003c4:	4606      	mov	r6, r0
    CHECK_APP_CANARY()
c0d003c6:	f006 fdfd 	bl	c0d06fc4 <check_app_canary>
    if (error_msg != NULL) {
c0d003ca:	2e00      	cmp	r6, #0
c0d003cc:	d000      	beq.n	c0d003d0 <handleApdu+0xc0>
c0d003ce:	e092      	b.n	c0d004f6 <handleApdu+0x1e6>
    view_review_init(tx_getItem, tx_getNumItems, app_sign_ed25519);
c0d003d0:	4863      	ldr	r0, [pc, #396]	; (c0d00560 <handleApdu+0x250>)
c0d003d2:	4478      	add	r0, pc
c0d003d4:	4963      	ldr	r1, [pc, #396]	; (c0d00564 <handleApdu+0x254>)
c0d003d6:	4479      	add	r1, pc
c0d003d8:	4a63      	ldr	r2, [pc, #396]	; (c0d00568 <handleApdu+0x258>)
c0d003da:	447a      	add	r2, pc
c0d003dc:	e031      	b.n	c0d00442 <handleApdu+0x132>
                    if( os_global_pin_is_validated() != BOLOS_UX_OK ) {
c0d003de:	f004 fcf3 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d003e2:	28aa      	cmp	r0, #170	; 0xaa
c0d003e4:	d17f      	bne.n	c0d004e6 <handleApdu+0x1d6>
c0d003e6:	2105      	movs	r1, #5
    extractHDPath(rx, OFFSET_DATA);
c0d003e8:	4638      	mov	r0, r7
c0d003ea:	f7ff ff65 	bl	c0d002b8 <extractHDPath>
    const uint8_t requireConfirmation = G_io_apdu_buffer[OFFSET_P1];
c0d003ee:	78b5      	ldrb	r5, [r6, #2]
    const uint8_t addr_type = G_io_apdu_buffer[OFFSET_P2];
c0d003f0:	78f7      	ldrb	r7, [r6, #3]
c0d003f2:	2041      	movs	r0, #65	; 0x41
c0d003f4:	0081      	lsls	r1, r0, #2
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
}

__Z_INLINE zxerr_t app_fill_address(key_kind_e addressKind) {
    // Put data directly in the apdu buffer
    MEMZERO(G_io_apdu_buffer, IO_APDU_BUFFER_SIZE);
c0d003f6:	4630      	mov	r0, r6
c0d003f8:	f006 ff9c 	bl	c0d07334 <explicit_bzero>
    CHECK_ZXERR(crypto_fillAddress(addressKind,
c0d003fc:	2f00      	cmp	r7, #0
c0d003fe:	d10e      	bne.n	c0d0041e <handleApdu+0x10e>
c0d00400:	4638      	mov	r0, r7
c0d00402:	e00d      	b.n	c0d00420 <handleApdu+0x110>
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
c0d00404:	0570      	lsls	r0, r6, #21
c0d00406:	0f40      	lsrs	r0, r0, #29
c0d00408:	3068      	adds	r0, #104	; 0x68
            }
            G_io_apdu_buffer[*tx] = sw >> 8;
c0d0040a:	6821      	ldr	r1, [r4, #0]
c0d0040c:	4a4d      	ldr	r2, [pc, #308]	; (c0d00544 <handleApdu+0x234>)
c0d0040e:	5450      	strb	r0, [r2, r1]
            G_io_apdu_buffer[*tx + 1] = sw;
c0d00410:	6820      	ldr	r0, [r4, #0]
c0d00412:	1880      	adds	r0, r0, r2
c0d00414:	7045      	strb	r5, [r0, #1]
            *tx += 2;
c0d00416:	6820      	ldr	r0, [r4, #0]
c0d00418:	1c80      	adds	r0, r0, #2
c0d0041a:	6020      	str	r0, [r4, #0]
c0d0041c:	e01a      	b.n	c0d00454 <handleApdu+0x144>
c0d0041e:	20ff      	movs	r0, #255	; 0xff
c0d00420:	2181      	movs	r1, #129	; 0x81
c0d00422:	004a      	lsls	r2, r1, #1
c0d00424:	4f49      	ldr	r7, [pc, #292]	; (c0d0054c <handleApdu+0x23c>)
c0d00426:	4631      	mov	r1, r6
c0d00428:	463b      	mov	r3, r7
c0d0042a:	f001 f82b 	bl	c0d01484 <crypto_fillAddress>
    if(zxerr != zxerr_ok){
c0d0042e:	2803      	cmp	r0, #3
c0d00430:	d16d      	bne.n	c0d0050e <handleApdu+0x1fe>
    if (requireConfirmation) {
c0d00432:	2d00      	cmp	r5, #0
c0d00434:	d071      	beq.n	c0d0051a <handleApdu+0x20a>
        view_review_init(addr_getItem, addr_getNumItems, app_reply_address);
c0d00436:	4847      	ldr	r0, [pc, #284]	; (c0d00554 <handleApdu+0x244>)
c0d00438:	4478      	add	r0, pc
c0d0043a:	4947      	ldr	r1, [pc, #284]	; (c0d00558 <handleApdu+0x248>)
c0d0043c:	4479      	add	r1, pc
c0d0043e:	4a47      	ldr	r2, [pc, #284]	; (c0d0055c <handleApdu+0x24c>)
c0d00440:	447a      	add	r2, pc
c0d00442:	f006 fa57 	bl	c0d068f4 <view_review_init>
c0d00446:	f006 fa5b 	bl	c0d06900 <view_review_show>
c0d0044a:	9a00      	ldr	r2, [sp, #0]
c0d0044c:	6810      	ldr	r0, [r2, #0]
c0d0044e:	2110      	movs	r1, #16
c0d00450:	4301      	orrs	r1, r0
c0d00452:	6011      	str	r1, [r2, #0]
        }
        FINALLY
c0d00454:	f004 fd38 	bl	c0d04ec8 <try_context_get>
c0d00458:	a901      	add	r1, sp, #4
c0d0045a:	4288      	cmp	r0, r1
c0d0045c:	d102      	bne.n	c0d00464 <handleApdu+0x154>
c0d0045e:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d00460:	f004 fd3e 	bl	c0d04ee0 <try_context_set>
c0d00464:	a801      	add	r0, sp, #4
        {
        }
    }
    END_TRY;
c0d00466:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d00468:	2800      	cmp	r0, #0
c0d0046a:	d142      	bne.n	c0d004f2 <handleApdu+0x1e2>
}
c0d0046c:	b00d      	add	sp, #52	; 0x34
c0d0046e:	bdf0      	pop	{r4, r5, r6, r7, pc}
    switch (payloadType) {
c0d00470:	2801      	cmp	r0, #1
c0d00472:	d055      	beq.n	c0d00520 <handleApdu+0x210>
c0d00474:	2800      	cmp	r0, #0
c0d00476:	d13a      	bne.n	c0d004ee <handleApdu+0x1de>
            tx_initialize();
c0d00478:	f004 fd4e 	bl	c0d04f18 <tx_initialize>
            tx_reset();
c0d0047c:	f004 fd5c 	bl	c0d04f38 <tx_reset>
c0d00480:	2105      	movs	r1, #5
            extractHDPath(rx, OFFSET_DATA);
c0d00482:	4638      	mov	r0, r7
c0d00484:	f7ff ff18 	bl	c0d002b8 <extractHDPath>
c0d00488:	e051      	b.n	c0d0052e <handleApdu+0x21e>
c0d0048a:	a801      	add	r0, sp, #4
c0d0048c:	2100      	movs	r1, #0
        CATCH(EXCEPTION_IO_RESET)
c0d0048e:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d00490:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d00492:	f004 fd25 	bl	c0d04ee0 <try_context_set>
c0d00496:	2005      	movs	r0, #5
            THROW(EXCEPTION_IO_RESET);
c0d00498:	f001 f8c5 	bl	c0d01626 <os_longjmp>
c0d0049c:	2037      	movs	r0, #55	; 0x37
c0d0049e:	0240      	lsls	r0, r0, #9
                THROW(APDU_CODE_CLA_NOT_SUPPORTED);
c0d004a0:	f001 f8c1 	bl	c0d01626 <os_longjmp>
c0d004a4:	2067      	movs	r0, #103	; 0x67
c0d004a6:	e04a      	b.n	c0d0053e <handleApdu+0x22e>
            switch (G_io_apdu_buffer[OFFSET_INS]) {
c0d004a8:	2800      	cmp	r0, #0
c0d004aa:	d147      	bne.n	c0d0053c <handleApdu+0x22c>
c0d004ac:	2000      	movs	r0, #0
    G_io_apdu_buffer[6] = (LEDGER_PATCH_VERSION >> 0) & 0xFF;
c0d004ae:	71b0      	strb	r0, [r6, #6]
    G_io_apdu_buffer[5] = (LEDGER_PATCH_VERSION >> 8) & 0xFF;
c0d004b0:	7170      	strb	r0, [r6, #5]
c0d004b2:	212c      	movs	r1, #44	; 0x2c
    G_io_apdu_buffer[4] = (LEDGER_MINOR_VERSION >> 0) & 0xFF;
c0d004b4:	7131      	strb	r1, [r6, #4]
    G_io_apdu_buffer[3] = (LEDGER_MINOR_VERSION >> 8) & 0xFF;
c0d004b6:	70f0      	strb	r0, [r6, #3]
c0d004b8:	2102      	movs	r1, #2
    G_io_apdu_buffer[2] = (LEDGER_MAJOR_VERSION >> 0) & 0xFF;
c0d004ba:	70b1      	strb	r1, [r6, #2]
    G_io_apdu_buffer[1] = (LEDGER_MAJOR_VERSION >> 8) & 0xFF;
c0d004bc:	7070      	strb	r0, [r6, #1]
    G_io_apdu_buffer[0] = 0;
c0d004be:	7030      	strb	r0, [r6, #0]
c0d004c0:	2104      	movs	r1, #4
    G_io_apdu_buffer[11] = (TARGET_ID >> 0) & 0xFF;
c0d004c2:	72f1      	strb	r1, [r6, #11]
    G_io_apdu_buffer[10] = (TARGET_ID >> 8) & 0xFF;
c0d004c4:	72b0      	strb	r0, [r6, #10]
c0d004c6:	2010      	movs	r0, #16
    G_io_apdu_buffer[9] = (TARGET_ID >> 16) & 0xFF;
c0d004c8:	7270      	strb	r0, [r6, #9]
c0d004ca:	2031      	movs	r0, #49	; 0x31
    G_io_apdu_buffer[8] = (TARGET_ID >> 24) & 0xFF;
c0d004cc:	7230      	strb	r0, [r6, #8]
    G_io_apdu_buffer[7] = !IS_UX_ALLOWED;
c0d004ce:	4820      	ldr	r0, [pc, #128]	; (c0d00550 <handleApdu+0x240>)
c0d004d0:	6c80      	ldr	r0, [r0, #72]	; 0x48
c0d004d2:	4241      	negs	r1, r0
c0d004d4:	4141      	adcs	r1, r0
c0d004d6:	3897      	subs	r0, #151	; 0x97
c0d004d8:	4242      	negs	r2, r0
c0d004da:	4142      	adcs	r2, r0
c0d004dc:	430a      	orrs	r2, r1
c0d004de:	71f2      	strb	r2, [r6, #7]
    *tx += 12;
c0d004e0:	6820      	ldr	r0, [r4, #0]
c0d004e2:	300c      	adds	r0, #12
c0d004e4:	e01a      	b.n	c0d0051c <handleApdu+0x20c>
c0d004e6:	4818      	ldr	r0, [pc, #96]	; (c0d00548 <handleApdu+0x238>)
c0d004e8:	1cc0      	adds	r0, r0, #3
c0d004ea:	f001 f89c 	bl	c0d01626 <os_longjmp>
c0d004ee:	206b      	movs	r0, #107	; 0x6b
c0d004f0:	0200      	lsls	r0, r0, #8
c0d004f2:	f001 f898 	bl	c0d01626 <os_longjmp>
        int error_msg_length = strlen(error_msg);
c0d004f6:	4630      	mov	r0, r6
c0d004f8:	f007 f8ac 	bl	c0d07654 <strlen>
c0d004fc:	4605      	mov	r5, r0
        MEMCPY(G_io_apdu_buffer, error_msg, error_msg_length);
c0d004fe:	4811      	ldr	r0, [pc, #68]	; (c0d00544 <handleApdu+0x234>)
c0d00500:	4631      	mov	r1, r6
c0d00502:	462a      	mov	r2, r5
c0d00504:	f006 ff06 	bl	c0d07314 <__aeabi_memcpy>
        *tx += (error_msg_length);
c0d00508:	6820      	ldr	r0, [r4, #0]
c0d0050a:	1940      	adds	r0, r0, r5
c0d0050c:	e000      	b.n	c0d00510 <handleApdu+0x200>
c0d0050e:	2000      	movs	r0, #0
c0d00510:	6020      	str	r0, [r4, #0]
c0d00512:	480d      	ldr	r0, [pc, #52]	; (c0d00548 <handleApdu+0x238>)
c0d00514:	1c40      	adds	r0, r0, #1
c0d00516:	f001 f886 	bl	c0d01626 <os_longjmp>
    *tx = action_addrResponseLen;
c0d0051a:	8838      	ldrh	r0, [r7, #0]
c0d0051c:	6020      	str	r0, [r4, #0]
c0d0051e:	e006      	b.n	c0d0052e <handleApdu+0x21e>
            added = tx_append(&(G_io_apdu_buffer[OFFSET_DATA]), rx - OFFSET_DATA);
c0d00520:	1d70      	adds	r0, r6, #5
c0d00522:	1f7c      	subs	r4, r7, #5
c0d00524:	4621      	mov	r1, r4
c0d00526:	f004 fd0b 	bl	c0d04f40 <tx_append>
            if (added != rx - OFFSET_DATA) {
c0d0052a:	42a0      	cmp	r0, r4
c0d0052c:	d103      	bne.n	c0d00536 <handleApdu+0x226>
c0d0052e:	2009      	movs	r0, #9
c0d00530:	0300      	lsls	r0, r0, #12
c0d00532:	f001 f878 	bl	c0d01626 <os_longjmp>
c0d00536:	4804      	ldr	r0, [pc, #16]	; (c0d00548 <handleApdu+0x238>)
c0d00538:	f001 f875 	bl	c0d01626 <os_longjmp>
c0d0053c:	206d      	movs	r0, #109	; 0x6d
c0d0053e:	0200      	lsls	r0, r0, #8
c0d00540:	f001 f871 	bl	c0d01626 <os_longjmp>
c0d00544:	200002b0 	.word	0x200002b0
c0d00548:	00006983 	.word	0x00006983
c0d0054c:	20000200 	.word	0x20000200
c0d00550:	200005f0 	.word	0x200005f0
c0d00554:	fffffc45 	.word	0xfffffc45
c0d00558:	fffffc1d 	.word	0xfffffc1d
c0d0055c:	00000129 	.word	0x00000129
c0d00560:	00004bf3 	.word	0x00004bf3
c0d00564:	00004bd3 	.word	0x00004bd3
c0d00568:	000001cb 	.word	0x000001cb

c0d0056c <app_reply_address>:
    zeroize_sr25519_signdata();
    set_code(G_io_apdu_buffer, 0, APDU_CODE_DATA_INVALID);
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
}

__Z_INLINE void app_reply_address() {
c0d0056c:	b580      	push	{r7, lr}
    if (action_addrResponseLen == 0) {
c0d0056e:	480c      	ldr	r0, [pc, #48]	; (c0d005a0 <app_reply_address+0x34>)
c0d00570:	8800      	ldrh	r0, [r0, #0]
c0d00572:	2800      	cmp	r0, #0
c0d00574:	d008      	beq.n	c0d00588 <app_reply_address+0x1c>
#define APDU_CODE_UNKNOWN                   0x6F00
#define APDU_CODE_SIGN_VERIFY_ERROR         0x6F01


__Z_INLINE void set_code(uint8_t *buffer, uint8_t offset, uint16_t value) {
    *(buffer + offset) = (uint8_t) (value >> 8);
c0d00576:	b2c1      	uxtb	r1, r0
c0d00578:	4a0a      	ldr	r2, [pc, #40]	; (c0d005a4 <app_reply_address+0x38>)
c0d0057a:	2390      	movs	r3, #144	; 0x90
c0d0057c:	5453      	strb	r3, [r2, r1]
c0d0057e:	1851      	adds	r1, r2, r1
c0d00580:	2200      	movs	r2, #0
    *(buffer + offset + 1) = (uint8_t) (value & 0xFF);
c0d00582:	704a      	strb	r2, [r1, #1]
        app_reply_error();
        return;
    }
    set_code(G_io_apdu_buffer, action_addrResponseLen, APDU_CODE_OK);
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, action_addrResponseLen + 2);
c0d00584:	1c80      	adds	r0, r0, #2
c0d00586:	e005      	b.n	c0d00594 <app_reply_address+0x28>
    *(buffer + offset) = (uint8_t) (value >> 8);
c0d00588:	4806      	ldr	r0, [pc, #24]	; (c0d005a4 <app_reply_address+0x38>)
c0d0058a:	2184      	movs	r1, #132	; 0x84
    *(buffer + offset + 1) = (uint8_t) (value & 0xFF);
c0d0058c:	7041      	strb	r1, [r0, #1]
c0d0058e:	2169      	movs	r1, #105	; 0x69
    *(buffer + offset) = (uint8_t) (value >> 8);
c0d00590:	7001      	strb	r1, [r0, #0]
c0d00592:	2002      	movs	r0, #2
c0d00594:	b281      	uxth	r1, r0
c0d00596:	2020      	movs	r0, #32
c0d00598:	f001 fb66 	bl	c0d01c68 <io_exchange>
}
c0d0059c:	bd80      	pop	{r7, pc}
c0d0059e:	46c0      	nop			; (mov r8, r8)
c0d005a0:	20000200 	.word	0x20000200
c0d005a4:	200002b0 	.word	0x200002b0

c0d005a8 <app_sign_ed25519>:
__Z_INLINE void app_sign_ed25519() {
c0d005a8:	b570      	push	{r4, r5, r6, lr}
c0d005aa:	b082      	sub	sp, #8
    const uint8_t *message = tx_get_buffer();
c0d005ac:	f004 fcd1 	bl	c0d04f52 <tx_get_buffer>
c0d005b0:	4605      	mov	r5, r0
    const uint16_t messageLength = tx_get_buffer_length();
c0d005b2:	f004 fcc9 	bl	c0d04f48 <tx_get_buffer_length>
c0d005b6:	a901      	add	r1, sp, #4
c0d005b8:	2600      	movs	r6, #0
    uint16_t replyLen = 0;
c0d005ba:	800e      	strh	r6, [r1, #0]
    zxerr_t err = crypto_sign_ed25519(G_io_apdu_buffer, IO_APDU_BUFFER_SIZE - 3,
c0d005bc:	9100      	str	r1, [sp, #0]
c0d005be:	21ff      	movs	r1, #255	; 0xff
c0d005c0:	3102      	adds	r1, #2
c0d005c2:	b283      	uxth	r3, r0
c0d005c4:	4c0b      	ldr	r4, [pc, #44]	; (c0d005f4 <app_sign_ed25519+0x4c>)
c0d005c6:	4620      	mov	r0, r4
c0d005c8:	462a      	mov	r2, r5
c0d005ca:	f000 fec9 	bl	c0d01360 <crypto_sign_ed25519>
    if (err != zxerr_ok) {
c0d005ce:	2803      	cmp	r0, #3
c0d005d0:	d106      	bne.n	c0d005e0 <app_sign_ed25519+0x38>
c0d005d2:	2042      	movs	r0, #66	; 0x42
    *(buffer + offset + 1) = (uint8_t) (value & 0xFF);
c0d005d4:	5426      	strb	r6, [r4, r0]
c0d005d6:	2041      	movs	r0, #65	; 0x41
c0d005d8:	2190      	movs	r1, #144	; 0x90
    *(buffer + offset) = (uint8_t) (value >> 8);
c0d005da:	5421      	strb	r1, [r4, r0]
c0d005dc:	2143      	movs	r1, #67	; 0x43
c0d005de:	e004      	b.n	c0d005ea <app_sign_ed25519+0x42>
c0d005e0:	2001      	movs	r0, #1
    *(buffer + offset + 1) = (uint8_t) (value & 0xFF);
c0d005e2:	7060      	strb	r0, [r4, #1]
c0d005e4:	206f      	movs	r0, #111	; 0x6f
    *(buffer + offset) = (uint8_t) (value >> 8);
c0d005e6:	7020      	strb	r0, [r4, #0]
c0d005e8:	2102      	movs	r1, #2
c0d005ea:	2020      	movs	r0, #32
c0d005ec:	f001 fb3c 	bl	c0d01c68 <io_exchange>
}
c0d005f0:	b002      	add	sp, #8
c0d005f2:	bd70      	pop	{r4, r5, r6, pc}
c0d005f4:	200002b0 	.word	0x200002b0

c0d005f8 <io_event>:
#include "zxmacros.h"
#include "app_mode.h"

unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

unsigned char io_event(unsigned char channel) {
c0d005f8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005fa:	b081      	sub	sp, #4
    UNUSED(channel);

    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d005fc:	4ee9      	ldr	r6, [pc, #932]	; (c0d009a4 <io_event+0x3ac>)
c0d005fe:	7830      	ldrb	r0, [r6, #0]
c0d00600:	280c      	cmp	r0, #12
c0d00602:	dc05      	bgt.n	c0d00610 <io_event+0x18>
c0d00604:	2805      	cmp	r0, #5
c0d00606:	d05d      	beq.n	c0d006c4 <io_event+0xcc>
c0d00608:	280c      	cmp	r0, #12
c0d0060a:	d100      	bne.n	c0d0060e <io_event+0x16>
c0d0060c:	e209      	b.n	c0d00a22 <io_event+0x42a>
c0d0060e:	e0fe      	b.n	c0d0080e <io_event+0x216>
c0d00610:	280d      	cmp	r0, #13
c0d00612:	d100      	bne.n	c0d00616 <io_event+0x1e>
c0d00614:	e0af      	b.n	c0d00776 <io_event+0x17e>
c0d00616:	280e      	cmp	r0, #14
c0d00618:	d000      	beq.n	c0d0061c <io_event+0x24>
c0d0061a:	e0f8      	b.n	c0d0080e <io_event+0x216>
c0d0061c:	2044      	movs	r0, #68	; 0x44
                UX_DISPLAYED_EVENT();
            }
            break;

        case SEPROXYHAL_TAG_TICKER_EVENT: { //
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d0061e:	4ee2      	ldr	r6, [pc, #904]	; (c0d009a8 <io_event+0x3b0>)
c0d00620:	2101      	movs	r1, #1
c0d00622:	5431      	strb	r1, [r6, r0]
c0d00624:	4635      	mov	r5, r6
c0d00626:	3544      	adds	r5, #68	; 0x44
c0d00628:	2700      	movs	r7, #0
c0d0062a:	606f      	str	r7, [r5, #4]
c0d0062c:	4628      	mov	r0, r5
c0d0062e:	f004 fbd9 	bl	c0d04de4 <os_ux>
c0d00632:	2004      	movs	r0, #4
c0d00634:	f004 fc62 	bl	c0d04efc <os_sched_last_status>
c0d00638:	6068      	str	r0, [r5, #4]
c0d0063a:	2869      	cmp	r0, #105	; 0x69
c0d0063c:	d000      	beq.n	c0d00640 <io_event+0x48>
c0d0063e:	e139      	b.n	c0d008b4 <io_event+0x2bc>
c0d00640:	f001 f9e6 	bl	c0d01a10 <io_seproxyhal_init_ux>
c0d00644:	f001 f9e6 	bl	c0d01a14 <io_seproxyhal_init_button>
c0d00648:	2000      	movs	r0, #0
c0d0064a:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d0064c:	2004      	movs	r0, #4
c0d0064e:	f004 fc55 	bl	c0d04efc <os_sched_last_status>
c0d00652:	64b0      	str	r0, [r6, #72]	; 0x48
c0d00654:	2800      	cmp	r0, #0
c0d00656:	d100      	bne.n	c0d0065a <io_event+0x62>
c0d00658:	e1e3      	b.n	c0d00a22 <io_event+0x42a>
c0d0065a:	2897      	cmp	r0, #151	; 0x97
c0d0065c:	d100      	bne.n	c0d00660 <io_event+0x68>
c0d0065e:	e1e0      	b.n	c0d00a22 <io_event+0x42a>
c0d00660:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d00662:	2800      	cmp	r0, #0
c0d00664:	d100      	bne.n	c0d00668 <io_event+0x70>
c0d00666:	e1dc      	b.n	c0d00a22 <io_event+0x42a>
c0d00668:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d0066a:	212c      	movs	r1, #44	; 0x2c
c0d0066c:	5c71      	ldrb	r1, [r6, r1]
c0d0066e:	b280      	uxth	r0, r0
c0d00670:	4288      	cmp	r0, r1
c0d00672:	d300      	bcc.n	c0d00676 <io_event+0x7e>
c0d00674:	e1d5      	b.n	c0d00a22 <io_event+0x42a>
c0d00676:	f004 fc0d 	bl	c0d04e94 <io_seph_is_status_sent>
c0d0067a:	2800      	cmp	r0, #0
c0d0067c:	d000      	beq.n	c0d00680 <io_event+0x88>
c0d0067e:	e1d0      	b.n	c0d00a22 <io_event+0x42a>
c0d00680:	f004 fb72 	bl	c0d04d68 <os_perso_isonboarded>
c0d00684:	28aa      	cmp	r0, #170	; 0xaa
c0d00686:	d104      	bne.n	c0d00692 <io_event+0x9a>
c0d00688:	f004 fb9e 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d0068c:	28aa      	cmp	r0, #170	; 0xaa
c0d0068e:	d000      	beq.n	c0d00692 <io_event+0x9a>
c0d00690:	e1c7      	b.n	c0d00a22 <io_event+0x42a>
c0d00692:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00694:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d00696:	0150      	lsls	r0, r2, #5
c0d00698:	1808      	adds	r0, r1, r0
c0d0069a:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d0069c:	2b00      	cmp	r3, #0
c0d0069e:	d004      	beq.n	c0d006aa <io_event+0xb2>
c0d006a0:	4798      	blx	r3
c0d006a2:	2800      	cmp	r0, #0
c0d006a4:	d007      	beq.n	c0d006b6 <io_event+0xbe>
c0d006a6:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d006a8:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d006aa:	2801      	cmp	r0, #1
c0d006ac:	d101      	bne.n	c0d006b2 <io_event+0xba>
c0d006ae:	0150      	lsls	r0, r2, #5
c0d006b0:	1808      	adds	r0, r1, r0
c0d006b2:	f005 feb1 	bl	c0d06418 <io_seproxyhal_display>
c0d006b6:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d006b8:	1c40      	adds	r0, r0, #1
c0d006ba:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d006bc:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d006be:	2900      	cmp	r1, #0
c0d006c0:	d1d3      	bne.n	c0d0066a <io_event+0x72>
c0d006c2:	e1ae      	b.n	c0d00a22 <io_event+0x42a>
c0d006c4:	2044      	movs	r0, #68	; 0x44
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d006c6:	4ddb      	ldr	r5, [pc, #876]	; (c0d00a34 <io_event+0x43c>)
c0d006c8:	2101      	movs	r1, #1
c0d006ca:	5429      	strb	r1, [r5, r0]
c0d006cc:	462c      	mov	r4, r5
c0d006ce:	3444      	adds	r4, #68	; 0x44
c0d006d0:	2700      	movs	r7, #0
c0d006d2:	6067      	str	r7, [r4, #4]
c0d006d4:	4620      	mov	r0, r4
c0d006d6:	f004 fb85 	bl	c0d04de4 <os_ux>
c0d006da:	2004      	movs	r0, #4
c0d006dc:	f004 fc0e 	bl	c0d04efc <os_sched_last_status>
c0d006e0:	6060      	str	r0, [r4, #4]
c0d006e2:	2800      	cmp	r0, #0
c0d006e4:	d100      	bne.n	c0d006e8 <io_event+0xf0>
c0d006e6:	e19c      	b.n	c0d00a22 <io_event+0x42a>
c0d006e8:	2897      	cmp	r0, #151	; 0x97
c0d006ea:	d100      	bne.n	c0d006ee <io_event+0xf6>
c0d006ec:	e199      	b.n	c0d00a22 <io_event+0x42a>
c0d006ee:	2869      	cmp	r0, #105	; 0x69
c0d006f0:	d000      	beq.n	c0d006f4 <io_event+0xfc>
c0d006f2:	e15b      	b.n	c0d009ac <io_event+0x3b4>
c0d006f4:	f001 f98c 	bl	c0d01a10 <io_seproxyhal_init_ux>
c0d006f8:	f001 f98c 	bl	c0d01a14 <io_seproxyhal_init_button>
c0d006fc:	84ef      	strh	r7, [r5, #38]	; 0x26
c0d006fe:	2004      	movs	r0, #4
c0d00700:	f004 fbfc 	bl	c0d04efc <os_sched_last_status>
c0d00704:	64a8      	str	r0, [r5, #72]	; 0x48
c0d00706:	2800      	cmp	r0, #0
c0d00708:	d100      	bne.n	c0d0070c <io_event+0x114>
c0d0070a:	e18a      	b.n	c0d00a22 <io_event+0x42a>
c0d0070c:	2897      	cmp	r0, #151	; 0x97
c0d0070e:	d100      	bne.n	c0d00712 <io_event+0x11a>
c0d00710:	e187      	b.n	c0d00a22 <io_event+0x42a>
c0d00712:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00714:	2800      	cmp	r0, #0
c0d00716:	d100      	bne.n	c0d0071a <io_event+0x122>
c0d00718:	e183      	b.n	c0d00a22 <io_event+0x42a>
c0d0071a:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d0071c:	212c      	movs	r1, #44	; 0x2c
c0d0071e:	5c69      	ldrb	r1, [r5, r1]
c0d00720:	b280      	uxth	r0, r0
c0d00722:	4288      	cmp	r0, r1
c0d00724:	d300      	bcc.n	c0d00728 <io_event+0x130>
c0d00726:	e17c      	b.n	c0d00a22 <io_event+0x42a>
c0d00728:	f004 fbb4 	bl	c0d04e94 <io_seph_is_status_sent>
c0d0072c:	2800      	cmp	r0, #0
c0d0072e:	d000      	beq.n	c0d00732 <io_event+0x13a>
c0d00730:	e177      	b.n	c0d00a22 <io_event+0x42a>
c0d00732:	f004 fb19 	bl	c0d04d68 <os_perso_isonboarded>
c0d00736:	28aa      	cmp	r0, #170	; 0xaa
c0d00738:	d104      	bne.n	c0d00744 <io_event+0x14c>
c0d0073a:	f004 fb45 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d0073e:	28aa      	cmp	r0, #170	; 0xaa
c0d00740:	d000      	beq.n	c0d00744 <io_event+0x14c>
c0d00742:	e16e      	b.n	c0d00a22 <io_event+0x42a>
c0d00744:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d00746:	8cea      	ldrh	r2, [r5, #38]	; 0x26
c0d00748:	0150      	lsls	r0, r2, #5
c0d0074a:	1808      	adds	r0, r1, r0
c0d0074c:	6b2b      	ldr	r3, [r5, #48]	; 0x30
c0d0074e:	2b00      	cmp	r3, #0
c0d00750:	d004      	beq.n	c0d0075c <io_event+0x164>
c0d00752:	4798      	blx	r3
c0d00754:	2800      	cmp	r0, #0
c0d00756:	d007      	beq.n	c0d00768 <io_event+0x170>
c0d00758:	8cea      	ldrh	r2, [r5, #38]	; 0x26
c0d0075a:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d0075c:	2801      	cmp	r0, #1
c0d0075e:	d101      	bne.n	c0d00764 <io_event+0x16c>
c0d00760:	0150      	lsls	r0, r2, #5
c0d00762:	1808      	adds	r0, r1, r0
c0d00764:	f005 fe58 	bl	c0d06418 <io_seproxyhal_display>
c0d00768:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d0076a:	1c40      	adds	r0, r0, #1
c0d0076c:	84e8      	strh	r0, [r5, #38]	; 0x26
c0d0076e:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d00770:	2900      	cmp	r1, #0
c0d00772:	d1d3      	bne.n	c0d0071c <io_event+0x124>
c0d00774:	e155      	b.n	c0d00a22 <io_event+0x42a>
c0d00776:	252c      	movs	r5, #44	; 0x2c
            if (!UX_DISPLAYED()) {
c0d00778:	4eef      	ldr	r6, [pc, #956]	; (c0d00b38 <io_event+0x540>)
c0d0077a:	5d70      	ldrb	r0, [r6, r5]
c0d0077c:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d0077e:	4281      	cmp	r1, r0
c0d00780:	d300      	bcc.n	c0d00784 <io_event+0x18c>
c0d00782:	e14e      	b.n	c0d00a22 <io_event+0x42a>
c0d00784:	2044      	movs	r0, #68	; 0x44
c0d00786:	2101      	movs	r1, #1
                UX_DISPLAYED_EVENT();
c0d00788:	5431      	strb	r1, [r6, r0]
c0d0078a:	4634      	mov	r4, r6
c0d0078c:	3444      	adds	r4, #68	; 0x44
c0d0078e:	2700      	movs	r7, #0
c0d00790:	6067      	str	r7, [r4, #4]
c0d00792:	4620      	mov	r0, r4
c0d00794:	f004 fb26 	bl	c0d04de4 <os_ux>
c0d00798:	2004      	movs	r0, #4
c0d0079a:	f004 fbaf 	bl	c0d04efc <os_sched_last_status>
c0d0079e:	6060      	str	r0, [r4, #4]
c0d007a0:	2800      	cmp	r0, #0
c0d007a2:	d100      	bne.n	c0d007a6 <io_event+0x1ae>
c0d007a4:	e13d      	b.n	c0d00a22 <io_event+0x42a>
c0d007a6:	2869      	cmp	r0, #105	; 0x69
c0d007a8:	d100      	bne.n	c0d007ac <io_event+0x1b4>
c0d007aa:	e145      	b.n	c0d00a38 <io_event+0x440>
c0d007ac:	2897      	cmp	r0, #151	; 0x97
c0d007ae:	d100      	bne.n	c0d007b2 <io_event+0x1ba>
c0d007b0:	e137      	b.n	c0d00a22 <io_event+0x42a>
c0d007b2:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d007b4:	2800      	cmp	r0, #0
c0d007b6:	d028      	beq.n	c0d0080a <io_event+0x212>
c0d007b8:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d007ba:	5d71      	ldrb	r1, [r6, r5]
c0d007bc:	b280      	uxth	r0, r0
c0d007be:	4288      	cmp	r0, r1
c0d007c0:	d223      	bcs.n	c0d0080a <io_event+0x212>
c0d007c2:	f004 fb67 	bl	c0d04e94 <io_seph_is_status_sent>
c0d007c6:	2800      	cmp	r0, #0
c0d007c8:	d11f      	bne.n	c0d0080a <io_event+0x212>
c0d007ca:	f004 facd 	bl	c0d04d68 <os_perso_isonboarded>
c0d007ce:	28aa      	cmp	r0, #170	; 0xaa
c0d007d0:	d103      	bne.n	c0d007da <io_event+0x1e2>
c0d007d2:	f004 faf9 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d007d6:	28aa      	cmp	r0, #170	; 0xaa
c0d007d8:	d117      	bne.n	c0d0080a <io_event+0x212>
c0d007da:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d007dc:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d007de:	0150      	lsls	r0, r2, #5
c0d007e0:	1808      	adds	r0, r1, r0
c0d007e2:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d007e4:	2b00      	cmp	r3, #0
c0d007e6:	d004      	beq.n	c0d007f2 <io_event+0x1fa>
c0d007e8:	4798      	blx	r3
c0d007ea:	2800      	cmp	r0, #0
c0d007ec:	d007      	beq.n	c0d007fe <io_event+0x206>
c0d007ee:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d007f0:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d007f2:	2801      	cmp	r0, #1
c0d007f4:	d101      	bne.n	c0d007fa <io_event+0x202>
c0d007f6:	0150      	lsls	r0, r2, #5
c0d007f8:	1808      	adds	r0, r1, r0
c0d007fa:	f005 fe0d 	bl	c0d06418 <io_seproxyhal_display>
c0d007fe:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d00800:	1c40      	adds	r0, r0, #1
c0d00802:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d00804:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00806:	2900      	cmp	r1, #0
c0d00808:	d1d7      	bne.n	c0d007ba <io_event+0x1c2>
c0d0080a:	5d70      	ldrb	r0, [r6, r5]
c0d0080c:	e09a      	b.n	c0d00944 <io_event+0x34c>
c0d0080e:	2044      	movs	r0, #68	; 0x44
            break;
        }

            // unknown events are acknowledged
        default:
            UX_DEFAULT_EVENT();
c0d00810:	4dc9      	ldr	r5, [pc, #804]	; (c0d00b38 <io_event+0x540>)
c0d00812:	2101      	movs	r1, #1
c0d00814:	5429      	strb	r1, [r5, r0]
c0d00816:	462c      	mov	r4, r5
c0d00818:	3444      	adds	r4, #68	; 0x44
c0d0081a:	2600      	movs	r6, #0
c0d0081c:	6066      	str	r6, [r4, #4]
c0d0081e:	4620      	mov	r0, r4
c0d00820:	f004 fae0 	bl	c0d04de4 <os_ux>
c0d00824:	2004      	movs	r0, #4
c0d00826:	f004 fb69 	bl	c0d04efc <os_sched_last_status>
c0d0082a:	6060      	str	r0, [r4, #4]
c0d0082c:	2869      	cmp	r0, #105	; 0x69
c0d0082e:	d000      	beq.n	c0d00832 <io_event+0x23a>
c0d00830:	e08a      	b.n	c0d00948 <io_event+0x350>
c0d00832:	f001 f8ed 	bl	c0d01a10 <io_seproxyhal_init_ux>
c0d00836:	f001 f8ed 	bl	c0d01a14 <io_seproxyhal_init_button>
c0d0083a:	84ee      	strh	r6, [r5, #38]	; 0x26
c0d0083c:	2004      	movs	r0, #4
c0d0083e:	f004 fb5d 	bl	c0d04efc <os_sched_last_status>
c0d00842:	64a8      	str	r0, [r5, #72]	; 0x48
c0d00844:	2800      	cmp	r0, #0
c0d00846:	d100      	bne.n	c0d0084a <io_event+0x252>
c0d00848:	e0eb      	b.n	c0d00a22 <io_event+0x42a>
c0d0084a:	2897      	cmp	r0, #151	; 0x97
c0d0084c:	d100      	bne.n	c0d00850 <io_event+0x258>
c0d0084e:	e0e8      	b.n	c0d00a22 <io_event+0x42a>
c0d00850:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00852:	2800      	cmp	r0, #0
c0d00854:	d100      	bne.n	c0d00858 <io_event+0x260>
c0d00856:	e0e4      	b.n	c0d00a22 <io_event+0x42a>
c0d00858:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d0085a:	212c      	movs	r1, #44	; 0x2c
c0d0085c:	5c69      	ldrb	r1, [r5, r1]
c0d0085e:	b280      	uxth	r0, r0
c0d00860:	4288      	cmp	r0, r1
c0d00862:	d300      	bcc.n	c0d00866 <io_event+0x26e>
c0d00864:	e0dd      	b.n	c0d00a22 <io_event+0x42a>
c0d00866:	f004 fb15 	bl	c0d04e94 <io_seph_is_status_sent>
c0d0086a:	2800      	cmp	r0, #0
c0d0086c:	d000      	beq.n	c0d00870 <io_event+0x278>
c0d0086e:	e0d8      	b.n	c0d00a22 <io_event+0x42a>
c0d00870:	f004 fa7a 	bl	c0d04d68 <os_perso_isonboarded>
c0d00874:	28aa      	cmp	r0, #170	; 0xaa
c0d00876:	d104      	bne.n	c0d00882 <io_event+0x28a>
c0d00878:	f004 faa6 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d0087c:	28aa      	cmp	r0, #170	; 0xaa
c0d0087e:	d000      	beq.n	c0d00882 <io_event+0x28a>
c0d00880:	e0cf      	b.n	c0d00a22 <io_event+0x42a>
c0d00882:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d00884:	8cea      	ldrh	r2, [r5, #38]	; 0x26
c0d00886:	0150      	lsls	r0, r2, #5
c0d00888:	1808      	adds	r0, r1, r0
c0d0088a:	6b2b      	ldr	r3, [r5, #48]	; 0x30
c0d0088c:	2b00      	cmp	r3, #0
c0d0088e:	d004      	beq.n	c0d0089a <io_event+0x2a2>
c0d00890:	4798      	blx	r3
c0d00892:	2800      	cmp	r0, #0
c0d00894:	d007      	beq.n	c0d008a6 <io_event+0x2ae>
c0d00896:	8cea      	ldrh	r2, [r5, #38]	; 0x26
c0d00898:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d0089a:	2801      	cmp	r0, #1
c0d0089c:	d101      	bne.n	c0d008a2 <io_event+0x2aa>
c0d0089e:	0150      	lsls	r0, r2, #5
c0d008a0:	1808      	adds	r0, r1, r0
c0d008a2:	f005 fdb9 	bl	c0d06418 <io_seproxyhal_display>
c0d008a6:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d008a8:	1c40      	adds	r0, r0, #1
c0d008aa:	84e8      	strh	r0, [r5, #38]	; 0x26
c0d008ac:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d008ae:	2900      	cmp	r1, #0
c0d008b0:	d1d3      	bne.n	c0d0085a <io_event+0x262>
c0d008b2:	e0b6      	b.n	c0d00a22 <io_event+0x42a>
c0d008b4:	4604      	mov	r4, r0
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d008b6:	6bf0      	ldr	r0, [r6, #60]	; 0x3c
c0d008b8:	2800      	cmp	r0, #0
c0d008ba:	d00e      	beq.n	c0d008da <io_event+0x2e2>
c0d008bc:	4601      	mov	r1, r0
c0d008be:	3964      	subs	r1, #100	; 0x64
c0d008c0:	d200      	bcs.n	c0d008c4 <io_event+0x2cc>
c0d008c2:	4639      	mov	r1, r7
c0d008c4:	63f1      	str	r1, [r6, #60]	; 0x3c
c0d008c6:	2864      	cmp	r0, #100	; 0x64
c0d008c8:	d807      	bhi.n	c0d008da <io_event+0x2e2>
c0d008ca:	6bb1      	ldr	r1, [r6, #56]	; 0x38
c0d008cc:	2900      	cmp	r1, #0
c0d008ce:	d100      	bne.n	c0d008d2 <io_event+0x2da>
c0d008d0:	e0ec      	b.n	c0d00aac <io_event+0x4b4>
c0d008d2:	6c30      	ldr	r0, [r6, #64]	; 0x40
c0d008d4:	63f0      	str	r0, [r6, #60]	; 0x3c
c0d008d6:	2000      	movs	r0, #0
c0d008d8:	4788      	blx	r1
c0d008da:	2c00      	cmp	r4, #0
c0d008dc:	d100      	bne.n	c0d008e0 <io_event+0x2e8>
c0d008de:	e0a0      	b.n	c0d00a22 <io_event+0x42a>
c0d008e0:	2c97      	cmp	r4, #151	; 0x97
c0d008e2:	d100      	bne.n	c0d008e6 <io_event+0x2ee>
c0d008e4:	e09d      	b.n	c0d00a22 <io_event+0x42a>
c0d008e6:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d008e8:	2800      	cmp	r0, #0
c0d008ea:	d029      	beq.n	c0d00940 <io_event+0x348>
c0d008ec:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d008ee:	212c      	movs	r1, #44	; 0x2c
c0d008f0:	5c71      	ldrb	r1, [r6, r1]
c0d008f2:	b280      	uxth	r0, r0
c0d008f4:	4288      	cmp	r0, r1
c0d008f6:	d223      	bcs.n	c0d00940 <io_event+0x348>
c0d008f8:	f004 facc 	bl	c0d04e94 <io_seph_is_status_sent>
c0d008fc:	2800      	cmp	r0, #0
c0d008fe:	d11f      	bne.n	c0d00940 <io_event+0x348>
c0d00900:	f004 fa32 	bl	c0d04d68 <os_perso_isonboarded>
c0d00904:	28aa      	cmp	r0, #170	; 0xaa
c0d00906:	d103      	bne.n	c0d00910 <io_event+0x318>
c0d00908:	f004 fa5e 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d0090c:	28aa      	cmp	r0, #170	; 0xaa
c0d0090e:	d117      	bne.n	c0d00940 <io_event+0x348>
c0d00910:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00912:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d00914:	0150      	lsls	r0, r2, #5
c0d00916:	1808      	adds	r0, r1, r0
c0d00918:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d0091a:	2b00      	cmp	r3, #0
c0d0091c:	d004      	beq.n	c0d00928 <io_event+0x330>
c0d0091e:	4798      	blx	r3
c0d00920:	2800      	cmp	r0, #0
c0d00922:	d007      	beq.n	c0d00934 <io_event+0x33c>
c0d00924:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d00926:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00928:	2801      	cmp	r0, #1
c0d0092a:	d101      	bne.n	c0d00930 <io_event+0x338>
c0d0092c:	0150      	lsls	r0, r2, #5
c0d0092e:	1808      	adds	r0, r1, r0
c0d00930:	f005 fd72 	bl	c0d06418 <io_seproxyhal_display>
c0d00934:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d00936:	1c40      	adds	r0, r0, #1
c0d00938:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d0093a:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d0093c:	2900      	cmp	r1, #0
c0d0093e:	d1d6      	bne.n	c0d008ee <io_event+0x2f6>
c0d00940:	202c      	movs	r0, #44	; 0x2c
c0d00942:	5c30      	ldrb	r0, [r6, r0]
c0d00944:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d00946:	e068      	b.n	c0d00a1a <io_event+0x422>
            UX_DEFAULT_EVENT();
c0d00948:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d0094a:	2800      	cmp	r0, #0
c0d0094c:	d062      	beq.n	c0d00a14 <io_event+0x41c>
c0d0094e:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d00950:	212c      	movs	r1, #44	; 0x2c
c0d00952:	5c69      	ldrb	r1, [r5, r1]
c0d00954:	b280      	uxth	r0, r0
c0d00956:	4288      	cmp	r0, r1
c0d00958:	d25c      	bcs.n	c0d00a14 <io_event+0x41c>
c0d0095a:	f004 fa9b 	bl	c0d04e94 <io_seph_is_status_sent>
c0d0095e:	2800      	cmp	r0, #0
c0d00960:	d158      	bne.n	c0d00a14 <io_event+0x41c>
c0d00962:	f004 fa01 	bl	c0d04d68 <os_perso_isonboarded>
c0d00966:	28aa      	cmp	r0, #170	; 0xaa
c0d00968:	d103      	bne.n	c0d00972 <io_event+0x37a>
c0d0096a:	f004 fa2d 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d0096e:	28aa      	cmp	r0, #170	; 0xaa
c0d00970:	d150      	bne.n	c0d00a14 <io_event+0x41c>
c0d00972:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d00974:	8cea      	ldrh	r2, [r5, #38]	; 0x26
c0d00976:	0150      	lsls	r0, r2, #5
c0d00978:	1808      	adds	r0, r1, r0
c0d0097a:	6b2b      	ldr	r3, [r5, #48]	; 0x30
c0d0097c:	2b00      	cmp	r3, #0
c0d0097e:	d004      	beq.n	c0d0098a <io_event+0x392>
c0d00980:	4798      	blx	r3
c0d00982:	2800      	cmp	r0, #0
c0d00984:	d007      	beq.n	c0d00996 <io_event+0x39e>
c0d00986:	8cea      	ldrh	r2, [r5, #38]	; 0x26
c0d00988:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d0098a:	2801      	cmp	r0, #1
c0d0098c:	d101      	bne.n	c0d00992 <io_event+0x39a>
c0d0098e:	0150      	lsls	r0, r2, #5
c0d00990:	1808      	adds	r0, r1, r0
c0d00992:	f005 fd41 	bl	c0d06418 <io_seproxyhal_display>
c0d00996:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d00998:	1c40      	adds	r0, r0, #1
c0d0099a:	84e8      	strh	r0, [r5, #38]	; 0x26
c0d0099c:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d0099e:	2900      	cmp	r1, #0
c0d009a0:	d1d6      	bne.n	c0d00950 <io_event+0x358>
c0d009a2:	e037      	b.n	c0d00a14 <io_event+0x41c>
c0d009a4:	20000202 	.word	0x20000202
c0d009a8:	200005f0 	.word	0x200005f0
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d009ac:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d009ae:	2800      	cmp	r0, #0
c0d009b0:	d003      	beq.n	c0d009ba <io_event+0x3c2>
c0d009b2:	78f1      	ldrb	r1, [r6, #3]
c0d009b4:	0849      	lsrs	r1, r1, #1
c0d009b6:	f001 f8f9 	bl	c0d01bac <io_seproxyhal_button_push>
c0d009ba:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d009bc:	2800      	cmp	r0, #0
c0d009be:	d029      	beq.n	c0d00a14 <io_event+0x41c>
c0d009c0:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d009c2:	212c      	movs	r1, #44	; 0x2c
c0d009c4:	5c69      	ldrb	r1, [r5, r1]
c0d009c6:	b280      	uxth	r0, r0
c0d009c8:	4288      	cmp	r0, r1
c0d009ca:	d223      	bcs.n	c0d00a14 <io_event+0x41c>
c0d009cc:	f004 fa62 	bl	c0d04e94 <io_seph_is_status_sent>
c0d009d0:	2800      	cmp	r0, #0
c0d009d2:	d11f      	bne.n	c0d00a14 <io_event+0x41c>
c0d009d4:	f004 f9c8 	bl	c0d04d68 <os_perso_isonboarded>
c0d009d8:	28aa      	cmp	r0, #170	; 0xaa
c0d009da:	d103      	bne.n	c0d009e4 <io_event+0x3ec>
c0d009dc:	f004 f9f4 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d009e0:	28aa      	cmp	r0, #170	; 0xaa
c0d009e2:	d117      	bne.n	c0d00a14 <io_event+0x41c>
c0d009e4:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d009e6:	8cea      	ldrh	r2, [r5, #38]	; 0x26
c0d009e8:	0150      	lsls	r0, r2, #5
c0d009ea:	1808      	adds	r0, r1, r0
c0d009ec:	6b2b      	ldr	r3, [r5, #48]	; 0x30
c0d009ee:	2b00      	cmp	r3, #0
c0d009f0:	d004      	beq.n	c0d009fc <io_event+0x404>
c0d009f2:	4798      	blx	r3
c0d009f4:	2800      	cmp	r0, #0
c0d009f6:	d007      	beq.n	c0d00a08 <io_event+0x410>
c0d009f8:	8cea      	ldrh	r2, [r5, #38]	; 0x26
c0d009fa:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d009fc:	2801      	cmp	r0, #1
c0d009fe:	d101      	bne.n	c0d00a04 <io_event+0x40c>
c0d00a00:	0150      	lsls	r0, r2, #5
c0d00a02:	1808      	adds	r0, r1, r0
c0d00a04:	f005 fd08 	bl	c0d06418 <io_seproxyhal_display>
c0d00a08:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d00a0a:	1c40      	adds	r0, r0, #1
c0d00a0c:	84e8      	strh	r0, [r5, #38]	; 0x26
c0d00a0e:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d00a10:	2900      	cmp	r1, #0
c0d00a12:	d1d6      	bne.n	c0d009c2 <io_event+0x3ca>
c0d00a14:	202c      	movs	r0, #44	; 0x2c
c0d00a16:	5c28      	ldrb	r0, [r5, r0]
c0d00a18:	8ce9      	ldrh	r1, [r5, #38]	; 0x26
c0d00a1a:	4281      	cmp	r1, r0
c0d00a1c:	d301      	bcc.n	c0d00a22 <io_event+0x42a>
c0d00a1e:	f004 fa39 	bl	c0d04e94 <io_seph_is_status_sent>
            break;
    }
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00a22:	f004 fa37 	bl	c0d04e94 <io_seph_is_status_sent>
c0d00a26:	2800      	cmp	r0, #0
c0d00a28:	d101      	bne.n	c0d00a2e <io_event+0x436>
        io_seproxyhal_general_status();
c0d00a2a:	f000 fec7 	bl	c0d017bc <io_seproxyhal_general_status>
c0d00a2e:	2001      	movs	r0, #1
    }
    return 1; // DO NOT reset the current APDU transport
c0d00a30:	b001      	add	sp, #4
c0d00a32:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00a34:	200005f0 	.word	0x200005f0
                UX_DISPLAYED_EVENT();
c0d00a38:	f000 ffea 	bl	c0d01a10 <io_seproxyhal_init_ux>
c0d00a3c:	f000 ffea 	bl	c0d01a14 <io_seproxyhal_init_button>
c0d00a40:	84f7      	strh	r7, [r6, #38]	; 0x26
c0d00a42:	2004      	movs	r0, #4
c0d00a44:	f004 fa5a 	bl	c0d04efc <os_sched_last_status>
c0d00a48:	64b0      	str	r0, [r6, #72]	; 0x48
c0d00a4a:	2800      	cmp	r0, #0
c0d00a4c:	d0e9      	beq.n	c0d00a22 <io_event+0x42a>
c0d00a4e:	2897      	cmp	r0, #151	; 0x97
c0d00a50:	d0e7      	beq.n	c0d00a22 <io_event+0x42a>
c0d00a52:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d00a54:	2800      	cmp	r0, #0
c0d00a56:	d0e4      	beq.n	c0d00a22 <io_event+0x42a>
c0d00a58:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d00a5a:	5d71      	ldrb	r1, [r6, r5]
c0d00a5c:	b280      	uxth	r0, r0
c0d00a5e:	4288      	cmp	r0, r1
c0d00a60:	d2df      	bcs.n	c0d00a22 <io_event+0x42a>
c0d00a62:	f004 fa17 	bl	c0d04e94 <io_seph_is_status_sent>
c0d00a66:	2800      	cmp	r0, #0
c0d00a68:	d1db      	bne.n	c0d00a22 <io_event+0x42a>
c0d00a6a:	f004 f97d 	bl	c0d04d68 <os_perso_isonboarded>
c0d00a6e:	28aa      	cmp	r0, #170	; 0xaa
c0d00a70:	d103      	bne.n	c0d00a7a <io_event+0x482>
c0d00a72:	f004 f9a9 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d00a76:	28aa      	cmp	r0, #170	; 0xaa
c0d00a78:	d1d3      	bne.n	c0d00a22 <io_event+0x42a>
c0d00a7a:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00a7c:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d00a7e:	0150      	lsls	r0, r2, #5
c0d00a80:	1808      	adds	r0, r1, r0
c0d00a82:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d00a84:	2b00      	cmp	r3, #0
c0d00a86:	d004      	beq.n	c0d00a92 <io_event+0x49a>
c0d00a88:	4798      	blx	r3
c0d00a8a:	2800      	cmp	r0, #0
c0d00a8c:	d007      	beq.n	c0d00a9e <io_event+0x4a6>
c0d00a8e:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d00a90:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00a92:	2801      	cmp	r0, #1
c0d00a94:	d101      	bne.n	c0d00a9a <io_event+0x4a2>
c0d00a96:	0150      	lsls	r0, r2, #5
c0d00a98:	1808      	adds	r0, r1, r0
c0d00a9a:	f005 fcbd 	bl	c0d06418 <io_seproxyhal_display>
c0d00a9e:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d00aa0:	1c40      	adds	r0, r0, #1
c0d00aa2:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d00aa4:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00aa6:	2900      	cmp	r1, #0
c0d00aa8:	d1d7      	bne.n	c0d00a5a <io_event+0x462>
c0d00aaa:	e7ba      	b.n	c0d00a22 <io_event+0x42a>
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00aac:	2c00      	cmp	r4, #0
c0d00aae:	d0b8      	beq.n	c0d00a22 <io_event+0x42a>
c0d00ab0:	2c97      	cmp	r4, #151	; 0x97
c0d00ab2:	d0b6      	beq.n	c0d00a22 <io_event+0x42a>
c0d00ab4:	f000 ffac 	bl	c0d01a10 <io_seproxyhal_init_ux>
c0d00ab8:	f000 ffac 	bl	c0d01a14 <io_seproxyhal_init_button>
c0d00abc:	2000      	movs	r0, #0
c0d00abe:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d00ac0:	2004      	movs	r0, #4
c0d00ac2:	f004 fa1b 	bl	c0d04efc <os_sched_last_status>
c0d00ac6:	64b0      	str	r0, [r6, #72]	; 0x48
c0d00ac8:	2800      	cmp	r0, #0
c0d00aca:	d100      	bne.n	c0d00ace <io_event+0x4d6>
c0d00acc:	e705      	b.n	c0d008da <io_event+0x2e2>
c0d00ace:	2897      	cmp	r0, #151	; 0x97
c0d00ad0:	d100      	bne.n	c0d00ad4 <io_event+0x4dc>
c0d00ad2:	e702      	b.n	c0d008da <io_event+0x2e2>
c0d00ad4:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d00ad6:	2800      	cmp	r0, #0
c0d00ad8:	d100      	bne.n	c0d00adc <io_event+0x4e4>
c0d00ada:	e6fe      	b.n	c0d008da <io_event+0x2e2>
c0d00adc:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d00ade:	212c      	movs	r1, #44	; 0x2c
c0d00ae0:	5c71      	ldrb	r1, [r6, r1]
c0d00ae2:	b280      	uxth	r0, r0
c0d00ae4:	4288      	cmp	r0, r1
c0d00ae6:	d300      	bcc.n	c0d00aea <io_event+0x4f2>
c0d00ae8:	e6f7      	b.n	c0d008da <io_event+0x2e2>
c0d00aea:	f004 f9d3 	bl	c0d04e94 <io_seph_is_status_sent>
c0d00aee:	2800      	cmp	r0, #0
c0d00af0:	d000      	beq.n	c0d00af4 <io_event+0x4fc>
c0d00af2:	e6f2      	b.n	c0d008da <io_event+0x2e2>
c0d00af4:	f004 f938 	bl	c0d04d68 <os_perso_isonboarded>
c0d00af8:	28aa      	cmp	r0, #170	; 0xaa
c0d00afa:	d104      	bne.n	c0d00b06 <io_event+0x50e>
c0d00afc:	f004 f964 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d00b00:	28aa      	cmp	r0, #170	; 0xaa
c0d00b02:	d000      	beq.n	c0d00b06 <io_event+0x50e>
c0d00b04:	e6e9      	b.n	c0d008da <io_event+0x2e2>
c0d00b06:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00b08:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d00b0a:	0150      	lsls	r0, r2, #5
c0d00b0c:	1808      	adds	r0, r1, r0
c0d00b0e:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d00b10:	2b00      	cmp	r3, #0
c0d00b12:	d004      	beq.n	c0d00b1e <io_event+0x526>
c0d00b14:	4798      	blx	r3
c0d00b16:	2800      	cmp	r0, #0
c0d00b18:	d007      	beq.n	c0d00b2a <io_event+0x532>
c0d00b1a:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d00b1c:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00b1e:	2801      	cmp	r0, #1
c0d00b20:	d101      	bne.n	c0d00b26 <io_event+0x52e>
c0d00b22:	0150      	lsls	r0, r2, #5
c0d00b24:	1808      	adds	r0, r1, r0
c0d00b26:	f005 fc77 	bl	c0d06418 <io_seproxyhal_display>
c0d00b2a:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d00b2c:	1c40      	adds	r0, r0, #1
c0d00b2e:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d00b30:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00b32:	2900      	cmp	r1, #0
c0d00b34:	d1d3      	bne.n	c0d00ade <io_event+0x4e6>
c0d00b36:	e6d0      	b.n	c0d008da <io_event+0x2e2>
c0d00b38:	200005f0 	.word	0x200005f0

c0d00b3c <io_exchange_al>:
}

unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00b3c:	b5b0      	push	{r4, r5, r7, lr}
c0d00b3e:	4605      	mov	r5, r0
c0d00b40:	2007      	movs	r0, #7
    switch (channel & ~(IO_FLAGS)) {
c0d00b42:	4028      	ands	r0, r5
c0d00b44:	2400      	movs	r4, #0
c0d00b46:	2801      	cmp	r0, #1
c0d00b48:	d012      	beq.n	c0d00b70 <io_exchange_al+0x34>
c0d00b4a:	2802      	cmp	r0, #2
c0d00b4c:	d112      	bne.n	c0d00b74 <io_exchange_al+0x38>
        case CHANNEL_KEYBOARD:
            break;

            // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
        case CHANNEL_SPI:
            if (tx_len) {
c0d00b4e:	2900      	cmp	r1, #0
c0d00b50:	d007      	beq.n	c0d00b62 <io_exchange_al+0x26>
                io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00b52:	480a      	ldr	r0, [pc, #40]	; (c0d00b7c <io_exchange_al+0x40>)
c0d00b54:	f004 f992 	bl	c0d04e7c <io_seph_send>

                if (channel & IO_RESET_AFTER_REPLIED) {
c0d00b58:	0628      	lsls	r0, r5, #24
c0d00b5a:	d509      	bpl.n	c0d00b70 <io_exchange_al+0x34>
                    reset();
c0d00b5c:	f004 f8e0 	bl	c0d04d20 <halt>
c0d00b60:	e006      	b.n	c0d00b70 <io_exchange_al+0x34>
c0d00b62:	2041      	movs	r0, #65	; 0x41
c0d00b64:	0081      	lsls	r1, r0, #2
                }
                return 0; // nothing received from the master so far (it's a tx
                // transaction)
            } else {
                return io_seproxyhal_spi_recv(G_io_apdu_buffer, sizeof(G_io_apdu_buffer), 0);
c0d00b66:	4805      	ldr	r0, [pc, #20]	; (c0d00b7c <io_exchange_al+0x40>)
c0d00b68:	2200      	movs	r2, #0
c0d00b6a:	f004 f99f 	bl	c0d04eac <io_seph_recv>
c0d00b6e:	4604      	mov	r4, r0

        default:
            THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00b70:	4620      	mov	r0, r4
c0d00b72:	bdb0      	pop	{r4, r5, r7, pc}
c0d00b74:	2002      	movs	r0, #2
            THROW(INVALID_PARAMETER);
c0d00b76:	f000 fd56 	bl	c0d01626 <os_longjmp>
c0d00b7a:	46c0      	nop			; (mov r8, r8)
c0d00b7c:	200002b0 	.word	0x200002b0

c0d00b80 <handle_generic_apdu>:

void handle_generic_apdu(volatile uint32_t *flags, volatile uint32_t *tx, uint32_t rx) {
c0d00b80:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00b82:	b081      	sub	sp, #4
    UNUSED(flags);

    if (rx > 4 && MEMCMP(G_io_apdu_buffer, "\xE0\x01\x00\x00", 4) == 0) {
c0d00b84:	2a05      	cmp	r2, #5
c0d00b86:	d30f      	bcc.n	c0d00ba8 <handle_generic_apdu+0x28>
c0d00b88:	460c      	mov	r4, r1
c0d00b8a:	4f18      	ldr	r7, [pc, #96]	; (c0d00bec <handle_generic_apdu+0x6c>)
c0d00b8c:	7838      	ldrb	r0, [r7, #0]
c0d00b8e:	7879      	ldrb	r1, [r7, #1]
c0d00b90:	0209      	lsls	r1, r1, #8
c0d00b92:	1808      	adds	r0, r1, r0
c0d00b94:	78b9      	ldrb	r1, [r7, #2]
c0d00b96:	78fa      	ldrb	r2, [r7, #3]
c0d00b98:	0212      	lsls	r2, r2, #8
c0d00b9a:	1851      	adds	r1, r2, r1
c0d00b9c:	0409      	lsls	r1, r1, #16
c0d00b9e:	1808      	adds	r0, r1, r0
c0d00ba0:	210f      	movs	r1, #15
c0d00ba2:	0149      	lsls	r1, r1, #5
c0d00ba4:	4288      	cmp	r0, r1
c0d00ba6:	d001      	beq.n	c0d00bac <handle_generic_apdu+0x2c>
        p = p + 1 + *p;

        *tx = p - G_io_apdu_buffer;
        THROW(APDU_CODE_OK);
    }
}
c0d00ba8:	b001      	add	sp, #4
c0d00baa:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00bac:	2004      	movs	r0, #4
        p[3] = (TARGET_ID >> 0) & 0xFF;
c0d00bae:	70f8      	strb	r0, [r7, #3]
c0d00bb0:	2600      	movs	r6, #0
        p[2] = (TARGET_ID >> 8) & 0xFF;
c0d00bb2:	70be      	strb	r6, [r7, #2]
c0d00bb4:	2010      	movs	r0, #16
        p[1] = (TARGET_ID >> 16) & 0xFF;
c0d00bb6:	7078      	strb	r0, [r7, #1]
c0d00bb8:	2031      	movs	r0, #49	; 0x31
        p[0] = (TARGET_ID >> 24) & 0xFF;
c0d00bba:	7038      	strb	r0, [r7, #0]
        *p = os_version(p + 1, 64);
c0d00bbc:	1d7d      	adds	r5, r7, #5
c0d00bbe:	2140      	movs	r1, #64	; 0x40
c0d00bc0:	9100      	str	r1, [sp, #0]
c0d00bc2:	4628      	mov	r0, r5
c0d00bc4:	f004 f928 	bl	c0d04e18 <os_version>
        p = p + 1 + *p;
c0d00bc8:	b2c1      	uxtb	r1, r0
        *p = 0;
c0d00bca:	546e      	strb	r6, [r5, r1]
        *p = os_version(p + 1, 64);
c0d00bcc:	7138      	strb	r0, [r7, #4]
        p = p + 1 + *p;
c0d00bce:	186e      	adds	r6, r5, r1
        *p = os_seph_version(p + 1, 64);
c0d00bd0:	1cb5      	adds	r5, r6, #2
c0d00bd2:	4628      	mov	r0, r5
c0d00bd4:	9900      	ldr	r1, [sp, #0]
c0d00bd6:	f004 f92b 	bl	c0d04e30 <os_seph_version>
c0d00bda:	7070      	strb	r0, [r6, #1]
        p = p + 1 + *p;
c0d00bdc:	b2c0      	uxtb	r0, r0
c0d00bde:	1828      	adds	r0, r5, r0
        *tx = p - G_io_apdu_buffer;
c0d00be0:	1bc0      	subs	r0, r0, r7
c0d00be2:	6020      	str	r0, [r4, #0]
c0d00be4:	2009      	movs	r0, #9
c0d00be6:	0300      	lsls	r0, r0, #12
        THROW(APDU_CODE_OK);
c0d00be8:	f000 fd1d 	bl	c0d01626 <os_longjmp>
c0d00bec:	200002b0 	.word	0x200002b0

c0d00bf0 <app_init>:

void app_init() {
c0d00bf0:	b510      	push	{r4, lr}
    io_seproxyhal_init();
c0d00bf2:	f000 feed 	bl	c0d019d0 <io_seproxyhal_init>
c0d00bf6:	2400      	movs	r4, #0
#ifdef HAVE_BLE
    // grab the current plane mode setting
    G_io_app.plane_mode = os_setting_get(OS_SETTING_PLANEMODE, NULL, 0);
#endif // HAVE_BLE

    USB_power(0);
c0d00bf8:	4620      	mov	r0, r4
c0d00bfa:	f005 f8d9 	bl	c0d05db0 <USB_power>
c0d00bfe:	2001      	movs	r0, #1
    USB_power(1);
c0d00c00:	f005 f8d6 	bl	c0d05db0 <USB_power>
    app_mode_reset();
c0d00c04:	f000 f880 	bl	c0d00d08 <app_mode_reset>
    zeroize_sr25519_signdata();
    view_idle_show(0, NULL);
c0d00c08:	4620      	mov	r0, r4
c0d00c0a:	4621      	mov	r1, r4
c0d00c0c:	f005 fc00 	bl	c0d06410 <view_idle_show>
    // Enable Bluetooth
    BLE_power(0, NULL);
    BLE_power(1, "Nano X");
#endif // HAVE_BLE

}
c0d00c10:	bd10      	pop	{r4, pc}
	...

c0d00c14 <app_main>:

void app_main() {
c0d00c14:	b090      	sub	sp, #64	; 0x40
c0d00c16:	2600      	movs	r6, #0
    volatile uint32_t rx = 0, tx = 0, flags = 0;
c0d00c18:	960f      	str	r6, [sp, #60]	; 0x3c
c0d00c1a:	960e      	str	r6, [sp, #56]	; 0x38
c0d00c1c:	960d      	str	r6, [sp, #52]	; 0x34
c0d00c1e:	4f39      	ldr	r7, [pc, #228]	; (c0d00d04 <app_main+0xf0>)
c0d00c20:	a80c      	add	r0, sp, #48	; 0x30

    for (;;) {
        volatile uint16_t sw = 0;
c0d00c22:	8006      	strh	r6, [r0, #0]
c0d00c24:	466d      	mov	r5, sp

        BEGIN_TRY;
        {
            TRY;
c0d00c26:	4628      	mov	r0, r5
c0d00c28:	f006 fca8 	bl	c0d0757c <setjmp>
c0d00c2c:	4604      	mov	r4, r0
c0d00c2e:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d00c30:	b280      	uxth	r0, r0
c0d00c32:	2805      	cmp	r0, #5
c0d00c34:	d024      	beq.n	c0d00c80 <app_main+0x6c>
c0d00c36:	2800      	cmp	r0, #0
c0d00c38:	d12a      	bne.n	c0d00c90 <app_main+0x7c>
c0d00c3a:	4668      	mov	r0, sp
c0d00c3c:	f004 f950 	bl	c0d04ee0 <try_context_set>
            {
                rx = tx;
c0d00c40:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d00c42:	910f      	str	r1, [sp, #60]	; 0x3c
                tx = 0;
c0d00c44:	960e      	str	r6, [sp, #56]	; 0x38
            TRY;
c0d00c46:	900a      	str	r0, [sp, #40]	; 0x28

                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00c48:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d00c4a:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d00c4c:	b2c0      	uxtb	r0, r0
c0d00c4e:	b289      	uxth	r1, r1
c0d00c50:	f001 f80a 	bl	c0d01c68 <io_exchange>
c0d00c54:	900f      	str	r0, [sp, #60]	; 0x3c
                flags = 0;
c0d00c56:	960d      	str	r6, [sp, #52]	; 0x34
                CHECK_APP_CANARY()
c0d00c58:	f006 f9b4 	bl	c0d06fc4 <check_app_canary>

                if (rx == 0)
c0d00c5c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d00c5e:	2800      	cmp	r0, #0
c0d00c60:	d049      	beq.n	c0d00cf6 <app_main+0xe2>
                    THROW(APDU_CODE_EMPTY_BUFFER);

                handle_generic_apdu(&flags, &tx, rx);
c0d00c62:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
c0d00c64:	ac0e      	add	r4, sp, #56	; 0x38
c0d00c66:	4621      	mov	r1, r4
c0d00c68:	f7ff ff8a 	bl	c0d00b80 <handle_generic_apdu>
                CHECK_APP_CANARY()
c0d00c6c:	f006 f9aa 	bl	c0d06fc4 <check_app_canary>

                handleApdu(&flags, &tx, rx);
c0d00c70:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
c0d00c72:	a80d      	add	r0, sp, #52	; 0x34
c0d00c74:	4621      	mov	r1, r4
c0d00c76:	f7ff fb4b 	bl	c0d00310 <handleApdu>
                CHECK_APP_CANARY()
c0d00c7a:	f006 f9a3 	bl	c0d06fc4 <check_app_canary>
c0d00c7e:	e02c      	b.n	c0d00cda <app_main+0xc6>
c0d00c80:	4668      	mov	r0, sp
            }
            CATCH(EXCEPTION_IO_RESET)
c0d00c82:	8586      	strh	r6, [r0, #44]	; 0x2c
c0d00c84:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00c86:	f004 f92b 	bl	c0d04ee0 <try_context_set>
            {
                // reset IO and UX before continuing
                app_init();
c0d00c8a:	f7ff ffb1 	bl	c0d00bf0 <app_init>
c0d00c8e:	e7c7      	b.n	c0d00c20 <app_main+0xc>
c0d00c90:	4668      	mov	r0, sp
                continue;
            }
            CATCH_OTHER(e);
c0d00c92:	8586      	strh	r6, [r0, #44]	; 0x2c
c0d00c94:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00c96:	f004 f923 	bl	c0d04ee0 <try_context_set>
c0d00c9a:	200f      	movs	r0, #15
c0d00c9c:	0300      	lsls	r0, r0, #12
            {
                switch (e & 0xF000) {
c0d00c9e:	4020      	ands	r0, r4
c0d00ca0:	2109      	movs	r1, #9
c0d00ca2:	0309      	lsls	r1, r1, #12
c0d00ca4:	4288      	cmp	r0, r1
c0d00ca6:	d003      	beq.n	c0d00cb0 <app_main+0x9c>
c0d00ca8:	2103      	movs	r1, #3
c0d00caa:	0349      	lsls	r1, r1, #13
c0d00cac:	4288      	cmp	r0, r1
c0d00cae:	d102      	bne.n	c0d00cb6 <app_main+0xa2>
c0d00cb0:	a80c      	add	r0, sp, #48	; 0x30
                    case 0x6000:
                    case 0x9000:
                        sw = e;
c0d00cb2:	8004      	strh	r4, [r0, #0]
c0d00cb4:	e006      	b.n	c0d00cc4 <app_main+0xb0>
                        break;
                    default:
                        sw = 0x6800 | (e & 0x7FF);
c0d00cb6:	4812      	ldr	r0, [pc, #72]	; (c0d00d00 <app_main+0xec>)
c0d00cb8:	4004      	ands	r4, r0
c0d00cba:	200d      	movs	r0, #13
c0d00cbc:	02c0      	lsls	r0, r0, #11
c0d00cbe:	1820      	adds	r0, r4, r0
c0d00cc0:	a90c      	add	r1, sp, #48	; 0x30
c0d00cc2:	8008      	strh	r0, [r1, #0]
                        break;
                }
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00cc4:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00cc6:	0a00      	lsrs	r0, r0, #8
c0d00cc8:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d00cca:	5478      	strb	r0, [r7, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00ccc:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00cce:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d00cd0:	19c9      	adds	r1, r1, r7
c0d00cd2:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00cd4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00cd6:	1c80      	adds	r0, r0, #2
c0d00cd8:	900e      	str	r0, [sp, #56]	; 0x38
            }
            FINALLY;
c0d00cda:	f004 f8f5 	bl	c0d04ec8 <try_context_get>
c0d00cde:	4669      	mov	r1, sp
c0d00ce0:	4288      	cmp	r0, r1
c0d00ce2:	d102      	bne.n	c0d00cea <app_main+0xd6>
c0d00ce4:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00ce6:	f004 f8fb 	bl	c0d04ee0 <try_context_set>
c0d00cea:	4668      	mov	r0, sp
            {}
        }
        END_TRY;
c0d00cec:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d00cee:	2800      	cmp	r0, #0
c0d00cf0:	d096      	beq.n	c0d00c20 <app_main+0xc>
c0d00cf2:	f000 fc98 	bl	c0d01626 <os_longjmp>
c0d00cf6:	4801      	ldr	r0, [pc, #4]	; (c0d00cfc <app_main+0xe8>)
                    THROW(APDU_CODE_EMPTY_BUFFER);
c0d00cf8:	f000 fc95 	bl	c0d01626 <os_longjmp>
c0d00cfc:	00006982 	.word	0x00006982
c0d00d00:	000007ff 	.word	0x000007ff
c0d00d04:	200002b0 	.word	0x200002b0

c0d00d08 <app_mode_reset>:
//////////////////////////////////////////////////////////////
app_mode_persistent_t NV_CONST N_appmode_impl __attribute__ ((aligned(64)));
#define N_appmode (*(NV_VOLATILE app_mode_persistent_t *)PIC(&N_appmode_impl))

void app_mode_reset(){
    app_mode_temporary.secret = 0;
c0d00d08:	4801      	ldr	r0, [pc, #4]	; (c0d00d10 <app_mode_reset+0x8>)
c0d00d0a:	2100      	movs	r1, #0
c0d00d0c:	7001      	strb	r1, [r0, #0]
}
c0d00d0e:	4770      	bx	lr
c0d00d10:	20000282 	.word	0x20000282

c0d00d14 <app_mode_expert>:

bool app_mode_expert() {
c0d00d14:	b580      	push	{r7, lr}
    return N_appmode.expert;
c0d00d16:	4803      	ldr	r0, [pc, #12]	; (c0d00d24 <app_mode_expert+0x10>)
c0d00d18:	f002 fb32 	bl	c0d03380 <pic>
c0d00d1c:	7800      	ldrb	r0, [r0, #0]
c0d00d1e:	1e41      	subs	r1, r0, #1
c0d00d20:	4188      	sbcs	r0, r1
c0d00d22:	bd80      	pop	{r7, pc}
c0d00d24:	c0d08640 	.word	0xc0d08640

c0d00d28 <app_mode_set_expert>:
}

void app_mode_set_expert(uint8_t val) {
c0d00d28:	b510      	push	{r4, lr}
c0d00d2a:	b082      	sub	sp, #8
c0d00d2c:	ac01      	add	r4, sp, #4
    app_mode_persistent_t mode;
    mode.expert = val;
c0d00d2e:	7020      	strb	r0, [r4, #0]
    MEMCPY_NV( (void*) PIC(&N_appmode_impl), (void*) &mode, sizeof(app_mode_persistent_t));
c0d00d30:	4804      	ldr	r0, [pc, #16]	; (c0d00d44 <app_mode_set_expert+0x1c>)
c0d00d32:	f002 fb25 	bl	c0d03380 <pic>
c0d00d36:	2201      	movs	r2, #1
c0d00d38:	4621      	mov	r1, r4
c0d00d3a:	f003 fffd 	bl	c0d04d38 <nvm_write>
}
c0d00d3e:	b002      	add	sp, #8
c0d00d40:	bd10      	pop	{r4, pc}
c0d00d42:	46c0      	nop			; (mov r8, r8)
c0d00d44:	c0d08640 	.word	0xc0d08640

c0d00d48 <app_mode_secret>:
//////////////////////////////////////////////////////////////

#endif

bool app_mode_secret() {
    return app_mode_temporary.secret;
c0d00d48:	4802      	ldr	r0, [pc, #8]	; (c0d00d54 <app_mode_secret+0xc>)
c0d00d4a:	7800      	ldrb	r0, [r0, #0]
c0d00d4c:	1e41      	subs	r1, r0, #1
c0d00d4e:	4188      	sbcs	r0, r1
c0d00d50:	4770      	bx	lr
c0d00d52:	46c0      	nop			; (mov r8, r8)
c0d00d54:	20000282 	.word	0x20000282

c0d00d58 <app_mode_set_secret>:
}

void app_mode_set_secret(uint8_t val) {
    app_mode_temporary.secret = val;
c0d00d58:	4901      	ldr	r1, [pc, #4]	; (c0d00d60 <app_mode_set_secret+0x8>)
c0d00d5a:	7008      	strb	r0, [r1, #0]
}
c0d00d5c:	4770      	bx	lr
c0d00d5e:	46c0      	nop			; (mov r8, r8)
c0d00d60:	20000282 	.word	0x20000282

c0d00d64 <encode_base58>:
    *outlen = length;
    return 0;
}

int encode_base58(const unsigned char *in, size_t length,
                  unsigned char *out, size_t *outlen) {
c0d00d64:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00d66:	b0b3      	sub	sp, #204	; 0xcc
c0d00d68:	461d      	mov	r5, r3
c0d00d6a:	4616      	mov	r6, r2
c0d00d6c:	460f      	mov	r7, r1
c0d00d6e:	4604      	mov	r4, r0
c0d00d70:	a809      	add	r0, sp, #36	; 0x24
c0d00d72:	21a6      	movs	r1, #166	; 0xa6
    unsigned char buffer[MAX_ENC_INPUT_SIZE * 138 / 100 + 1] = {0};
c0d00d74:	f006 fac8 	bl	c0d07308 <__aeabi_memclr>
c0d00d78:	2100      	movs	r1, #0
c0d00d7a:	43c8      	mvns	r0, r1
    size_t i, j;
    size_t startAt, stopAt;
    size_t zeroCount = 0;
    size_t outputSize;

    if (length > MAX_ENC_INPUT_SIZE) {
c0d00d7c:	9003      	str	r0, [sp, #12]
c0d00d7e:	2f78      	cmp	r7, #120	; 0x78
c0d00d80:	d870      	bhi.n	c0d00e64 <encode_base58+0x100>
        return -1;
    }

    while ((zeroCount < length) && (in[zeroCount] == 0)) {
c0d00d82:	2f00      	cmp	r7, #0
c0d00d84:	d008      	beq.n	c0d00d98 <encode_base58+0x34>
c0d00d86:	2100      	movs	r1, #0
c0d00d88:	5c60      	ldrb	r0, [r4, r1]
c0d00d8a:	2800      	cmp	r0, #0
c0d00d8c:	d104      	bne.n	c0d00d98 <encode_base58+0x34>
        ++zeroCount;
c0d00d8e:	1c49      	adds	r1, r1, #1
    while ((zeroCount < length) && (in[zeroCount] == 0)) {
c0d00d90:	428f      	cmp	r7, r1
c0d00d92:	d1f9      	bne.n	c0d00d88 <encode_base58+0x24>
c0d00d94:	2200      	movs	r2, #0
c0d00d96:	e039      	b.n	c0d00e0c <encode_base58+0xa8>
c0d00d98:	9102      	str	r1, [sp, #8]
    }

    outputSize = (length - zeroCount) * 138 / 100 + 1;
c0d00d9a:	9802      	ldr	r0, [sp, #8]
c0d00d9c:	1a39      	subs	r1, r7, r0
c0d00d9e:	208a      	movs	r0, #138	; 0x8a
c0d00da0:	4348      	muls	r0, r1
c0d00da2:	2164      	movs	r1, #100	; 0x64
c0d00da4:	f006 f91e 	bl	c0d06fe4 <__udivsi3>
c0d00da8:	9902      	ldr	r1, [sp, #8]
c0d00daa:	4602      	mov	r2, r0
    stopAt = outputSize - 1;
    for (startAt = zeroCount; startAt < length; startAt++) {
c0d00dac:	428f      	cmp	r7, r1
c0d00dae:	d92c      	bls.n	c0d00e0a <encode_base58+0xa6>
c0d00db0:	9600      	str	r6, [sp, #0]
c0d00db2:	9501      	str	r5, [sp, #4]
c0d00db4:	4616      	mov	r6, r2
c0d00db6:	9706      	str	r7, [sp, #24]
c0d00db8:	9205      	str	r2, [sp, #20]
c0d00dba:	9404      	str	r4, [sp, #16]
c0d00dbc:	9107      	str	r1, [sp, #28]
        int carry = in[startAt];
c0d00dbe:	5c60      	ldrb	r0, [r4, r1]
c0d00dc0:	1e71      	subs	r1, r6, #1
c0d00dc2:	9108      	str	r1, [sp, #32]
c0d00dc4:	4616      	mov	r6, r2
c0d00dc6:	af09      	add	r7, sp, #36	; 0x24
        for (j = outputSize - 1; (int) j >= 0; j--) {
            carry += 256 * buffer[j];
c0d00dc8:	5db9      	ldrb	r1, [r7, r6]
c0d00dca:	0209      	lsls	r1, r1, #8
c0d00dcc:	180d      	adds	r5, r1, r0
c0d00dce:	243a      	movs	r4, #58	; 0x3a
            buffer[j] = carry % 58;
            carry /= 58;
c0d00dd0:	4628      	mov	r0, r5
c0d00dd2:	4621      	mov	r1, r4
c0d00dd4:	f006 f94c 	bl	c0d07070 <__divsi3>
c0d00dd8:	4344      	muls	r4, r0
c0d00dda:	1b29      	subs	r1, r5, r4
            buffer[j] = carry % 58;
c0d00ddc:	55b9      	strb	r1, [r7, r6]

            if (j <= stopAt - 1 && carry == 0) {
c0d00dde:	9908      	ldr	r1, [sp, #32]
c0d00de0:	428e      	cmp	r6, r1
c0d00de2:	d802      	bhi.n	c0d00dea <encode_base58+0x86>
c0d00de4:	3539      	adds	r5, #57	; 0x39
c0d00de6:	2d73      	cmp	r5, #115	; 0x73
c0d00de8:	d304      	bcc.n	c0d00df4 <encode_base58+0x90>
        for (j = outputSize - 1; (int) j >= 0; j--) {
c0d00dea:	1e71      	subs	r1, r6, #1
c0d00dec:	2e00      	cmp	r6, #0
c0d00dee:	460e      	mov	r6, r1
c0d00df0:	dce9      	bgt.n	c0d00dc6 <encode_base58+0x62>
c0d00df2:	9e03      	ldr	r6, [sp, #12]
c0d00df4:	9907      	ldr	r1, [sp, #28]
    for (startAt = zeroCount; startAt < length; startAt++) {
c0d00df6:	1c49      	adds	r1, r1, #1
c0d00df8:	9f06      	ldr	r7, [sp, #24]
c0d00dfa:	42b9      	cmp	r1, r7
c0d00dfc:	9a05      	ldr	r2, [sp, #20]
c0d00dfe:	9c04      	ldr	r4, [sp, #16]
c0d00e00:	d1dc      	bne.n	c0d00dbc <encode_base58+0x58>
c0d00e02:	9f02      	ldr	r7, [sp, #8]
c0d00e04:	9d01      	ldr	r5, [sp, #4]
c0d00e06:	9e00      	ldr	r6, [sp, #0]
c0d00e08:	e000      	b.n	c0d00e0c <encode_base58+0xa8>
c0d00e0a:	460f      	mov	r7, r1
        }
        stopAt = j;
    }

    j = 0;
    while (j < outputSize && buffer[j] == 0) {
c0d00e0c:	1c50      	adds	r0, r2, #1
c0d00e0e:	2400      	movs	r4, #0
c0d00e10:	a909      	add	r1, sp, #36	; 0x24
c0d00e12:	5d09      	ldrb	r1, [r1, r4]
c0d00e14:	2900      	cmp	r1, #0
c0d00e16:	d103      	bne.n	c0d00e20 <encode_base58+0xbc>
        j += 1;
c0d00e18:	1c64      	adds	r4, r4, #1
    while (j < outputSize && buffer[j] == 0) {
c0d00e1a:	42a0      	cmp	r0, r4
c0d00e1c:	d1f8      	bne.n	c0d00e10 <encode_base58+0xac>
c0d00e1e:	4604      	mov	r4, r0
    outputSize = (length - zeroCount) * 138 / 100 + 1;
c0d00e20:	18b8      	adds	r0, r7, r2
    }

    if (*outlen < zeroCount + outputSize - j) {
c0d00e22:	1b00      	subs	r0, r0, r4
c0d00e24:	1c40      	adds	r0, r0, #1
c0d00e26:	6829      	ldr	r1, [r5, #0]
c0d00e28:	4281      	cmp	r1, r0
c0d00e2a:	d31a      	bcc.n	c0d00e62 <encode_base58+0xfe>
c0d00e2c:	9501      	str	r5, [sp, #4]
c0d00e2e:	4615      	mov	r5, r2
c0d00e30:	2231      	movs	r2, #49	; 0x31
        *outlen = zeroCount + outputSize - j;
        return -1;
    }

    MEMSET(out, BASE58ALPHABET[0], zeroCount);
c0d00e32:	4630      	mov	r0, r6
c0d00e34:	4639      	mov	r1, r7
c0d00e36:	f006 fa75 	bl	c0d07324 <__aeabi_memset>
c0d00e3a:	2000      	movs	r0, #0

    i = zeroCount;
    while (j < outputSize) {
c0d00e3c:	9003      	str	r0, [sp, #12]
c0d00e3e:	42ac      	cmp	r4, r5
c0d00e40:	d80d      	bhi.n	c0d00e5e <encode_base58+0xfa>
c0d00e42:	a809      	add	r0, sp, #36	; 0x24
c0d00e44:	1900      	adds	r0, r0, r4
c0d00e46:	1b29      	subs	r1, r5, r4
c0d00e48:	1c49      	adds	r1, r1, #1
c0d00e4a:	4a08      	ldr	r2, [pc, #32]	; (c0d00e6c <encode_base58+0x108>)
c0d00e4c:	447a      	add	r2, pc
        out[i++] = BASE58ALPHABET[buffer[j++]];
c0d00e4e:	7803      	ldrb	r3, [r0, #0]
c0d00e50:	5cd3      	ldrb	r3, [r2, r3]
c0d00e52:	55f3      	strb	r3, [r6, r7]
    while (j < outputSize) {
c0d00e54:	1c40      	adds	r0, r0, #1
c0d00e56:	1e49      	subs	r1, r1, #1
        out[i++] = BASE58ALPHABET[buffer[j++]];
c0d00e58:	1c7f      	adds	r7, r7, #1
    while (j < outputSize) {
c0d00e5a:	2900      	cmp	r1, #0
c0d00e5c:	d1f7      	bne.n	c0d00e4e <encode_base58+0xea>
c0d00e5e:	4638      	mov	r0, r7
c0d00e60:	9d01      	ldr	r5, [sp, #4]
c0d00e62:	6028      	str	r0, [r5, #0]
    }
    *outlen = i;
    return 0;
}
c0d00e64:	9803      	ldr	r0, [sp, #12]
c0d00e66:	b033      	add	sp, #204	; 0xcc
c0d00e68:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00e6a:	46c0      	nop			; (mov r8, r8)
c0d00e6c:	000068d0 	.word	0x000068d0

c0d00e70 <bignumLittleEndian_bcdprint>:
#include "zxtypes.h"
#include "bignum.h"


bool_t bignumLittleEndian_bcdprint(char *outBuffer, uint16_t outBufferLen,
                                   const uint8_t *inBCD, uint16_t inBCDLen) {
c0d00e70:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e72:	b081      	sub	sp, #4
c0d00e74:	461e      	mov	r6, r3
c0d00e76:	4617      	mov	r7, r2
c0d00e78:	460c      	mov	r4, r1
c0d00e7a:	4605      	mov	r5, r0
    static const char hexchars[] = "0123456789ABCDEF";
    uint8_t started = 0;
    MEMZERO(outBuffer, outBufferLen);
c0d00e7c:	f006 fa5a 	bl	c0d07334 <explicit_bzero>
c0d00e80:	4621      	mov	r1, r4
c0d00e82:	2400      	movs	r4, #0

    if (outBufferLen < 4) {
c0d00e84:	2904      	cmp	r1, #4
c0d00e86:	d334      	bcc.n	c0d00ef2 <bignumLittleEndian_bcdprint+0x82>
        return bool_false;
    }

    if (inBCDLen * 2 > outBufferLen) {
c0d00e88:	0070      	lsls	r0, r6, #1
c0d00e8a:	4281      	cmp	r1, r0
c0d00e8c:	d205      	bcs.n	c0d00e9a <bignumLittleEndian_bcdprint+0x2a>
        snprintf(outBuffer, outBufferLen, "ERR");
c0d00e8e:	4a1b      	ldr	r2, [pc, #108]	; (c0d00efc <bignumLittleEndian_bcdprint+0x8c>)
c0d00e90:	447a      	add	r2, pc
c0d00e92:	4628      	mov	r0, r5
c0d00e94:	f001 f96c 	bl	c0d02170 <snprintf>
c0d00e98:	e02b      	b.n	c0d00ef2 <bignumLittleEndian_bcdprint+0x82>
c0d00e9a:	460a      	mov	r2, r1
        return bool_false;
    }

    for (uint8_t i = 0; i < inBCDLen; i++, inBCD++) {
c0d00e9c:	2e00      	cmp	r6, #0
c0d00e9e:	d022      	beq.n	c0d00ee6 <bignumLittleEndian_bcdprint+0x76>
c0d00ea0:	2000      	movs	r0, #0
c0d00ea2:	4601      	mov	r1, r0
c0d00ea4:	783c      	ldrb	r4, [r7, #0]
        if (started || *inBCD != 0) {
c0d00ea6:	2900      	cmp	r1, #0
c0d00ea8:	4913      	ldr	r1, [pc, #76]	; (c0d00ef8 <bignumLittleEndian_bcdprint+0x88>)
c0d00eaa:	4479      	add	r1, pc
c0d00eac:	d011      	beq.n	c0d00ed2 <bignumLittleEndian_bcdprint+0x62>
            if (started || (*inBCD >> 4u) != 0) {
                *outBuffer = hexchars[*inBCD >> 4u];
c0d00eae:	0923      	lsrs	r3, r4, #4
c0d00eb0:	5ccb      	ldrb	r3, [r1, r3]
c0d00eb2:	702b      	strb	r3, [r5, #0]
                outBuffer++;
c0d00eb4:	1c6d      	adds	r5, r5, #1
            }
            *outBuffer = hexchars[*inBCD & 0x0Fu];
c0d00eb6:	783c      	ldrb	r4, [r7, #0]
c0d00eb8:	230f      	movs	r3, #15
c0d00eba:	4023      	ands	r3, r4
c0d00ebc:	5cc9      	ldrb	r1, [r1, r3]
c0d00ebe:	7029      	strb	r1, [r5, #0]
            outBuffer++;
c0d00ec0:	1c6d      	adds	r5, r5, #1
c0d00ec2:	2101      	movs	r1, #1
c0d00ec4:	2400      	movs	r4, #0
    for (uint8_t i = 0; i < inBCDLen; i++, inBCD++) {
c0d00ec6:	1c7f      	adds	r7, r7, #1
c0d00ec8:	1c40      	adds	r0, r0, #1
c0d00eca:	b2c3      	uxtb	r3, r0
c0d00ecc:	42b3      	cmp	r3, r6
c0d00ece:	d3e9      	bcc.n	c0d00ea4 <bignumLittleEndian_bcdprint+0x34>
c0d00ed0:	e007      	b.n	c0d00ee2 <bignumLittleEndian_bcdprint+0x72>
        if (started || *inBCD != 0) {
c0d00ed2:	2c00      	cmp	r4, #0
c0d00ed4:	d002      	beq.n	c0d00edc <bignumLittleEndian_bcdprint+0x6c>
            if (started || (*inBCD >> 4u) != 0) {
c0d00ed6:	2c10      	cmp	r4, #16
c0d00ed8:	d2e9      	bcs.n	c0d00eae <bignumLittleEndian_bcdprint+0x3e>
c0d00eda:	e7ed      	b.n	c0d00eb8 <bignumLittleEndian_bcdprint+0x48>
c0d00edc:	2100      	movs	r1, #0
c0d00ede:	2401      	movs	r4, #1
c0d00ee0:	e7f1      	b.n	c0d00ec6 <bignumLittleEndian_bcdprint+0x56>
            started = 1;
        }
    }

    if (!started) {
c0d00ee2:	2c00      	cmp	r4, #0
c0d00ee4:	d004      	beq.n	c0d00ef0 <bignumLittleEndian_bcdprint+0x80>
        strlcpy(outBuffer, "0", outBufferLen);
c0d00ee6:	4906      	ldr	r1, [pc, #24]	; (c0d00f00 <bignumLittleEndian_bcdprint+0x90>)
c0d00ee8:	4479      	add	r1, pc
c0d00eea:	4628      	mov	r0, r5
c0d00eec:	f006 fb8a 	bl	c0d07604 <strlcpy>
c0d00ef0:	2401      	movs	r4, #1
    }

    return bool_true;
}
c0d00ef2:	4620      	mov	r0, r4
c0d00ef4:	b001      	add	sp, #4
c0d00ef6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ef8:	000068b0 	.word	0x000068b0
c0d00efc:	000068c6 	.word	0x000068c6
c0d00f00:	0000748d 	.word	0x0000748d

c0d00f04 <bignumLittleEndian_to_bcd>:

void bignumLittleEndian_to_bcd(uint8_t *bcdOut, uint16_t bcdOutLen,
                               const uint8_t *binValue, uint16_t binValueLen) {
c0d00f04:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f06:	b085      	sub	sp, #20
c0d00f08:	461c      	mov	r4, r3
c0d00f0a:	9200      	str	r2, [sp, #0]
c0d00f0c:	9003      	str	r0, [sp, #12]
c0d00f0e:	9104      	str	r1, [sp, #16]
    MEMZERO(bcdOut, bcdOutLen);
c0d00f10:	f006 fa10 	bl	c0d07334 <explicit_bzero>
c0d00f14:	9401      	str	r4, [sp, #4]

    uint8_t carry;
    for (uint16_t bitIdx = 0; bitIdx < binValueLen * 8; bitIdx++) {
c0d00f16:	2c00      	cmp	r4, #0
c0d00f18:	d03e      	beq.n	c0d00f98 <bignumLittleEndian_to_bcd+0x94>
c0d00f1a:	9801      	ldr	r0, [sp, #4]
c0d00f1c:	00c0      	lsls	r0, r0, #3
c0d00f1e:	9002      	str	r0, [sp, #8]
c0d00f20:	9803      	ldr	r0, [sp, #12]
c0d00f22:	1e41      	subs	r1, r0, #1
c0d00f24:	2200      	movs	r2, #0
c0d00f26:	9b04      	ldr	r3, [sp, #16]
        // Fix bcd
        for (uint16_t j = 0; j < bcdOutLen; j++) {
c0d00f28:	2b00      	cmp	r3, #0
c0d00f2a:	9f03      	ldr	r7, [sp, #12]
c0d00f2c:	d02f      	beq.n	c0d00f8e <bignumLittleEndian_to_bcd+0x8a>
            if ((bcdOut[j] & 0x0Fu) > 0x04u) {
c0d00f2e:	783e      	ldrb	r6, [r7, #0]
c0d00f30:	200f      	movs	r0, #15
c0d00f32:	4634      	mov	r4, r6
c0d00f34:	4004      	ands	r4, r0
c0d00f36:	2c04      	cmp	r4, #4
c0d00f38:	d900      	bls.n	c0d00f3c <bignumLittleEndian_to_bcd+0x38>
c0d00f3a:	1cf6      	adds	r6, r6, #3
                bcdOut[j] += 0x03u;
            }
            if ((bcdOut[j] & 0xF0u) > 0x40u) {
c0d00f3c:	4635      	mov	r5, r6
c0d00f3e:	4385      	bics	r5, r0
        for (uint16_t j = 0; j < bcdOutLen; j++) {
c0d00f40:	2c04      	cmp	r4, #4
c0d00f42:	d802      	bhi.n	c0d00f4a <bignumLittleEndian_to_bcd+0x46>
c0d00f44:	b2e8      	uxtb	r0, r5
c0d00f46:	2841      	cmp	r0, #65	; 0x41
c0d00f48:	d304      	bcc.n	c0d00f54 <bignumLittleEndian_to_bcd+0x50>
            if ((bcdOut[j] & 0xF0u) > 0x40u) {
c0d00f4a:	b2e8      	uxtb	r0, r5
c0d00f4c:	2840      	cmp	r0, #64	; 0x40
c0d00f4e:	d900      	bls.n	c0d00f52 <bignumLittleEndian_to_bcd+0x4e>
c0d00f50:	3630      	adds	r6, #48	; 0x30
        for (uint16_t j = 0; j < bcdOutLen; j++) {
c0d00f52:	703e      	strb	r6, [r7, #0]
c0d00f54:	1e5b      	subs	r3, r3, #1
c0d00f56:	1c7f      	adds	r7, r7, #1
c0d00f58:	2b00      	cmp	r3, #0
c0d00f5a:	d1e8      	bne.n	c0d00f2e <bignumLittleEndian_to_bcd+0x2a>
        const uint16_t byteIdx = bitIdx >> 3u;
        const uint8_t mask = 0x80u >> (bitIdx & 0x7u);
        carry = (uint8_t) ((binValue[binValueLen - byteIdx - 1] & mask) > 0);

        // Shift bcd
        for (uint16_t j = 0; j < bcdOutLen; j++) {
c0d00f5c:	9804      	ldr	r0, [sp, #16]
c0d00f5e:	2800      	cmp	r0, #0
c0d00f60:	d015      	beq.n	c0d00f8e <bignumLittleEndian_to_bcd+0x8a>
c0d00f62:	2007      	movs	r0, #7
        const uint8_t mask = 0x80u >> (bitIdx & 0x7u);
c0d00f64:	4010      	ands	r0, r2
c0d00f66:	2480      	movs	r4, #128	; 0x80
c0d00f68:	40c4      	lsrs	r4, r0
        const uint16_t byteIdx = bitIdx >> 3u;
c0d00f6a:	b290      	uxth	r0, r2
c0d00f6c:	08c0      	lsrs	r0, r0, #3
        carry = (uint8_t) ((binValue[binValueLen - byteIdx - 1] & mask) > 0);
c0d00f6e:	43c0      	mvns	r0, r0
c0d00f70:	9b01      	ldr	r3, [sp, #4]
c0d00f72:	18c0      	adds	r0, r0, r3
c0d00f74:	9b00      	ldr	r3, [sp, #0]
c0d00f76:	5c1b      	ldrb	r3, [r3, r0]
c0d00f78:	4023      	ands	r3, r4
c0d00f7a:	1e58      	subs	r0, r3, #1
c0d00f7c:	4183      	sbcs	r3, r0
c0d00f7e:	9c04      	ldr	r4, [sp, #16]
            uint8_t carry2 = (uint8_t) (bcdOut[bcdOutLen - j - 1] > 127u);
c0d00f80:	5d08      	ldrb	r0, [r1, r4]
            bcdOut[bcdOutLen - j - 1] <<= 1u;
c0d00f82:	0045      	lsls	r5, r0, #1
            bcdOut[bcdOutLen - j - 1] += carry;
c0d00f84:	431d      	orrs	r5, r3
c0d00f86:	550d      	strb	r5, [r1, r4]
            uint8_t carry2 = (uint8_t) (bcdOut[bcdOutLen - j - 1] > 127u);
c0d00f88:	09c3      	lsrs	r3, r0, #7
        for (uint16_t j = 0; j < bcdOutLen; j++) {
c0d00f8a:	1e64      	subs	r4, r4, #1
c0d00f8c:	d1f8      	bne.n	c0d00f80 <bignumLittleEndian_to_bcd+0x7c>
    for (uint16_t bitIdx = 0; bitIdx < binValueLen * 8; bitIdx++) {
c0d00f8e:	1c52      	adds	r2, r2, #1
c0d00f90:	b290      	uxth	r0, r2
c0d00f92:	9b02      	ldr	r3, [sp, #8]
c0d00f94:	4283      	cmp	r3, r0
c0d00f96:	d8c6      	bhi.n	c0d00f26 <bignumLittleEndian_to_bcd+0x22>
            carry = carry2;
        }
    }
}
c0d00f98:	b005      	add	sp, #20
c0d00f9a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00f9c <buffering_init>:
buffer_state_t flash;       // Flash

void buffering_init(uint8_t *ram_buffer,
                    uint16_t ram_buffer_size,
                    uint8_t *flash_buffer,
                    uint16_t flash_buffer_size) {
c0d00f9c:	b5b0      	push	{r4, r5, r7, lr}
    ram.data = ram_buffer;
c0d00f9e:	4c09      	ldr	r4, [pc, #36]	; (c0d00fc4 <buffering_init+0x28>)
c0d00fa0:	2500      	movs	r5, #0
    ram.size = ram_buffer_size;
    ram.pos = 0;
c0d00fa2:	80e5      	strh	r5, [r4, #6]
    ram.size = ram_buffer_size;
c0d00fa4:	80a1      	strh	r1, [r4, #4]
    ram.data = ram_buffer;
c0d00fa6:	6020      	str	r0, [r4, #0]
    ram.in_use = 1;

    flash.data = flash_buffer;
c0d00fa8:	4807      	ldr	r0, [pc, #28]	; (c0d00fc8 <buffering_init+0x2c>)
    flash.size = flash_buffer_size;
    flash.pos = 0;
c0d00faa:	80c5      	strh	r5, [r0, #6]
    flash.size = flash_buffer_size;
c0d00fac:	8083      	strh	r3, [r0, #4]
    flash.data = flash_buffer;
c0d00fae:	6002      	str	r2, [r0, #0]
    ram.in_use = 1;
c0d00fb0:	7a21      	ldrb	r1, [r4, #8]
c0d00fb2:	2201      	movs	r2, #1
c0d00fb4:	430a      	orrs	r2, r1
c0d00fb6:	7222      	strb	r2, [r4, #8]
    flash.in_use = 0;
c0d00fb8:	7a01      	ldrb	r1, [r0, #8]
c0d00fba:	22fe      	movs	r2, #254	; 0xfe
c0d00fbc:	400a      	ands	r2, r1
c0d00fbe:	7202      	strb	r2, [r0, #8]
}
c0d00fc0:	bdb0      	pop	{r4, r5, r7, pc}
c0d00fc2:	46c0      	nop			; (mov r8, r8)
c0d00fc4:	20000284 	.word	0x20000284
c0d00fc8:	20000290 	.word	0x20000290

c0d00fcc <buffering_reset>:

void buffering_reset() {
    ram.pos = 0;
c0d00fcc:	4806      	ldr	r0, [pc, #24]	; (c0d00fe8 <buffering_reset+0x1c>)
c0d00fce:	2100      	movs	r1, #0
c0d00fd0:	80c1      	strh	r1, [r0, #6]
    ram.in_use = 1;
    flash.pos = 0;
c0d00fd2:	4a06      	ldr	r2, [pc, #24]	; (c0d00fec <buffering_reset+0x20>)
c0d00fd4:	80d1      	strh	r1, [r2, #6]
    ram.in_use = 1;
c0d00fd6:	7a01      	ldrb	r1, [r0, #8]
c0d00fd8:	2301      	movs	r3, #1
c0d00fda:	430b      	orrs	r3, r1
c0d00fdc:	7203      	strb	r3, [r0, #8]
    flash.in_use = 0;
c0d00fde:	7a10      	ldrb	r0, [r2, #8]
c0d00fe0:	21fe      	movs	r1, #254	; 0xfe
c0d00fe2:	4001      	ands	r1, r0
c0d00fe4:	7211      	strb	r1, [r2, #8]
}
c0d00fe6:	4770      	bx	lr
c0d00fe8:	20000284 	.word	0x20000284
c0d00fec:	20000290 	.word	0x20000290

c0d00ff0 <buffering_append>:

int buffering_append(uint8_t *data, int length) {
c0d00ff0:	b570      	push	{r4, r5, r6, lr}
c0d00ff2:	460c      	mov	r4, r1
c0d00ff4:	4605      	mov	r5, r0
    if (ram.in_use) {
c0d00ff6:	4e1c      	ldr	r6, [pc, #112]	; (c0d01068 <buffering_append+0x78>)
c0d00ff8:	7a30      	ldrb	r0, [r6, #8]
c0d00ffa:	07c1      	lsls	r1, r0, #31
c0d00ffc:	d107      	bne.n	c0d0100e <buffering_append+0x1e>
            ram.pos = 0;
            return num_bytes;
        }
    } else {
        // Flash in use, append to flash
        if (flash.size - flash.pos >= length) {
c0d00ffe:	4e1b      	ldr	r6, [pc, #108]	; (c0d0106c <buffering_append+0x7c>)
c0d01000:	88f0      	ldrh	r0, [r6, #6]
c0d01002:	88b1      	ldrh	r1, [r6, #4]
c0d01004:	1a09      	subs	r1, r1, r0
c0d01006:	42a1      	cmp	r1, r4
c0d01008:	da1a      	bge.n	c0d01040 <buffering_append+0x50>
c0d0100a:	2400      	movs	r4, #0
c0d0100c:	e029      	b.n	c0d01062 <buffering_append+0x72>
        if (ram.size - ram.pos >= length) {
c0d0100e:	88f1      	ldrh	r1, [r6, #6]
c0d01010:	88b2      	ldrh	r2, [r6, #4]
c0d01012:	1a52      	subs	r2, r2, r1
c0d01014:	42a2      	cmp	r2, r4
c0d01016:	da1a      	bge.n	c0d0104e <buffering_append+0x5e>
c0d01018:	22fe      	movs	r2, #254	; 0xfe
            ram.in_use = 0;
c0d0101a:	4010      	ands	r0, r2
c0d0101c:	7230      	strb	r0, [r6, #8]
            flash.in_use = 1;
c0d0101e:	4813      	ldr	r0, [pc, #76]	; (c0d0106c <buffering_append+0x7c>)
c0d01020:	7a02      	ldrb	r2, [r0, #8]
c0d01022:	2301      	movs	r3, #1
c0d01024:	4313      	orrs	r3, r2
c0d01026:	7203      	strb	r3, [r0, #8]
            if (ram.pos > 0) {
c0d01028:	2900      	cmp	r1, #0
c0d0102a:	d002      	beq.n	c0d01032 <buffering_append+0x42>
                buffering_append(ram.data, ram.pos);
c0d0102c:	6830      	ldr	r0, [r6, #0]
c0d0102e:	f7ff ffdf 	bl	c0d00ff0 <buffering_append>
            int num_bytes = buffering_append(data, length);
c0d01032:	4628      	mov	r0, r5
c0d01034:	4621      	mov	r1, r4
c0d01036:	f7ff ffdb 	bl	c0d00ff0 <buffering_append>
c0d0103a:	2100      	movs	r1, #0
            ram.pos = 0;
c0d0103c:	80f1      	strh	r1, [r6, #6]
        } else {
            return 0;
        }
    }
    return length;
}
c0d0103e:	bd70      	pop	{r4, r5, r6, pc}
            MEMCPY_NV(flash.data + flash.pos, data, (size_t) length);
c0d01040:	6831      	ldr	r1, [r6, #0]
c0d01042:	1808      	adds	r0, r1, r0
c0d01044:	4629      	mov	r1, r5
c0d01046:	4622      	mov	r2, r4
c0d01048:	f003 fe76 	bl	c0d04d38 <nvm_write>
c0d0104c:	e005      	b.n	c0d0105a <buffering_append+0x6a>
            MEMCPY(ram.data + ram.pos, data, (size_t) length);
c0d0104e:	6830      	ldr	r0, [r6, #0]
c0d01050:	1840      	adds	r0, r0, r1
c0d01052:	4629      	mov	r1, r5
c0d01054:	4622      	mov	r2, r4
c0d01056:	f006 f95d 	bl	c0d07314 <__aeabi_memcpy>
c0d0105a:	1db0      	adds	r0, r6, #6
c0d0105c:	8801      	ldrh	r1, [r0, #0]
c0d0105e:	1909      	adds	r1, r1, r4
c0d01060:	8001      	strh	r1, [r0, #0]
}
c0d01062:	4620      	mov	r0, r4
c0d01064:	bd70      	pop	{r4, r5, r6, pc}
c0d01066:	46c0      	nop			; (mov r8, r8)
c0d01068:	20000284 	.word	0x20000284
c0d0106c:	20000290 	.word	0x20000290

c0d01070 <buffering_get_buffer>:
buffer_state_t *buffering_get_flash_buffer() {
    return &flash;
}

buffer_state_t *buffering_get_buffer() {
    if (ram.in_use) {
c0d01070:	4802      	ldr	r0, [pc, #8]	; (c0d0107c <buffering_get_buffer+0xc>)
c0d01072:	7a01      	ldrb	r1, [r0, #8]
c0d01074:	07c9      	lsls	r1, r1, #31
c0d01076:	d100      	bne.n	c0d0107a <buffering_get_buffer+0xa>
c0d01078:	4801      	ldr	r0, [pc, #4]	; (c0d01080 <buffering_get_buffer+0x10>)
        return &ram;
    }
    return &flash;
}
c0d0107a:	4770      	bx	lr
c0d0107c:	20000284 	.word	0x20000284
c0d01080:	20000290 	.word	0x20000290

c0d01084 <check_audited_app>:

// This function is called at the end of the seph initialization.
// It checks the install parameters of the application to be run, and if this area contains the
// CHECK_NOT_AUDITED_TLV_TAG tag with the CHECK_NOT_AUDITED_TLV_VAL value, a specific display
// is triggered before the actual application's splash screen.
void check_audited_app(void) {
c0d01084:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01086:	b087      	sub	sp, #28
c0d01088:	ad06      	add	r5, sp, #24
c0d0108a:	2055      	movs	r0, #85	; 0x55
  unsigned char     data = BOLOS_FALSE;
c0d0108c:	7028      	strb	r0, [r5, #0]
  unsigned char*    buffer = &data;
c0d0108e:	9505      	str	r5, [sp, #20]
c0d01090:	2001      	movs	r0, #1
  unsigned int      slot;
  unsigned int      length = os_parse_bertlv((unsigned char*)(&_install_parameters),
c0d01092:	9002      	str	r0, [sp, #8]
c0d01094:	a805      	add	r0, sp, #20
c0d01096:	9001      	str	r0, [sp, #4]
c0d01098:	2400      	movs	r4, #0
c0d0109a:	9400      	str	r4, [sp, #0]
c0d0109c:	4865      	ldr	r0, [pc, #404]	; (c0d01234 <check_audited_app+0x1b0>)
c0d0109e:	4478      	add	r0, pc
c0d010a0:	2140      	movs	r1, #64	; 0x40
c0d010a2:	239f      	movs	r3, #159	; 0x9f
c0d010a4:	4622      	mov	r2, r4
c0d010a6:	f000 fae3 	bl	c0d01670 <os_parse_bertlv>
                                             sizeof(data));

  // We trigger the associated behaviour only when the tag was present and the value corresponds to
  // the expected one.
  if (   (length)
      && (CHECK_NOT_AUDITED_TLV_VAL == data))
c0d010aa:	2800      	cmp	r0, #0
c0d010ac:	d100      	bne.n	c0d010b0 <check_audited_app+0x2c>
c0d010ae:	e0ba      	b.n	c0d01226 <check_audited_app+0x1a2>
c0d010b0:	7828      	ldrb	r0, [r5, #0]
c0d010b2:	2801      	cmp	r0, #1
c0d010b4:	d000      	beq.n	c0d010b8 <check_audited_app+0x34>
c0d010b6:	e0b6      	b.n	c0d01226 <check_audited_app+0x1a2>
  {
    // We reserve the first slot for this display.
    slot = ux_stack_push();
c0d010b8:	f005 f908 	bl	c0d062cc <ux_stack_push>
c0d010bc:	4605      	mov	r5, r0
    ux_stack_init(slot);
c0d010be:	f005 f935 	bl	c0d0632c <ux_stack_init>

    // We trigger the additional display and wait for it to be completed.
    G_ux.stack[slot].element_arrays[0].element_array = ui_audited_elements;
c0d010c2:	0168      	lsls	r0, r5, #5
c0d010c4:	4e59      	ldr	r6, [pc, #356]	; (c0d0122c <check_audited_app+0x1a8>)
c0d010c6:	1832      	adds	r2, r6, r0
c0d010c8:	272c      	movs	r7, #44	; 0x2c
c0d010ca:	2003      	movs	r0, #3
    G_ux.stack[slot].element_arrays[0].element_array_count = sizeof(ui_audited_elements) / sizeof(ui_audited_elements[0]);
c0d010cc:	55d0      	strb	r0, [r2, r7]
c0d010ce:	2144      	movs	r1, #68	; 0x44
    G_ux.stack[slot].button_push_callback = ui_audited_elements_button;
    G_ux.stack[slot].screen_before_element_display_callback = NULL;
    UX_WAKE_UP();
c0d010d0:	5470      	strb	r0, [r6, r1]
    G_ux.stack[slot].button_push_callback = ui_audited_elements_button;
c0d010d2:	4859      	ldr	r0, [pc, #356]	; (c0d01238 <check_audited_app+0x1b4>)
c0d010d4:	4478      	add	r0, pc
    G_ux.stack[slot].element_arrays[0].element_array = ui_audited_elements;
c0d010d6:	4959      	ldr	r1, [pc, #356]	; (c0d0123c <check_audited_app+0x1b8>)
c0d010d8:	4479      	add	r1, pc
c0d010da:	6291      	str	r1, [r2, #40]	; 0x28
    G_ux.stack[slot].screen_before_element_display_callback = NULL;
c0d010dc:	6314      	str	r4, [r2, #48]	; 0x30
c0d010de:	9204      	str	r2, [sp, #16]
    G_ux.stack[slot].button_push_callback = ui_audited_elements_button;
c0d010e0:	6350      	str	r0, [r2, #52]	; 0x34
    UX_WAKE_UP();
c0d010e2:	4635      	mov	r5, r6
c0d010e4:	3544      	adds	r5, #68	; 0x44
c0d010e6:	606c      	str	r4, [r5, #4]
c0d010e8:	4628      	mov	r0, r5
c0d010ea:	f003 fe7b 	bl	c0d04de4 <os_ux>
c0d010ee:	2004      	movs	r0, #4
c0d010f0:	f003 ff04 	bl	c0d04efc <os_sched_last_status>
c0d010f4:	6068      	str	r0, [r5, #4]
    UX_DISPLAY_NEXT_ELEMENT();
c0d010f6:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d010f8:	2800      	cmp	r0, #0
c0d010fa:	d028      	beq.n	c0d0114e <check_audited_app+0xca>
c0d010fc:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d010fe:	5df1      	ldrb	r1, [r6, r7]
c0d01100:	b280      	uxth	r0, r0
c0d01102:	4288      	cmp	r0, r1
c0d01104:	d223      	bcs.n	c0d0114e <check_audited_app+0xca>
c0d01106:	f003 fec5 	bl	c0d04e94 <io_seph_is_status_sent>
c0d0110a:	2800      	cmp	r0, #0
c0d0110c:	d11f      	bne.n	c0d0114e <check_audited_app+0xca>
c0d0110e:	f003 fe2b 	bl	c0d04d68 <os_perso_isonboarded>
c0d01112:	28aa      	cmp	r0, #170	; 0xaa
c0d01114:	d103      	bne.n	c0d0111e <check_audited_app+0x9a>
c0d01116:	f003 fe57 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d0111a:	28aa      	cmp	r0, #170	; 0xaa
c0d0111c:	d117      	bne.n	c0d0114e <check_audited_app+0xca>
c0d0111e:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d01120:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d01122:	0150      	lsls	r0, r2, #5
c0d01124:	1808      	adds	r0, r1, r0
c0d01126:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d01128:	2b00      	cmp	r3, #0
c0d0112a:	d004      	beq.n	c0d01136 <check_audited_app+0xb2>
c0d0112c:	4798      	blx	r3
c0d0112e:	2800      	cmp	r0, #0
c0d01130:	d007      	beq.n	c0d01142 <check_audited_app+0xbe>
c0d01132:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d01134:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d01136:	2801      	cmp	r0, #1
c0d01138:	d101      	bne.n	c0d0113e <check_audited_app+0xba>
c0d0113a:	0150      	lsls	r0, r2, #5
c0d0113c:	1808      	adds	r0, r1, r0
c0d0113e:	f005 f96b 	bl	c0d06418 <io_seproxyhal_display>
c0d01142:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d01144:	1c40      	adds	r0, r0, #1
c0d01146:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d01148:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d0114a:	2900      	cmp	r1, #0
c0d0114c:	d1d7      	bne.n	c0d010fe <check_audited_app+0x7a>
    UX_WAIT_DISPLAYED();
c0d0114e:	5df0      	ldrb	r0, [r6, r7]
c0d01150:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d01152:	4281      	cmp	r1, r0
c0d01154:	d237      	bcs.n	c0d011c6 <check_audited_app+0x142>
c0d01156:	4c36      	ldr	r4, [pc, #216]	; (c0d01230 <check_audited_app+0x1ac>)
c0d01158:	2180      	movs	r1, #128	; 0x80
c0d0115a:	2200      	movs	r2, #0
c0d0115c:	4620      	mov	r0, r4
c0d0115e:	f003 fea5 	bl	c0d04eac <io_seph_recv>
c0d01162:	f000 fbe1 	bl	c0d01928 <io_seproxyhal_handle_event>
c0d01166:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d01168:	2800      	cmp	r0, #0
c0d0116a:	d028      	beq.n	c0d011be <check_audited_app+0x13a>
c0d0116c:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d0116e:	5df1      	ldrb	r1, [r6, r7]
c0d01170:	b280      	uxth	r0, r0
c0d01172:	4288      	cmp	r0, r1
c0d01174:	d223      	bcs.n	c0d011be <check_audited_app+0x13a>
c0d01176:	f003 fe8d 	bl	c0d04e94 <io_seph_is_status_sent>
c0d0117a:	2800      	cmp	r0, #0
c0d0117c:	d11f      	bne.n	c0d011be <check_audited_app+0x13a>
c0d0117e:	f003 fdf3 	bl	c0d04d68 <os_perso_isonboarded>
c0d01182:	28aa      	cmp	r0, #170	; 0xaa
c0d01184:	d103      	bne.n	c0d0118e <check_audited_app+0x10a>
c0d01186:	f003 fe1f 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d0118a:	28aa      	cmp	r0, #170	; 0xaa
c0d0118c:	d117      	bne.n	c0d011be <check_audited_app+0x13a>
c0d0118e:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d01190:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d01192:	0150      	lsls	r0, r2, #5
c0d01194:	1808      	adds	r0, r1, r0
c0d01196:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d01198:	2b00      	cmp	r3, #0
c0d0119a:	d004      	beq.n	c0d011a6 <check_audited_app+0x122>
c0d0119c:	4798      	blx	r3
c0d0119e:	2800      	cmp	r0, #0
c0d011a0:	d007      	beq.n	c0d011b2 <check_audited_app+0x12e>
c0d011a2:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d011a4:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d011a6:	2801      	cmp	r0, #1
c0d011a8:	d101      	bne.n	c0d011ae <check_audited_app+0x12a>
c0d011aa:	0150      	lsls	r0, r2, #5
c0d011ac:	1808      	adds	r0, r1, r0
c0d011ae:	f005 f933 	bl	c0d06418 <io_seproxyhal_display>
c0d011b2:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d011b4:	1c40      	adds	r0, r0, #1
c0d011b6:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d011b8:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d011ba:	2900      	cmp	r1, #0
c0d011bc:	d1d7      	bne.n	c0d0116e <check_audited_app+0xea>
c0d011be:	5df0      	ldrb	r0, [r6, r7]
c0d011c0:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d011c2:	4281      	cmp	r1, r0
c0d011c4:	d3c8      	bcc.n	c0d01158 <check_audited_app+0xd4>
c0d011c6:	9f04      	ldr	r7, [sp, #16]
c0d011c8:	3734      	adds	r7, #52	; 0x34
c0d011ca:	4c19      	ldr	r4, [pc, #100]	; (c0d01230 <check_audited_app+0x1ac>)
c0d011cc:	2580      	movs	r5, #128	; 0x80
c0d011ce:	2600      	movs	r6, #0
c0d011d0:	4620      	mov	r0, r4
c0d011d2:	4629      	mov	r1, r5
c0d011d4:	4632      	mov	r2, r6
c0d011d6:	f003 fe69 	bl	c0d04eac <io_seph_recv>
c0d011da:	f000 fba5 	bl	c0d01928 <io_seproxyhal_handle_event>
c0d011de:	f000 faed 	bl	c0d017bc <io_seproxyhal_general_status>
c0d011e2:	4620      	mov	r0, r4
c0d011e4:	4629      	mov	r1, r5
c0d011e6:	4632      	mov	r2, r6
c0d011e8:	f003 fe60 	bl	c0d04eac <io_seph_recv>


    io_seproxyhal_general_status();
c0d011ec:	f000 fae6 	bl	c0d017bc <io_seproxyhal_general_status>
c0d011f0:	2180      	movs	r1, #128	; 0x80
c0d011f2:	2200      	movs	r2, #0
    // We wait for the button callback pointer to be wiped, and we process the incoming MCU events in the
    // meantime. This callback will be wiped within the actual 'ui_audited_elements_button' function,
    // as soon as the user presses both buttons.
    do {
      io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d011f4:	4620      	mov	r0, r4
c0d011f6:	f003 fe59 	bl	c0d04eac <io_seph_recv>
      io_seproxyhal_handle_event();
c0d011fa:	f000 fb95 	bl	c0d01928 <io_seproxyhal_handle_event>
      io_seproxyhal_general_status();
c0d011fe:	f000 fadd 	bl	c0d017bc <io_seproxyhal_general_status>
    } while (io_seproxyhal_spi_is_status_sent() && G_ux.stack[slot].button_push_callback);
c0d01202:	f003 fe47 	bl	c0d04e94 <io_seph_is_status_sent>
c0d01206:	2800      	cmp	r0, #0
c0d01208:	d002      	beq.n	c0d01210 <check_audited_app+0x18c>
c0d0120a:	6838      	ldr	r0, [r7, #0]
c0d0120c:	2800      	cmp	r0, #0
c0d0120e:	d1ef      	bne.n	c0d011f0 <check_audited_app+0x16c>

    // We pop the reserved slot but we do not care about the returned value (since we do not need it for
    // further displays at the moment) and reinitialize the UX and buttons.
    ux_stack_pop();
c0d01210:	f005 f86c 	bl	c0d062ec <ux_stack_pop>
    io_seproxyhal_init_ux();
c0d01214:	f000 fbfc 	bl	c0d01a10 <io_seproxyhal_init_ux>
    io_seproxyhal_init_button();
c0d01218:	f000 fbfc 	bl	c0d01a14 <io_seproxyhal_init_button>

    // Now we can wait for the next MCU status and exit.
    io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0121c:	4804      	ldr	r0, [pc, #16]	; (c0d01230 <check_audited_app+0x1ac>)
c0d0121e:	2180      	movs	r1, #128	; 0x80
c0d01220:	2200      	movs	r2, #0
c0d01222:	f003 fe43 	bl	c0d04eac <io_seph_recv>
  }
}
c0d01226:	b007      	add	sp, #28
c0d01228:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0122a:	46c0      	nop			; (mov r8, r8)
c0d0122c:	200005f0 	.word	0x200005f0
c0d01230:	20000202 	.word	0x20000202
c0d01234:	000095de 	.word	0x000095de
c0d01238:	00000169 	.word	0x00000169
c0d0123c:	000066ac 	.word	0x000066ac

c0d01240 <ui_audited_elements_button>:
static unsigned int ui_audited_elements_button(unsigned int button_mask, unsigned int button_mask_counter __attribute__((unused))) {
c0d01240:	490c      	ldr	r1, [pc, #48]	; (c0d01274 <ui_audited_elements_button+0x34>)
  if ((button_mask & (BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT)) == (BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT)) {
c0d01242:	4008      	ands	r0, r1
c0d01244:	4288      	cmp	r0, r1
c0d01246:	d112      	bne.n	c0d0126e <ui_audited_elements_button+0x2e>
c0d01248:	480b      	ldr	r0, [pc, #44]	; (c0d01278 <ui_audited_elements_button+0x38>)
c0d0124a:	7801      	ldrb	r1, [r0, #0]
c0d0124c:	2900      	cmp	r1, #0
c0d0124e:	d00e      	beq.n	c0d0126e <ui_audited_elements_button+0x2e>
    for (slot = 0x00; slot < G_ux.stack_count; slot++) {
c0d01250:	2901      	cmp	r1, #1
c0d01252:	d800      	bhi.n	c0d01256 <ui_audited_elements_button+0x16>
c0d01254:	2101      	movs	r1, #1
c0d01256:	3034      	adds	r0, #52	; 0x34
c0d01258:	4a08      	ldr	r2, [pc, #32]	; (c0d0127c <ui_audited_elements_button+0x3c>)
c0d0125a:	447a      	add	r2, pc
      if (G_ux.stack[slot].button_push_callback == ui_audited_elements_button) {
c0d0125c:	6803      	ldr	r3, [r0, #0]
c0d0125e:	4293      	cmp	r3, r2
c0d01260:	d003      	beq.n	c0d0126a <ui_audited_elements_button+0x2a>
    for (slot = 0x00; slot < G_ux.stack_count; slot++) {
c0d01262:	3020      	adds	r0, #32
c0d01264:	1e49      	subs	r1, r1, #1
c0d01266:	d1f9      	bne.n	c0d0125c <ui_audited_elements_button+0x1c>
c0d01268:	e001      	b.n	c0d0126e <ui_audited_elements_button+0x2e>
c0d0126a:	2100      	movs	r1, #0
        G_ux.stack[slot].button_push_callback = NULL;
c0d0126c:	6001      	str	r1, [r0, #0]
c0d0126e:	2000      	movs	r0, #0
  return 0;
c0d01270:	4770      	bx	lr
c0d01272:	46c0      	nop			; (mov r8, r8)
c0d01274:	80000003 	.word	0x80000003
c0d01278:	200005f0 	.word	0x200005f0
c0d0127c:	ffffffe3 	.word	0xffffffe3

c0d01280 <crypto_extractPublicKey>:

uint16_t sr25519_signdataLen;
uint32_t hdPath[HDPATH_LEN_DEFAULT];

zxerr_t crypto_extractPublicKey(key_kind_e addressKind, const uint32_t path[HDPATH_LEN_DEFAULT],
                                uint8_t *pubKey, uint16_t pubKeyLen) {
c0d01280:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01282:	b0bf      	sub	sp, #252	; 0xfc
c0d01284:	461f      	mov	r7, r3
c0d01286:	4614      	mov	r4, r2
c0d01288:	460e      	mov	r6, r1
c0d0128a:	9005      	str	r0, [sp, #20]
c0d0128c:	a812      	add	r0, sp, #72	; 0x48
c0d0128e:	2140      	movs	r1, #64	; 0x40
    cx_ecfp_public_key_t cx_publicKey;
    cx_ecfp_private_key_t cx_privateKey;
    uint8_t privateKeyData[SK_LEN_25519];
    MEMZERO(privateKeyData, SK_LEN_25519);
c0d01290:	f006 f850 	bl	c0d07334 <explicit_bzero>
c0d01294:	250c      	movs	r5, #12

    if (pubKeyLen < PK_LEN_25519) {
c0d01296:	2f20      	cmp	r7, #32
c0d01298:	d201      	bcs.n	c0d0129e <crypto_extractPublicKey+0x1e>
c0d0129a:	4628      	mov	r0, r5
c0d0129c:	e01b      	b.n	c0d012d6 <crypto_extractPublicKey+0x56>
c0d0129e:	af06      	add	r7, sp, #24
        return zxerr_invalid_crypto_settings;
    }

    BEGIN_TRY
    {
        TRY
c0d012a0:	4638      	mov	r0, r7
c0d012a2:	f006 f96b 	bl	c0d0757c <setjmp>
c0d012a6:	85b8      	strh	r0, [r7, #44]	; 0x2c
c0d012a8:	0400      	lsls	r0, r0, #16
c0d012aa:	d016      	beq.n	c0d012da <crypto_extractPublicKey+0x5a>
                default:
                    CLOSE_TRY;
                    return zxerr_invalid_crypto_settings;
            }
        }
        FINALLY
c0d012ac:	f003 fe0c 	bl	c0d04ec8 <try_context_get>
c0d012b0:	a906      	add	r1, sp, #24
c0d012b2:	4288      	cmp	r0, r1
c0d012b4:	d102      	bne.n	c0d012bc <crypto_extractPublicKey+0x3c>
c0d012b6:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d012b8:	f003 fe12 	bl	c0d04ee0 <try_context_set>
c0d012bc:	a822      	add	r0, sp, #136	; 0x88
c0d012be:	2128      	movs	r1, #40	; 0x28
        {
            MEMZERO(&cx_privateKey, sizeof(cx_privateKey));
c0d012c0:	f006 f838 	bl	c0d07334 <explicit_bzero>
c0d012c4:	a812      	add	r0, sp, #72	; 0x48
c0d012c6:	2140      	movs	r1, #64	; 0x40
            MEMZERO(privateKeyData, SK_LEN_25519);
c0d012c8:	f006 f834 	bl	c0d07334 <explicit_bzero>
c0d012cc:	a806      	add	r0, sp, #24
        }
    }
    END_TRY;
c0d012ce:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d012d0:	2800      	cmp	r0, #0
c0d012d2:	d143      	bne.n	c0d0135c <crypto_extractPublicKey+0xdc>
c0d012d4:	2003      	movs	r0, #3

    return zxerr_ok;
}
c0d012d6:	b03f      	add	sp, #252	; 0xfc
c0d012d8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d012da:	a806      	add	r0, sp, #24
        TRY
c0d012dc:	f003 fe00 	bl	c0d04ee0 <try_context_set>
c0d012e0:	9010      	str	r0, [sp, #64]	; 0x40
c0d012e2:	2000      	movs	r0, #0
            os_perso_derive_node_bip32_seed_key(
c0d012e4:	9003      	str	r0, [sp, #12]
c0d012e6:	9002      	str	r0, [sp, #8]
c0d012e8:	9001      	str	r0, [sp, #4]
c0d012ea:	a912      	add	r1, sp, #72	; 0x48
c0d012ec:	9100      	str	r1, [sp, #0]
c0d012ee:	2171      	movs	r1, #113	; 0x71
c0d012f0:	2305      	movs	r3, #5
c0d012f2:	4632      	mov	r2, r6
c0d012f4:	f003 fd46 	bl	c0d04d84 <os_perso_derive_node_with_seed_key>
            switch (addressKind) {
c0d012f8:	9805      	ldr	r0, [sp, #20]
c0d012fa:	2800      	cmp	r0, #0
c0d012fc:	d003      	beq.n	c0d01306 <crypto_extractPublicKey+0x86>
                    CLOSE_TRY;
c0d012fe:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d01300:	f003 fdee 	bl	c0d04ee0 <try_context_set>
c0d01304:	e7c9      	b.n	c0d0129a <crypto_extractPublicKey+0x1a>
c0d01306:	2071      	movs	r0, #113	; 0x71
c0d01308:	a912      	add	r1, sp, #72	; 0x48
c0d0130a:	2220      	movs	r2, #32
c0d0130c:	ab22      	add	r3, sp, #136	; 0x88
 * @throws             CX_EC_INVALID_CURVE
 * @throws             CX_INVALID_PARAMETER
 */
static inline int cx_ecfp_init_private_key ( cx_curve_t curve, const unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * pvkey )
{
  CX_THROW(cx_ecfp_init_private_key_no_throw(curve, rawkey, key_len, pvkey));
c0d0130e:	f000 f957 	bl	c0d015c0 <cx_ecfp_init_private_key_no_throw>
c0d01312:	2800      	cmp	r0, #0
c0d01314:	d122      	bne.n	c0d0135c <crypto_extractPublicKey+0xdc>
c0d01316:	2071      	movs	r0, #113	; 0x71
c0d01318:	2500      	movs	r5, #0
c0d0131a:	ab2c      	add	r3, sp, #176	; 0xb0
  CX_THROW(cx_ecfp_init_public_key_no_throw(curve, rawkey, key_len, key));
c0d0131c:	4629      	mov	r1, r5
c0d0131e:	462a      	mov	r2, r5
c0d01320:	f000 f954 	bl	c0d015cc <cx_ecfp_init_public_key_no_throw>
c0d01324:	2800      	cmp	r0, #0
c0d01326:	d119      	bne.n	c0d0135c <crypto_extractPublicKey+0xdc>
c0d01328:	2071      	movs	r0, #113	; 0x71
c0d0132a:	a92c      	add	r1, sp, #176	; 0xb0
c0d0132c:	aa22      	add	r2, sp, #136	; 0x88
c0d0132e:	2301      	movs	r3, #1
 * @throws                 CX_EC_INVALID_POINT
 * @throws                 CX_EC_INFINITE_POINT
 */
static inline int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate )
{
  CX_THROW(cx_ecfp_generate_pair_no_throw(curve, pubkey, privkey, keepprivate));
c0d01330:	f000 f940 	bl	c0d015b4 <cx_ecfp_generate_pair_no_throw>
c0d01334:	2800      	cmp	r0, #0
c0d01336:	d111      	bne.n	c0d0135c <crypto_extractPublicKey+0xdc>
c0d01338:	a82c      	add	r0, sp, #176	; 0xb0
                    for (unsigned int i = 0; i < PK_LEN_25519; i++) {
c0d0133a:	3048      	adds	r0, #72	; 0x48
                        pubKey[i] = cx_publicKey.W[64 - i];
c0d0133c:	7801      	ldrb	r1, [r0, #0]
c0d0133e:	5561      	strb	r1, [r4, r5]
                    for (unsigned int i = 0; i < PK_LEN_25519; i++) {
c0d01340:	1e40      	subs	r0, r0, #1
c0d01342:	1c6d      	adds	r5, r5, #1
c0d01344:	2d20      	cmp	r5, #32
c0d01346:	d1f9      	bne.n	c0d0133c <crypto_extractPublicKey+0xbc>
c0d01348:	2028      	movs	r0, #40	; 0x28
c0d0134a:	a92c      	add	r1, sp, #176	; 0xb0
                    if ((cx_publicKey.W[PK_LEN_25519] & 1) != 0) {
c0d0134c:	5c08      	ldrb	r0, [r1, r0]
c0d0134e:	07c0      	lsls	r0, r0, #31
c0d01350:	d0ac      	beq.n	c0d012ac <crypto_extractPublicKey+0x2c>
                        pubKey[31] |= 0x80;
c0d01352:	7fe0      	ldrb	r0, [r4, #31]
c0d01354:	2180      	movs	r1, #128	; 0x80
c0d01356:	4301      	orrs	r1, r0
c0d01358:	77e1      	strb	r1, [r4, #31]
c0d0135a:	e7a7      	b.n	c0d012ac <crypto_extractPublicKey+0x2c>
c0d0135c:	f000 f963 	bl	c0d01626 <os_longjmp>

c0d01360 <crypto_sign_ed25519>:

zxerr_t crypto_sign_ed25519(uint8_t *signature, uint16_t signatureMaxlen,
                            const uint8_t *message, uint16_t messageLen,
                            uint16_t *signatureLen) {
c0d01360:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01362:	b0e7      	sub	sp, #412	; 0x19c
c0d01364:	4617      	mov	r7, r2
c0d01366:	9106      	str	r1, [sp, #24]
c0d01368:	9007      	str	r0, [sp, #28]
c0d0136a:	20ff      	movs	r0, #255	; 0xff
c0d0136c:	3002      	adds	r0, #2
c0d0136e:	461d      	mov	r5, r3
    const uint8_t *toSign = message;
    uint8_t messageDigest[BLAKE2B_DIGEST_SIZE];

    if (messageLen > MAX_SIGN_SIZE) {
c0d01370:	4283      	cmp	r3, r0
c0d01372:	d317      	bcc.n	c0d013a4 <crypto_sign_ed25519+0x44>
c0d01374:	2001      	movs	r0, #1
c0d01376:	0201      	lsls	r1, r0, #8
c0d01378:	a81e      	add	r0, sp, #120	; 0x78
 * 
 * @throws             CX_INVALID_PARAMETER
 */
static inline int cx_blake2b_init ( cx_blake2b_t * hash, unsigned int out_len )
{
  CX_THROW(cx_blake2b_init_no_throw(hash, out_len));
c0d0137a:	f000 f915 	bl	c0d015a8 <cx_blake2b_init_no_throw>
c0d0137e:	2800      	cmp	r0, #0
c0d01380:	d17c      	bne.n	c0d0147c <crypto_sign_ed25519+0x11c>
c0d01382:	2420      	movs	r4, #32
 * @throws             INVALID_PARAMETER
 * @throws             CX_INVALID_PARAMETER
 */
static inline int cx_hash ( cx_hash_t * hash, int mode, const unsigned char * in, unsigned int len, unsigned char * out, unsigned int out_len )
{
  CX_THROW(cx_hash_no_throw(hash, mode, in, len, out, out_len));
c0d01384:	9401      	str	r4, [sp, #4]
c0d01386:	a85e      	add	r0, sp, #376	; 0x178
c0d01388:	9000      	str	r0, [sp, #0]
c0d0138a:	a81e      	add	r0, sp, #120	; 0x78
c0d0138c:	2101      	movs	r1, #1
c0d0138e:	463a      	mov	r2, r7
c0d01390:	462b      	mov	r3, r5
c0d01392:	f000 f92d 	bl	c0d015f0 <cx_hash_no_throw>
c0d01396:	2800      	cmp	r0, #0
c0d01398:	d170      	bne.n	c0d0147c <crypto_sign_ed25519+0x11c>
c0d0139a:	a81e      	add	r0, sp, #120	; 0x78
  return cx_hash_get_size(hash);
c0d0139c:	f000 f922 	bl	c0d015e4 <cx_hash_get_size>
c0d013a0:	af5e      	add	r7, sp, #376	; 0x178
c0d013a2:	4625      	mov	r5, r4
c0d013a4:	462c      	mov	r4, r5
c0d013a6:	ad08      	add	r5, sp, #32
    int signatureLength = 0;
    unsigned int info = 0;

    BEGIN_TRY
    {
        TRY
c0d013a8:	4628      	mov	r0, r5
c0d013aa:	f006 f8e7 	bl	c0d0757c <setjmp>
c0d013ae:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d013b0:	0400      	lsls	r0, r0, #16
c0d013b2:	d014      	beq.n	c0d013de <crypto_sign_ed25519+0x7e>
c0d013b4:	9d6c      	ldr	r5, [sp, #432]	; 0x1b0
c0d013b6:	a808      	add	r0, sp, #32
c0d013b8:	2400      	movs	r4, #0
                                            signature + 1,
                                            signatureMaxlen - 1,
                                            &info);

        }
        CATCH_ALL
c0d013ba:	8584      	strh	r4, [r0, #44]	; 0x2c
c0d013bc:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d013be:	f003 fd8f 	bl	c0d04ee0 <try_context_set>
c0d013c2:	a814      	add	r0, sp, #80	; 0x50
c0d013c4:	2128      	movs	r1, #40	; 0x28
        {
            MEMZERO(&cx_privateKey, sizeof(cx_privateKey));
c0d013c6:	f005 ffb5 	bl	c0d07334 <explicit_bzero>
c0d013ca:	a81e      	add	r0, sp, #120	; 0x78
c0d013cc:	2140      	movs	r1, #64	; 0x40
            MEMZERO(privateKeyData, SK_LEN_25519);
c0d013ce:	f005 ffb1 	bl	c0d07334 <explicit_bzero>
            *signatureLen = 0;
c0d013d2:	802c      	strh	r4, [r5, #0]
            CLOSE_TRY;
c0d013d4:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d013d6:	f003 fd83 	bl	c0d04ee0 <try_context_set>
            MEMZERO(&cx_privateKey, sizeof(cx_privateKey));
            MEMZERO(privateKeyData, SK_LEN_25519);
            MEMZERO(signature + signatureLength + 1, signatureMaxlen - signatureLength - 1);
        }
    }
    END_TRY;
c0d013da:	4620      	mov	r0, r4
c0d013dc:	e04c      	b.n	c0d01478 <crypto_sign_ed25519+0x118>
c0d013de:	9405      	str	r4, [sp, #20]
c0d013e0:	a808      	add	r0, sp, #32
        TRY
c0d013e2:	f003 fd7d 	bl	c0d04ee0 <try_context_set>
c0d013e6:	9012      	str	r0, [sp, #72]	; 0x48
c0d013e8:	2500      	movs	r5, #0
            os_perso_derive_node_bip32_seed_key(
c0d013ea:	9503      	str	r5, [sp, #12]
c0d013ec:	9502      	str	r5, [sp, #8]
c0d013ee:	9501      	str	r5, [sp, #4]
c0d013f0:	ac1e      	add	r4, sp, #120	; 0x78
c0d013f2:	9400      	str	r4, [sp, #0]
c0d013f4:	2671      	movs	r6, #113	; 0x71
c0d013f6:	4a22      	ldr	r2, [pc, #136]	; (c0d01480 <crypto_sign_ed25519+0x120>)
c0d013f8:	2305      	movs	r3, #5
c0d013fa:	4628      	mov	r0, r5
c0d013fc:	4631      	mov	r1, r6
c0d013fe:	f003 fcc1 	bl	c0d04d84 <os_perso_derive_node_with_seed_key>
c0d01402:	2220      	movs	r2, #32
c0d01404:	ab14      	add	r3, sp, #80	; 0x50
  CX_THROW(cx_ecfp_init_private_key_no_throw(curve, rawkey, key_len, pvkey));
c0d01406:	4630      	mov	r0, r6
c0d01408:	4621      	mov	r1, r4
c0d0140a:	f000 f8d9 	bl	c0d015c0 <cx_ecfp_init_private_key_no_throw>
c0d0140e:	2800      	cmp	r0, #0
c0d01410:	d134      	bne.n	c0d0147c <crypto_sign_ed25519+0x11c>
c0d01412:	9e07      	ldr	r6, [sp, #28]
            *signature = PREFIX_SIGNATURE_TYPE_ED25519;
c0d01414:	7035      	strb	r5, [r6, #0]
c0d01416:	9c06      	ldr	r4, [sp, #24]
                                            signatureMaxlen - 1,
c0d01418:	1e60      	subs	r0, r4, #1
                                            signature + 1,
c0d0141a:	1c71      	adds	r1, r6, #1
  UNUSED(ctx);
  UNUSED(ctx_len);
  UNUSED(mode);
  UNUSED(info);

  CX_THROW(cx_eddsa_sign_no_throw(pvkey, hashID, hash, hash_len, sig, sig_len));
c0d0141c:	9100      	str	r1, [sp, #0]
c0d0141e:	9001      	str	r0, [sp, #4]
c0d01420:	a814      	add	r0, sp, #80	; 0x50
c0d01422:	2105      	movs	r1, #5
c0d01424:	463a      	mov	r2, r7
c0d01426:	9b05      	ldr	r3, [sp, #20]
c0d01428:	f000 f8d6 	bl	c0d015d8 <cx_eddsa_sign_no_throw>
c0d0142c:	2800      	cmp	r0, #0
c0d0142e:	d125      	bne.n	c0d0147c <crypto_sign_ed25519+0x11c>
c0d01430:	a814      	add	r0, sp, #80	; 0x50

  size_t size;
  CX_THROW(cx_ecdomain_parameters_length(pvkey->curve, &size));
c0d01432:	7800      	ldrb	r0, [r0, #0]
c0d01434:	a966      	add	r1, sp, #408	; 0x198
c0d01436:	f003 fc8b 	bl	c0d04d50 <cx_ecdomain_parameters_length>
c0d0143a:	2800      	cmp	r0, #0
c0d0143c:	d11e      	bne.n	c0d0147c <crypto_sign_ed25519+0x11c>

  return 2 * size;
c0d0143e:	9866      	ldr	r0, [sp, #408]	; 0x198
c0d01440:	0045      	lsls	r5, r0, #1
        FINALLY
c0d01442:	f003 fd41 	bl	c0d04ec8 <try_context_get>
c0d01446:	a908      	add	r1, sp, #32
c0d01448:	4288      	cmp	r0, r1
c0d0144a:	d102      	bne.n	c0d01452 <crypto_sign_ed25519+0xf2>
c0d0144c:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d0144e:	f003 fd47 	bl	c0d04ee0 <try_context_set>
c0d01452:	a814      	add	r0, sp, #80	; 0x50
c0d01454:	2128      	movs	r1, #40	; 0x28
            MEMZERO(&cx_privateKey, sizeof(cx_privateKey));
c0d01456:	f005 ff6d 	bl	c0d07334 <explicit_bzero>
c0d0145a:	a81e      	add	r0, sp, #120	; 0x78
c0d0145c:	2140      	movs	r1, #64	; 0x40
            MEMZERO(privateKeyData, SK_LEN_25519);
c0d0145e:	f005 ff69 	bl	c0d07334 <explicit_bzero>
            MEMZERO(signature + signatureLength + 1, signatureMaxlen - signatureLength - 1);
c0d01462:	43e8      	mvns	r0, r5
c0d01464:	1901      	adds	r1, r0, r4
c0d01466:	1970      	adds	r0, r6, r5
c0d01468:	1c40      	adds	r0, r0, #1
c0d0146a:	f005 ff63 	bl	c0d07334 <explicit_bzero>
c0d0146e:	a808      	add	r0, sp, #32
    END_TRY;
c0d01470:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d01472:	2800      	cmp	r0, #0
c0d01474:	d102      	bne.n	c0d0147c <crypto_sign_ed25519+0x11c>
c0d01476:	2003      	movs	r0, #3
    return zxerr_ok;
}
c0d01478:	b067      	add	sp, #412	; 0x19c
c0d0147a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0147c:	f000 f8d3 	bl	c0d01626 <os_longjmp>
c0d01480:	2000029c 	.word	0x2000029c

c0d01484 <crypto_fillAddress>:
    END_TRY;
    return zxerr_ok;
}
#endif

zxerr_t crypto_fillAddress(key_kind_e addressKind, uint8_t *buffer, uint16_t bufferLen, uint16_t *addrResponseLen) {
c0d01484:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01486:	b081      	sub	sp, #4
c0d01488:	2400      	movs	r4, #0
    if (bufferLen < PK_LEN_25519 + SS58_ADDRESS_MAX_LEN) {
c0d0148a:	2a5c      	cmp	r2, #92	; 0x5c
c0d0148c:	d201      	bcs.n	c0d01492 <crypto_fillAddress+0xe>
c0d0148e:	4620      	mov	r0, r4
c0d01490:	e01e      	b.n	c0d014d0 <crypto_fillAddress+0x4c>
c0d01492:	4615      	mov	r5, r2
c0d01494:	460e      	mov	r6, r1
c0d01496:	4607      	mov	r7, r0
c0d01498:	9300      	str	r3, [sp, #0]
        return 0;
    }
    MEMZERO(buffer, bufferLen);
c0d0149a:	4608      	mov	r0, r1
c0d0149c:	4611      	mov	r1, r2
c0d0149e:	f005 ff49 	bl	c0d07334 <explicit_bzero>
    CHECK_ZXERR(crypto_extractPublicKey(addressKind, hdPath, buffer, bufferLen));
c0d014a2:	490f      	ldr	r1, [pc, #60]	; (c0d014e0 <crypto_fillAddress+0x5c>)
c0d014a4:	4638      	mov	r0, r7
c0d014a6:	4632      	mov	r2, r6
c0d014a8:	462b      	mov	r3, r5
c0d014aa:	f7ff fee9 	bl	c0d01280 <crypto_extractPublicKey>
c0d014ae:	2803      	cmp	r0, #3
c0d014b0:	d10e      	bne.n	c0d014d0 <crypto_fillAddress+0x4c>

    size_t outLen = crypto_SS58EncodePubkey(buffer + PK_LEN_25519,
c0d014b2:	4630      	mov	r0, r6
c0d014b4:	3020      	adds	r0, #32
                                            bufferLen - PK_LEN_25519,
c0d014b6:	4629      	mov	r1, r5
c0d014b8:	3920      	subs	r1, #32
    size_t outLen = crypto_SS58EncodePubkey(buffer + PK_LEN_25519,
c0d014ba:	b289      	uxth	r1, r1
c0d014bc:	2216      	movs	r2, #22
c0d014be:	4633      	mov	r3, r6
c0d014c0:	f000 f842 	bl	c0d01548 <crypto_SS58EncodePubkey>
                                            PK_ADDRESS_TYPE, buffer);
    if (outLen == 0) {
c0d014c4:	2800      	cmp	r0, #0
c0d014c6:	d005      	beq.n	c0d014d4 <crypto_fillAddress+0x50>
        MEMZERO(buffer, bufferLen);
        return zxerr_unknown;
    }

    *addrResponseLen = PK_LEN_25519 + outLen;
c0d014c8:	3020      	adds	r0, #32
c0d014ca:	9900      	ldr	r1, [sp, #0]
c0d014cc:	8008      	strh	r0, [r1, #0]
c0d014ce:	2003      	movs	r0, #3
    return zxerr_ok;
}
c0d014d0:	b001      	add	sp, #4
c0d014d2:	bdf0      	pop	{r4, r5, r6, r7, pc}
        MEMZERO(buffer, bufferLen);
c0d014d4:	4630      	mov	r0, r6
c0d014d6:	4629      	mov	r1, r5
c0d014d8:	f005 ff2c 	bl	c0d07334 <explicit_bzero>
c0d014dc:	e7d7      	b.n	c0d0148e <crypto_fillAddress+0xa>
c0d014de:	46c0      	nop			; (mov r8, r8)
c0d014e0:	2000029c 	.word	0x2000029c

c0d014e4 <ss58hash>:

#if defined(TARGET_NANOS) || defined(TARGET_NANOX) || defined(TARGET_NANOS2)
#include "cx.h"

int ss58hash(const unsigned char *in, unsigned int inLen,
                   unsigned char *out, unsigned int outLen) {
c0d014e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d014e6:	b0c5      	sub	sp, #276	; 0x114
c0d014e8:	461f      	mov	r7, r3
c0d014ea:	9203      	str	r2, [sp, #12]
c0d014ec:	460d      	mov	r5, r1
c0d014ee:	4606      	mov	r6, r0
c0d014f0:	2001      	movs	r0, #1
c0d014f2:	0241      	lsls	r1, r0, #9
c0d014f4:	a804      	add	r0, sp, #16
c0d014f6:	f000 f857 	bl	c0d015a8 <cx_blake2b_init_no_throw>
c0d014fa:	2800      	cmp	r0, #0
c0d014fc:	d11f      	bne.n	c0d0153e <ss58hash+0x5a>
c0d014fe:	2100      	movs	r1, #0
  CX_THROW(cx_hash_no_throw(hash, mode, in, len, out, out_len));
c0d01500:	9100      	str	r1, [sp, #0]
c0d01502:	9101      	str	r1, [sp, #4]
c0d01504:	a804      	add	r0, sp, #16
c0d01506:	4a0f      	ldr	r2, [pc, #60]	; (c0d01544 <ss58hash+0x60>)
c0d01508:	447a      	add	r2, pc
c0d0150a:	2307      	movs	r3, #7
c0d0150c:	f000 f870 	bl	c0d015f0 <cx_hash_no_throw>
c0d01510:	2800      	cmp	r0, #0
c0d01512:	d114      	bne.n	c0d0153e <ss58hash+0x5a>
c0d01514:	ac04      	add	r4, sp, #16
  return cx_hash_get_size(hash);
c0d01516:	4620      	mov	r0, r4
c0d01518:	f000 f864 	bl	c0d015e4 <cx_hash_get_size>
  CX_THROW(cx_hash_no_throw(hash, mode, in, len, out, out_len));
c0d0151c:	9803      	ldr	r0, [sp, #12]
c0d0151e:	9000      	str	r0, [sp, #0]
c0d01520:	9701      	str	r7, [sp, #4]
c0d01522:	2101      	movs	r1, #1
c0d01524:	4620      	mov	r0, r4
c0d01526:	4632      	mov	r2, r6
c0d01528:	462b      	mov	r3, r5
c0d0152a:	f000 f861 	bl	c0d015f0 <cx_hash_no_throw>
c0d0152e:	2800      	cmp	r0, #0
c0d01530:	d105      	bne.n	c0d0153e <ss58hash+0x5a>
c0d01532:	a804      	add	r0, sp, #16
  return cx_hash_get_size(hash);
c0d01534:	f000 f856 	bl	c0d015e4 <cx_hash_get_size>
c0d01538:	2000      	movs	r0, #0
    cx_blake2b_t ctx;
    cx_blake2b_init(&ctx, 512);
    cx_hash(&ctx.header, 0, SS58_BLAKE_PREFIX, SS58_BLAKE_PREFIX_LEN, NULL, 0);
    cx_hash(&ctx.header, CX_LAST, in, inLen, out, outLen);

    return 0;
c0d0153a:	b045      	add	sp, #276	; 0x114
c0d0153c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0153e:	f000 f872 	bl	c0d01626 <os_longjmp>
c0d01542:	46c0      	nop			; (mov r8, r8)
c0d01544:	000062dc 	.word	0x000062dc

c0d01548 <crypto_SS58EncodePubkey>:
}

#endif

uint8_t crypto_SS58EncodePubkey(uint8_t *buffer, uint16_t buffer_len,
                                uint8_t addressType, const uint8_t *pubkey) {
c0d01548:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0154a:	b09d      	sub	sp, #116	; 0x74
c0d0154c:	460d      	mov	r5, r1
c0d0154e:	ac14      	add	r4, sp, #80	; 0x50
c0d01550:	2100      	movs	r1, #0
    if (buffer == NULL || buffer_len < SS58_ADDRESS_MAX_LEN) {
c0d01552:	2800      	cmp	r0, #0
c0d01554:	d025      	beq.n	c0d015a2 <crypto_SS58EncodePubkey+0x5a>
c0d01556:	2d3c      	cmp	r5, #60	; 0x3c
c0d01558:	d323      	bcc.n	c0d015a2 <crypto_SS58EncodePubkey+0x5a>
c0d0155a:	461e      	mov	r6, r3
c0d0155c:	2b00      	cmp	r3, #0
c0d0155e:	d020      	beq.n	c0d015a2 <crypto_SS58EncodePubkey+0x5a>
c0d01560:	3421      	adds	r4, #33	; 0x21
        return 0;
    }
    if (pubkey == NULL) {
        return 0;
    }
    MEMZERO(buffer, buffer_len);
c0d01562:	4629      	mov	r1, r5
c0d01564:	9002      	str	r0, [sp, #8]
c0d01566:	9201      	str	r2, [sp, #4]
c0d01568:	f005 fee4 	bl	c0d07334 <explicit_bzero>
c0d0156c:	af14      	add	r7, sp, #80	; 0x50

    uint8_t unencoded[35];
    uint8_t hash[64];

    unencoded[0] = addressType;                  // address type
c0d0156e:	9801      	ldr	r0, [sp, #4]
c0d01570:	7038      	strb	r0, [r7, #0]
    MEMCPY(unencoded + 1, pubkey, 32);           // account id
c0d01572:	1c78      	adds	r0, r7, #1
c0d01574:	2220      	movs	r2, #32
c0d01576:	4631      	mov	r1, r6
c0d01578:	f005 fecc 	bl	c0d07314 <__aeabi_memcpy>
c0d0157c:	2121      	movs	r1, #33	; 0x21
c0d0157e:	ae04      	add	r6, sp, #16
c0d01580:	2340      	movs	r3, #64	; 0x40
    ss58hash((uint8_t *) unencoded, 33, hash, 64);
c0d01582:	4638      	mov	r0, r7
c0d01584:	4632      	mov	r2, r6
c0d01586:	f7ff ffad 	bl	c0d014e4 <ss58hash>
    unencoded[33] = hash[0];
c0d0158a:	9804      	ldr	r0, [sp, #16]
c0d0158c:	7020      	strb	r0, [r4, #0]
    unencoded[34] = hash[1];
c0d0158e:	7870      	ldrb	r0, [r6, #1]
c0d01590:	7060      	strb	r0, [r4, #1]

    size_t outLen = buffer_len;
c0d01592:	9503      	str	r5, [sp, #12]
c0d01594:	2123      	movs	r1, #35	; 0x23
c0d01596:	ab03      	add	r3, sp, #12
    encode_base58(unencoded, 35, buffer, &outLen);
c0d01598:	4638      	mov	r0, r7
c0d0159a:	9a02      	ldr	r2, [sp, #8]
c0d0159c:	f7ff fbe2 	bl	c0d00d64 <encode_base58>

    return outLen;
c0d015a0:	9903      	ldr	r1, [sp, #12]
}
c0d015a2:	b2c8      	uxtb	r0, r1
c0d015a4:	b01d      	add	sp, #116	; 0x74
c0d015a6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d015a8 <cx_blake2b_init_no_throw>:
CX_TRAMPOLINE _NR_cx_aes_no_throw                          cx_aes_no_throw
CX_TRAMPOLINE _NR_cx_blake2b                               cx_blake2b
CX_TRAMPOLINE _NR_cx_blake2b_final                         cx_blake2b_final
CX_TRAMPOLINE _NR_cx_blake2b_get_output_size               cx_blake2b_get_output_size
CX_TRAMPOLINE _NR_cx_blake2b_init2_no_throw                cx_blake2b_init2_no_throw
CX_TRAMPOLINE _NR_cx_blake2b_init_no_throw                 cx_blake2b_init_no_throw
c0d015a8:	b403      	push	{r0, r1}
c0d015aa:	4801      	ldr	r0, [pc, #4]	; (c0d015b0 <cx_blake2b_init_no_throw+0x8>)
c0d015ac:	e02f      	b.n	c0d0160e <cx_trampoline_helper>
c0d015ae:	0000      	.short	0x0000
c0d015b0:	00000009 	.word	0x00000009

c0d015b4 <cx_ecfp_generate_pair_no_throw>:
CX_TRAMPOLINE _NR_cx_ecdsa_verify_no_throw                 cx_ecdsa_verify_no_throw
CX_TRAMPOLINE _NR_cx_ecfp_add_point_no_throw               cx_ecfp_add_point_no_throw
CX_TRAMPOLINE _NR_cx_ecfp_decode_sig_der                   cx_ecfp_decode_sig_der
CX_TRAMPOLINE _NR_cx_ecfp_encode_sig_der                   cx_ecfp_encode_sig_der
CX_TRAMPOLINE _NR_cx_ecfp_generate_pair2_no_throw          cx_ecfp_generate_pair2_no_throw
CX_TRAMPOLINE _NR_cx_ecfp_generate_pair_no_throw           cx_ecfp_generate_pair_no_throw
c0d015b4:	b403      	push	{r0, r1}
c0d015b6:	4801      	ldr	r0, [pc, #4]	; (c0d015bc <cx_ecfp_generate_pair_no_throw+0x8>)
c0d015b8:	e029      	b.n	c0d0160e <cx_trampoline_helper>
c0d015ba:	0000      	.short	0x0000
c0d015bc:	0000001b 	.word	0x0000001b

c0d015c0 <cx_ecfp_init_private_key_no_throw>:
CX_TRAMPOLINE _NR_cx_ecfp_init_private_key_no_throw        cx_ecfp_init_private_key_no_throw
c0d015c0:	b403      	push	{r0, r1}
c0d015c2:	4801      	ldr	r0, [pc, #4]	; (c0d015c8 <cx_ecfp_init_private_key_no_throw+0x8>)
c0d015c4:	e023      	b.n	c0d0160e <cx_trampoline_helper>
c0d015c6:	0000      	.short	0x0000
c0d015c8:	0000001c 	.word	0x0000001c

c0d015cc <cx_ecfp_init_public_key_no_throw>:
CX_TRAMPOLINE _NR_cx_ecfp_init_public_key_no_throw         cx_ecfp_init_public_key_no_throw
c0d015cc:	b403      	push	{r0, r1}
c0d015ce:	4801      	ldr	r0, [pc, #4]	; (c0d015d4 <cx_ecfp_init_public_key_no_throw+0x8>)
c0d015d0:	e01d      	b.n	c0d0160e <cx_trampoline_helper>
c0d015d2:	0000      	.short	0x0000
c0d015d4:	0000001d 	.word	0x0000001d

c0d015d8 <cx_eddsa_sign_no_throw>:
CX_TRAMPOLINE _NR_cx_ecfp_scalar_mult_no_throw             cx_ecfp_scalar_mult_no_throw
CX_TRAMPOLINE _NR_cx_ecschnorr_sign_no_throw               cx_ecschnorr_sign_no_throw
CX_TRAMPOLINE _NR_cx_ecschnorr_verify                      cx_ecschnorr_verify
CX_TRAMPOLINE _NR_cx_eddsa_get_public_key_internal         cx_eddsa_get_public_key_internal
CX_TRAMPOLINE _NR_cx_eddsa_get_public_key_no_throw         cx_eddsa_get_public_key_no_throw
CX_TRAMPOLINE _NR_cx_eddsa_sign_no_throw                   cx_eddsa_sign_no_throw
c0d015d8:	b403      	push	{r0, r1}
c0d015da:	4801      	ldr	r0, [pc, #4]	; (c0d015e0 <cx_eddsa_sign_no_throw+0x8>)
c0d015dc:	e017      	b.n	c0d0160e <cx_trampoline_helper>
c0d015de:	0000      	.short	0x0000
c0d015e0:	00000023 	.word	0x00000023

c0d015e4 <cx_hash_get_size>:
CX_TRAMPOLINE _NR_cx_groestl_get_output_size               cx_groestl_get_output_size
CX_TRAMPOLINE _NR_cx_groestl_init_no_throw                 cx_groestl_init_no_throw
CX_TRAMPOLINE _NR_cx_groestl_update                        cx_groestl_update
CX_TRAMPOLINE _NR_cx_hash_final                            cx_hash_final
CX_TRAMPOLINE _NR_cx_hash_get_info                         cx_hash_get_info
CX_TRAMPOLINE _NR_cx_hash_get_size                         cx_hash_get_size
c0d015e4:	b403      	push	{r0, r1}
c0d015e6:	4801      	ldr	r0, [pc, #4]	; (c0d015ec <cx_hash_get_size+0x8>)
c0d015e8:	e011      	b.n	c0d0160e <cx_trampoline_helper>
c0d015ea:	0000      	.short	0x0000
c0d015ec:	0000002f 	.word	0x0000002f

c0d015f0 <cx_hash_no_throw>:
CX_TRAMPOLINE _NR_cx_hash_init                             cx_hash_init
CX_TRAMPOLINE _NR_cx_hash_init_ex                          cx_hash_init_ex
CX_TRAMPOLINE _NR_cx_hash_no_throw                         cx_hash_no_throw
c0d015f0:	b403      	push	{r0, r1}
c0d015f2:	4801      	ldr	r0, [pc, #4]	; (c0d015f8 <cx_hash_no_throw+0x8>)
c0d015f4:	e00b      	b.n	c0d0160e <cx_trampoline_helper>
c0d015f6:	0000      	.short	0x0000
c0d015f8:	00000032 	.word	0x00000032

c0d015fc <cx_rng_no_throw>:
CX_TRAMPOLINE _NR_cx_pbkdf2_hmac                           cx_pbkdf2_hmac
CX_TRAMPOLINE _NR_cx_pbkdf2_no_throw                       cx_pbkdf2_no_throw
CX_TRAMPOLINE _NR_cx_ripemd160_final                       cx_ripemd160_final
CX_TRAMPOLINE _NR_cx_ripemd160_init_no_throw               cx_ripemd160_init_no_throw
CX_TRAMPOLINE _NR_cx_ripemd160_update                      cx_ripemd160_update
CX_TRAMPOLINE _NR_cx_rng_no_throw                          cx_rng_no_throw
c0d015fc:	b403      	push	{r0, r1}
c0d015fe:	4801      	ldr	r0, [pc, #4]	; (c0d01604 <cx_rng_no_throw+0x8>)
c0d01600:	e005      	b.n	c0d0160e <cx_trampoline_helper>
c0d01602:	0000      	.short	0x0000
c0d01604:	00000058 	.word	0x00000058

c0d01608 <cx_x448>:
CX_TRAMPOLINE _NR_cx_swap_buffer32                         cx_swap_buffer32
CX_TRAMPOLINE _NR_cx_swap_buffer64                         cx_swap_buffer64
CX_TRAMPOLINE _NR_cx_swap_uint32                           cx_swap_uint32
CX_TRAMPOLINE _NR_cx_swap_uint64                           cx_swap_uint64
CX_TRAMPOLINE _NR_cx_x25519                                cx_x25519
CX_TRAMPOLINE _NR_cx_x448                                  cx_x448
c0d01608:	b403      	push	{r0, r1}
c0d0160a:	4802      	ldr	r0, [pc, #8]	; (c0d01614 <cx_trampoline_helper+0x6>)
c0d0160c:	e7ff      	b.n	c0d0160e <cx_trampoline_helper>

c0d0160e <cx_trampoline_helper>:

.thumb_func
cx_trampoline_helper:
  ldr  r1, =CX_TRAMPOLINE_ADDR // _cx_trampoline address
c0d0160e:	4902      	ldr	r1, [pc, #8]	; (c0d01618 <cx_trampoline_helper+0xa>)
  bx   r1
c0d01610:	4708      	bx	r1
c0d01612:	0000      	.short	0x0000
CX_TRAMPOLINE _NR_cx_x448                                  cx_x448
c0d01614:	00000071 	.word	0x00000071
  ldr  r1, =CX_TRAMPOLINE_ADDR // _cx_trampoline address
c0d01618:	00120001 	.word	0x00120001

c0d0161c <os_boot>:

// apdu buffer must hold a complete apdu to avoid troubles
unsigned char G_io_apdu_buffer[IO_APDU_BUFFER_SIZE];

#ifndef BOLOS_OS_UPGRADER_APP
void os_boot(void) {
c0d0161c:	b580      	push	{r7, lr}
c0d0161e:	2000      	movs	r0, #0
  // // TODO patch entry point when romming (f)
  // // set the default try context to nothing
#ifndef HAVE_BOLOS
  try_context_set(NULL);
c0d01620:	f003 fc5e 	bl	c0d04ee0 <try_context_set>
#endif // HAVE_BOLOS
}
c0d01624:	bd80      	pop	{r7, pc}

c0d01626 <os_longjmp>:
  }
  return xoracc;
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0d01626:	4604      	mov	r4, r0
#ifdef HAVE_PRINTF  
  unsigned int lr_val;
  __asm volatile("mov %0, lr" :"=r"(lr_val));
  PRINTF("exception[%d]: LR=0x%08X\n", exception, lr_val);
#endif // HAVE_PRINTF
  longjmp(try_context_get()->jmp_buf, exception);
c0d01628:	f003 fc4e 	bl	c0d04ec8 <try_context_get>
c0d0162c:	4621      	mov	r1, r4
c0d0162e:	f005 ffb1 	bl	c0d07594 <longjmp>

c0d01632 <os_secure_memcmp>:
char os_secure_memcmp(void * src1, void * src2, unsigned int length) {
c0d01632:	b5b0      	push	{r4, r5, r7, lr}
c0d01634:	b082      	sub	sp, #8
c0d01636:	9201      	str	r2, [sp, #4]
c0d01638:	9200      	str	r2, [sp, #0]
  while(!(!length && !l)) {
c0d0163a:	2a00      	cmp	r2, #0
c0d0163c:	d00c      	beq.n	c0d01658 <os_secure_memcmp+0x26>
c0d0163e:	1e43      	subs	r3, r0, #1
c0d01640:	1e49      	subs	r1, r1, #1
c0d01642:	2000      	movs	r0, #0
    xoracc |= SRC1[length] ^ SRC2[length];
c0d01644:	5c9c      	ldrb	r4, [r3, r2]
c0d01646:	5c8d      	ldrb	r5, [r1, r2]
c0d01648:	4065      	eors	r5, r4
c0d0164a:	4328      	orrs	r0, r5
    length--;
c0d0164c:	1e52      	subs	r2, r2, #1
  while(!(!length && !l)) {
c0d0164e:	d1f9      	bne.n	c0d01644 <os_secure_memcmp+0x12>
c0d01650:	2100      	movs	r1, #0
c0d01652:	9100      	str	r1, [sp, #0]
c0d01654:	9101      	str	r1, [sp, #4]
c0d01656:	e000      	b.n	c0d0165a <os_secure_memcmp+0x28>
c0d01658:	2000      	movs	r0, #0
  if (*(volatile unsigned int*)&l!=*(volatile unsigned int*)&length) {
c0d0165a:	9900      	ldr	r1, [sp, #0]
c0d0165c:	9a01      	ldr	r2, [sp, #4]
c0d0165e:	4291      	cmp	r1, r2
c0d01660:	d102      	bne.n	c0d01668 <os_secure_memcmp+0x36>
  return xoracc;
c0d01662:	b2c0      	uxtb	r0, r0
c0d01664:	b002      	add	sp, #8
c0d01666:	bdb0      	pop	{r4, r5, r7, pc}
c0d01668:	2001      	movs	r0, #1
    THROW(EXCEPTION);
c0d0166a:	f7ff ffdc 	bl	c0d01626 <os_longjmp>
	...

c0d01670 <os_parse_bertlv>:
// <tag> <length> <value>
// tag: 1 byte only
// length: 1 byte if little than 0x80, else 1 byte of length encoding (0x8Y, with Y the number of following bytes the length is encoded on) and then Y bytes of BE encoded total length
// value: no encoding, raw data
unsigned int os_parse_bertlv(unsigned char* mem, unsigned int mem_len, 
                             unsigned int * tlvoffset, unsigned int tag, unsigned int offset, void** buffer, unsigned int maxlength) {
c0d01670:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01672:	b089      	sub	sp, #36	; 0x24
c0d01674:	2500      	movs	r5, #0
  unsigned int check_equals_buffer = offset & OS_PARSE_BERTLV_OFFSET_COMPARE_WITH_BUFFER;
  unsigned int get_address = offset & OS_PARSE_BERTLV_OFFSET_GET_LENGTH;
  offset &= ~(OS_PARSE_BERTLV_OFFSET_COMPARE_WITH_BUFFER|OS_PARSE_BERTLV_OFFSET_GET_LENGTH);

  // nothing to be read
  if (mem_len == 0 || buffer == NULL || (!get_address && *buffer == NULL)) {
c0d01676:	2900      	cmp	r1, #0
c0d01678:	d100      	bne.n	c0d0167c <os_parse_bertlv+0xc>
c0d0167a:	e088      	b.n	c0d0178e <os_parse_bertlv+0x11e>
c0d0167c:	9c0f      	ldr	r4, [sp, #60]	; 0x3c
c0d0167e:	2c00      	cmp	r4, #0
c0d01680:	d100      	bne.n	c0d01684 <os_parse_bertlv+0x14>
c0d01682:	e084      	b.n	c0d0178e <os_parse_bertlv+0x11e>
c0d01684:	9008      	str	r0, [sp, #32]
c0d01686:	9404      	str	r4, [sp, #16]
c0d01688:	4c4b      	ldr	r4, [pc, #300]	; (c0d017b8 <os_parse_bertlv+0x148>)
c0d0168a:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0168c:	9407      	str	r4, [sp, #28]
  unsigned int get_address = offset & OS_PARSE_BERTLV_OFFSET_GET_LENGTH;
c0d0168e:	1c64      	adds	r4, r4, #1
c0d01690:	9005      	str	r0, [sp, #20]
c0d01692:	4004      	ands	r4, r0
c0d01694:	9402      	str	r4, [sp, #8]
  if (mem_len == 0 || buffer == NULL || (!get_address && *buffer == NULL)) {
c0d01696:	d103      	bne.n	c0d016a0 <os_parse_bertlv+0x30>
c0d01698:	9804      	ldr	r0, [sp, #16]
c0d0169a:	6800      	ldr	r0, [r0, #0]
c0d0169c:	2800      	cmp	r0, #0
c0d0169e:	d076      	beq.n	c0d0178e <os_parse_bertlv+0x11e>
c0d016a0:	2500      	movs	r5, #0
  unsigned int remlen = mem_len;
  ret = 0;

  // account for a shift in the tlv list before parsing
  tlvoffset_in = 0;
  if (tlvoffset) {
c0d016a2:	2a00      	cmp	r2, #0
c0d016a4:	4628      	mov	r0, r5
c0d016a6:	d000      	beq.n	c0d016aa <os_parse_bertlv+0x3a>
    tlvoffset_in = *tlvoffset;
c0d016a8:	6810      	ldr	r0, [r2, #0]
  }

  // parse tlv until some tag to parse
  while(remlen>=2) {
c0d016aa:	2902      	cmp	r1, #2
c0d016ac:	9c08      	ldr	r4, [sp, #32]
c0d016ae:	d36e      	bcc.n	c0d0178e <os_parse_bertlv+0x11e>
c0d016b0:	9003      	str	r0, [sp, #12]
c0d016b2:	9501      	str	r5, [sp, #4]
c0d016b4:	9805      	ldr	r0, [sp, #20]
c0d016b6:	9d07      	ldr	r5, [sp, #28]
c0d016b8:	4005      	ands	r5, r0
c0d016ba:	9507      	str	r5, [sp, #28]
c0d016bc:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d016be:	9000      	str	r0, [sp, #0]
c0d016c0:	b2d8      	uxtb	r0, r3
c0d016c2:	9006      	str	r0, [sp, #24]
c0d016c4:	460e      	mov	r6, r1
    // tag matches
    unsigned int tlvtag = *tlv++;
    remlen--;
    unsigned int tlvlen = *tlv++;
    remlen--;
c0d016c6:	1eb0      	subs	r0, r6, #2
    if (remlen == 0) {
c0d016c8:	d060      	beq.n	c0d0178c <os_parse_bertlv+0x11c>
c0d016ca:	1ca3      	adds	r3, r4, #2
c0d016cc:	7825      	ldrb	r5, [r4, #0]
c0d016ce:	7864      	ldrb	r4, [r4, #1]
c0d016d0:	b266      	sxtb	r6, r4
      goto retret; 
    }
    if (tlvlen >= 0x80) {
c0d016d2:	2e00      	cmp	r6, #0
c0d016d4:	d510      	bpl.n	c0d016f8 <os_parse_bertlv+0x88>
      // invalid encoding
      if (tlvlen == 0x80) {
c0d016d6:	3680      	adds	r6, #128	; 0x80
c0d016d8:	d058      	beq.n	c0d0178c <os_parse_bertlv+0x11c>
c0d016da:	267f      	movs	r6, #127	; 0x7f
        goto retret; 
      }
      unsigned int tlvlenlen_ = tlvlen & 0x7F;
c0d016dc:	4034      	ands	r4, r6
c0d016de:	2600      	movs	r6, #0
      tlvlen = 0;
      while(tlvlenlen_--) {
c0d016e0:	2c00      	cmp	r4, #0
c0d016e2:	d008      	beq.n	c0d016f6 <os_parse_bertlv+0x86>
        // BE encoded
        tlvlen = (tlvlen << 8) | ((*tlv++)&0xFF);
c0d016e4:	781f      	ldrb	r7, [r3, #0]
c0d016e6:	0236      	lsls	r6, r6, #8
c0d016e8:	19f6      	adds	r6, r6, r7
        remlen--;
c0d016ea:	1e40      	subs	r0, r0, #1
        tlvlen = (tlvlen << 8) | ((*tlv++)&0xFF);
c0d016ec:	1c5b      	adds	r3, r3, #1
      while(tlvlenlen_--) {
c0d016ee:	1e64      	subs	r4, r4, #1
        if (remlen == 0) {
c0d016f0:	2800      	cmp	r0, #0
c0d016f2:	d1f5      	bne.n	c0d016e0 <os_parse_bertlv+0x70>
c0d016f4:	e014      	b.n	c0d01720 <os_parse_bertlv+0xb0>
c0d016f6:	4634      	mov	r4, r6
          goto retret; 
        }
      }
    }
    // check if tag matches
    if (tlvtag == (tag&0xFF)) {
c0d016f8:	9e06      	ldr	r6, [sp, #24]
c0d016fa:	42b5      	cmp	r5, r6
c0d016fc:	d107      	bne.n	c0d0170e <os_parse_bertlv+0x9e>
      if (tlvoffset) {
c0d016fe:	2a00      	cmp	r2, #0
c0d01700:	d010      	beq.n	c0d01724 <os_parse_bertlv+0xb4>
        unsigned int o = (unsigned int) tlv - (unsigned int)mem;
c0d01702:	9d08      	ldr	r5, [sp, #32]
c0d01704:	1b5d      	subs	r5, r3, r5
        // compute the current position in the tlv bytes
        *tlvoffset = o;
c0d01706:	6015      	str	r5, [r2, #0]
c0d01708:	9e03      	ldr	r6, [sp, #12]
c0d0170a:	42ae      	cmp	r6, r5
c0d0170c:	d90a      	bls.n	c0d01724 <os_parse_bertlv+0xb4>
      goto retret;
    }
  next_tlv:
    // skip to next tlv
    tlv += tlvlen;
    remlen-=MIN(remlen, tlvlen);
c0d0170e:	1b06      	subs	r6, r0, r4
c0d01710:	2500      	movs	r5, #0
c0d01712:	42a0      	cmp	r0, r4
c0d01714:	d200      	bcs.n	c0d01718 <os_parse_bertlv+0xa8>
c0d01716:	462e      	mov	r6, r5
    tlv += tlvlen;
c0d01718:	191c      	adds	r4, r3, r4
  while(remlen>=2) {
c0d0171a:	2e01      	cmp	r6, #1
c0d0171c:	d8d3      	bhi.n	c0d016c6 <os_parse_bertlv+0x56>
c0d0171e:	e036      	b.n	c0d0178e <os_parse_bertlv+0x11e>
c0d01720:	2500      	movs	r5, #0
c0d01722:	e034      	b.n	c0d0178e <os_parse_bertlv+0x11e>
c0d01724:	9a07      	ldr	r2, [sp, #28]
      if (offset > tlvlen || offset > remlen) {
c0d01726:	4282      	cmp	r2, r0
c0d01728:	d830      	bhi.n	c0d0178c <os_parse_bertlv+0x11c>
c0d0172a:	4294      	cmp	r4, r2
c0d0172c:	9d01      	ldr	r5, [sp, #4]
c0d0172e:	d32e      	bcc.n	c0d0178e <os_parse_bertlv+0x11e>
c0d01730:	1aa2      	subs	r2, r4, r2
      if (check_equals_buffer && (tlvlen-offset) != maxlength) {
c0d01732:	9c05      	ldr	r4, [sp, #20]
c0d01734:	2c00      	cmp	r4, #0
c0d01736:	9e00      	ldr	r6, [sp, #0]
c0d01738:	d501      	bpl.n	c0d0173e <os_parse_bertlv+0xce>
c0d0173a:	42b2      	cmp	r2, r6
c0d0173c:	d127      	bne.n	c0d0178e <os_parse_bertlv+0x11e>
      maxlength = MIN(maxlength, MIN(tlvlen-offset, remlen));
c0d0173e:	4282      	cmp	r2, r0
c0d01740:	d300      	bcc.n	c0d01744 <os_parse_bertlv+0xd4>
c0d01742:	4602      	mov	r2, r0
c0d01744:	42b2      	cmp	r2, r6
c0d01746:	9c08      	ldr	r4, [sp, #32]
c0d01748:	d800      	bhi.n	c0d0174c <os_parse_bertlv+0xdc>
c0d0174a:	4616      	mov	r6, r2
        || maxlength > mem_len
c0d0174c:	9807      	ldr	r0, [sp, #28]
c0d0174e:	4288      	cmp	r0, r1
c0d01750:	d81d      	bhi.n	c0d0178e <os_parse_bertlv+0x11e>
c0d01752:	428e      	cmp	r6, r1
c0d01754:	d81b      	bhi.n	c0d0178e <os_parse_bertlv+0x11e>
c0d01756:	9f07      	ldr	r7, [sp, #28]
c0d01758:	19f0      	adds	r0, r6, r7
c0d0175a:	4288      	cmp	r0, r1
c0d0175c:	d817      	bhi.n	c0d0178e <os_parse_bertlv+0x11e>
c0d0175e:	1864      	adds	r4, r4, r1
c0d01760:	18f9      	adds	r1, r7, r3
c0d01762:	1870      	adds	r0, r6, r1
        || (unsigned int)tlv+offset < (unsigned int)mem 
c0d01764:	42a0      	cmp	r0, r4
c0d01766:	d812      	bhi.n	c0d0178e <os_parse_bertlv+0x11e>
c0d01768:	42a1      	cmp	r1, r4
c0d0176a:	d810      	bhi.n	c0d0178e <os_parse_bertlv+0x11e>
c0d0176c:	429c      	cmp	r4, r3
c0d0176e:	d30e      	bcc.n	c0d0178e <os_parse_bertlv+0x11e>
c0d01770:	9c08      	ldr	r4, [sp, #32]
c0d01772:	42a3      	cmp	r3, r4
c0d01774:	d30b      	bcc.n	c0d0178e <os_parse_bertlv+0x11e>
c0d01776:	42a1      	cmp	r1, r4
c0d01778:	d309      	bcc.n	c0d0178e <os_parse_bertlv+0x11e>
c0d0177a:	42a0      	cmp	r0, r4
c0d0177c:	d307      	bcc.n	c0d0178e <os_parse_bertlv+0x11e>
      if (get_address) {
c0d0177e:	9802      	ldr	r0, [sp, #8]
c0d01780:	2800      	cmp	r0, #0
c0d01782:	d007      	beq.n	c0d01794 <os_parse_bertlv+0x124>
        *buffer = tlv+offset;
c0d01784:	9804      	ldr	r0, [sp, #16]
c0d01786:	6001      	str	r1, [r0, #0]
c0d01788:	4615      	mov	r5, r2
c0d0178a:	e000      	b.n	c0d0178e <os_parse_bertlv+0x11e>
c0d0178c:	9d01      	ldr	r5, [sp, #4]
  }
retret:
  return ret;
}
c0d0178e:	4628      	mov	r0, r5
c0d01790:	b009      	add	sp, #36	; 0x24
c0d01792:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01794:	4633      	mov	r3, r6
c0d01796:	9804      	ldr	r0, [sp, #16]
c0d01798:	6800      	ldr	r0, [r0, #0]
      if (!check_equals_buffer) {
c0d0179a:	9a05      	ldr	r2, [sp, #20]
c0d0179c:	2a00      	cmp	r2, #0
c0d0179e:	d404      	bmi.n	c0d017aa <os_parse_bertlv+0x13a>
c0d017a0:	461d      	mov	r5, r3
        memmove(*buffer, tlv+offset, maxlength);
c0d017a2:	461a      	mov	r2, r3
c0d017a4:	f005 fdba 	bl	c0d0731c <__aeabi_memmove>
c0d017a8:	e7f1      	b.n	c0d0178e <os_parse_bertlv+0x11e>
        ret = os_secure_memcmp(*buffer, tlv+offset, maxlength) == 0;
c0d017aa:	461a      	mov	r2, r3
c0d017ac:	f7ff ff41 	bl	c0d01632 <os_secure_memcmp>
c0d017b0:	4245      	negs	r5, r0
c0d017b2:	4145      	adcs	r5, r0
c0d017b4:	e7eb      	b.n	c0d0178e <os_parse_bertlv+0x11e>
c0d017b6:	46c0      	nop			; (mov r8, r8)
c0d017b8:	3fffffff 	.word	0x3fffffff

c0d017bc <io_seproxyhal_general_status>:
  0,
  2,
  SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8,
  SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND,
};
void io_seproxyhal_general_status(void) {
c0d017bc:	b580      	push	{r7, lr}
  // send the general status
  io_seproxyhal_spi_send(seph_io_general_status, sizeof(seph_io_general_status));
c0d017be:	4803      	ldr	r0, [pc, #12]	; (c0d017cc <io_seproxyhal_general_status+0x10>)
c0d017c0:	4478      	add	r0, pc
c0d017c2:	2105      	movs	r1, #5
c0d017c4:	f003 fb5a 	bl	c0d04e7c <io_seph_send>
}
c0d017c8:	bd80      	pop	{r7, pc}
c0d017ca:	46c0      	nop			; (mov r8, r8)
c0d017cc:	000060a0 	.word	0x000060a0

c0d017d0 <io_seproxyhal_handle_usb_event>:
}

#ifdef HAVE_IO_USB
#ifdef HAVE_L4_USBLIB

void io_seproxyhal_handle_usb_event(void) {
c0d017d0:	b510      	push	{r4, lr}
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d017d2:	4818      	ldr	r0, [pc, #96]	; (c0d01834 <io_seproxyhal_handle_usb_event+0x64>)
c0d017d4:	78c0      	ldrb	r0, [r0, #3]
c0d017d6:	2803      	cmp	r0, #3
c0d017d8:	dc07      	bgt.n	c0d017ea <io_seproxyhal_handle_usb_event+0x1a>
c0d017da:	2801      	cmp	r0, #1
c0d017dc:	d00d      	beq.n	c0d017fa <io_seproxyhal_handle_usb_event+0x2a>
c0d017de:	2802      	cmp	r0, #2
c0d017e0:	d123      	bne.n	c0d0182a <io_seproxyhal_handle_usb_event+0x5a>
      }
      memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
      memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d017e2:	4815      	ldr	r0, [pc, #84]	; (c0d01838 <io_seproxyhal_handle_usb_event+0x68>)
c0d017e4:	f003 fed8 	bl	c0d05598 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d017e8:	bd10      	pop	{r4, pc}
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d017ea:	2804      	cmp	r0, #4
c0d017ec:	d01a      	beq.n	c0d01824 <io_seproxyhal_handle_usb_event+0x54>
c0d017ee:	2808      	cmp	r0, #8
c0d017f0:	d11b      	bne.n	c0d0182a <io_seproxyhal_handle_usb_event+0x5a>
      USBD_LL_Resume(&USBD_Device);
c0d017f2:	4811      	ldr	r0, [pc, #68]	; (c0d01838 <io_seproxyhal_handle_usb_event+0x68>)
c0d017f4:	f003 fece 	bl	c0d05594 <USBD_LL_Resume>
}
c0d017f8:	bd10      	pop	{r4, pc}
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);
c0d017fa:	4c0f      	ldr	r4, [pc, #60]	; (c0d01838 <io_seproxyhal_handle_usb_event+0x68>)
c0d017fc:	2101      	movs	r1, #1
c0d017fe:	4620      	mov	r0, r4
c0d01800:	f003 fec3 	bl	c0d0558a <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d01804:	4620      	mov	r0, r4
c0d01806:	f003 fea0 	bl	c0d0554a <USBD_LL_Reset>
      if (G_io_app.apdu_media != IO_APDU_MEDIA_NONE) {
c0d0180a:	480c      	ldr	r0, [pc, #48]	; (c0d0183c <io_seproxyhal_handle_usb_event+0x6c>)
c0d0180c:	7981      	ldrb	r1, [r0, #6]
c0d0180e:	2900      	cmp	r1, #0
c0d01810:	d10c      	bne.n	c0d0182c <io_seproxyhal_handle_usb_event+0x5c>
c0d01812:	2100      	movs	r1, #0
      memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
c0d01814:	7481      	strb	r1, [r0, #18]
c0d01816:	8201      	strh	r1, [r0, #16]
c0d01818:	60c1      	str	r1, [r0, #12]
      memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d0181a:	6141      	str	r1, [r0, #20]
c0d0181c:	6181      	str	r1, [r0, #24]
c0d0181e:	61c1      	str	r1, [r0, #28]
c0d01820:	8401      	strh	r1, [r0, #32]
}
c0d01822:	bd10      	pop	{r4, pc}
      USBD_LL_Suspend(&USBD_Device);
c0d01824:	4804      	ldr	r0, [pc, #16]	; (c0d01838 <io_seproxyhal_handle_usb_event+0x68>)
c0d01826:	f003 feb3 	bl	c0d05590 <USBD_LL_Suspend>
}
c0d0182a:	bd10      	pop	{r4, pc}
c0d0182c:	2005      	movs	r0, #5
        THROW(EXCEPTION_IO_RESET);
c0d0182e:	f7ff fefa 	bl	c0d01626 <os_longjmp>
c0d01832:	46c0      	nop			; (mov r8, r8)
c0d01834:	20000202 	.word	0x20000202
c0d01838:	2000044c 	.word	0x2000044c
c0d0183c:	200003b4 	.word	0x200003b4

c0d01840 <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
c0d01840:	217f      	movs	r1, #127	; 0x7f
  if ((epnum & 0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d01842:	4001      	ands	r1, r0
c0d01844:	2906      	cmp	r1, #6
c0d01846:	d803      	bhi.n	c0d01850 <io_seproxyhal_get_ep_rx_size+0x10>
    return G_io_app.usb_ep_xfer_len[epnum&0x7F];
c0d01848:	4802      	ldr	r0, [pc, #8]	; (c0d01854 <io_seproxyhal_get_ep_rx_size+0x14>)
c0d0184a:	1840      	adds	r0, r0, r1
c0d0184c:	7b00      	ldrb	r0, [r0, #12]
  }
  return 0;
}
c0d0184e:	4770      	bx	lr
c0d01850:	2000      	movs	r0, #0
c0d01852:	4770      	bx	lr
c0d01854:	200003b4 	.word	0x200003b4

c0d01858 <io_seproxyhal_handle_usb_ep_xfer_event>:

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d01858:	b580      	push	{r7, lr}
  uint8_t epnum;

  epnum = G_io_seproxyhal_spi_buffer[3] & 0x7F;
c0d0185a:	4815      	ldr	r0, [pc, #84]	; (c0d018b0 <io_seproxyhal_handle_usb_ep_xfer_event+0x58>)
c0d0185c:	78c2      	ldrb	r2, [r0, #3]
c0d0185e:	217f      	movs	r1, #127	; 0x7f
c0d01860:	4011      	ands	r1, r2

  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d01862:	7902      	ldrb	r2, [r0, #4]
c0d01864:	2a04      	cmp	r2, #4
c0d01866:	d014      	beq.n	c0d01892 <io_seproxyhal_handle_usb_ep_xfer_event+0x3a>
c0d01868:	2a02      	cmp	r2, #2
c0d0186a:	d006      	beq.n	c0d0187a <io_seproxyhal_handle_usb_ep_xfer_event+0x22>
c0d0186c:	2a01      	cmp	r2, #1
c0d0186e:	d11d      	bne.n	c0d018ac <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
    /* This event is received when a new SETUP token had been received on a control endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d01870:	1d81      	adds	r1, r0, #6
c0d01872:	4811      	ldr	r0, [pc, #68]	; (c0d018b8 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d01874:	f003 fd74 	bl	c0d05360 <USBD_LL_SetupStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, epnum, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d01878:	bd80      	pop	{r7, pc}
      if (epnum < IO_USB_MAX_ENDPOINTS) {
c0d0187a:	2906      	cmp	r1, #6
c0d0187c:	d816      	bhi.n	c0d018ac <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
        G_io_app.usb_ep_timeouts[epnum].timeout = 0;
c0d0187e:	004a      	lsls	r2, r1, #1
c0d01880:	4b0c      	ldr	r3, [pc, #48]	; (c0d018b4 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d01882:	189a      	adds	r2, r3, r2
c0d01884:	2300      	movs	r3, #0
c0d01886:	8293      	strh	r3, [r2, #20]
        USBD_LL_DataInStage(&USBD_Device, epnum, &G_io_seproxyhal_spi_buffer[6]);
c0d01888:	1d82      	adds	r2, r0, #6
c0d0188a:	480b      	ldr	r0, [pc, #44]	; (c0d018b8 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d0188c:	f003 fdef 	bl	c0d0546e <USBD_LL_DataInStage>
}
c0d01890:	bd80      	pop	{r7, pc}
      if (epnum < IO_USB_MAX_ENDPOINTS) {
c0d01892:	2906      	cmp	r1, #6
c0d01894:	d80a      	bhi.n	c0d018ac <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
        G_io_app.usb_ep_xfer_len[epnum] = MIN(G_io_seproxyhal_spi_buffer[5], IO_SEPROXYHAL_BUFFER_SIZE_B - 6);
c0d01896:	4a07      	ldr	r2, [pc, #28]	; (c0d018b4 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d01898:	1852      	adds	r2, r2, r1
c0d0189a:	7943      	ldrb	r3, [r0, #5]
c0d0189c:	2b7a      	cmp	r3, #122	; 0x7a
c0d0189e:	d300      	bcc.n	c0d018a2 <io_seproxyhal_handle_usb_ep_xfer_event+0x4a>
c0d018a0:	237a      	movs	r3, #122	; 0x7a
c0d018a2:	7313      	strb	r3, [r2, #12]
        USBD_LL_DataOutStage(&USBD_Device, epnum, &G_io_seproxyhal_spi_buffer[6]);
c0d018a4:	1d82      	adds	r2, r0, #6
c0d018a6:	4804      	ldr	r0, [pc, #16]	; (c0d018b8 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d018a8:	f003 fd89 	bl	c0d053be <USBD_LL_DataOutStage>
}
c0d018ac:	bd80      	pop	{r7, pc}
c0d018ae:	46c0      	nop			; (mov r8, r8)
c0d018b0:	20000202 	.word	0x20000202
c0d018b4:	200003b4 	.word	0x200003b4
c0d018b8:	2000044c 	.word	0x2000044c

c0d018bc <io_usb_send_ep>:
#endif // HAVE_L4_USBLIB

// TODO, refactor this using the USB DataIn event like for the U2F tunnel
// TODO add a blocking parameter, for HID KBD sending, or use a USB busy flag per channel to know if
// the transfer has been processed or not. and move on to the next transfer on the same endpoint
void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d018bc:	b570      	push	{r4, r5, r6, lr}
  if (timeout) {
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d018be:	2aff      	cmp	r2, #255	; 0xff
c0d018c0:	d81d      	bhi.n	c0d018fe <io_usb_send_ep+0x42>
c0d018c2:	4615      	mov	r5, r2
c0d018c4:	460e      	mov	r6, r1
c0d018c6:	4604      	mov	r4, r0
    return;
  }

  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d018c8:	480d      	ldr	r0, [pc, #52]	; (c0d01900 <io_usb_send_ep+0x44>)
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
  G_io_seproxyhal_spi_buffer[2] = (3+length);
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  G_io_seproxyhal_spi_buffer[5] = length;
c0d018ca:	7142      	strb	r2, [r0, #5]
c0d018cc:	2120      	movs	r1, #32
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d018ce:	7101      	strb	r1, [r0, #4]
c0d018d0:	2150      	movs	r1, #80	; 0x50
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d018d2:	7001      	strb	r1, [r0, #0]
c0d018d4:	2180      	movs	r1, #128	; 0x80
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d018d6:	4321      	orrs	r1, r4
c0d018d8:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d018da:	1cd1      	adds	r1, r2, #3
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d018dc:	7081      	strb	r1, [r0, #2]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d018de:	0a09      	lsrs	r1, r1, #8
c0d018e0:	7041      	strb	r1, [r0, #1]
c0d018e2:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d018e4:	f003 faca 	bl	c0d04e7c <io_seph_send>
  io_seproxyhal_spi_send(buffer, length);
c0d018e8:	4630      	mov	r0, r6
c0d018ea:	4629      	mov	r1, r5
c0d018ec:	f003 fac6 	bl	c0d04e7c <io_seph_send>
  // setup timeout of the endpoint
  G_io_app.usb_ep_timeouts[ep&0x7F].timeout = IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d018f0:	0660      	lsls	r0, r4, #25
c0d018f2:	0e00      	lsrs	r0, r0, #24
c0d018f4:	4903      	ldr	r1, [pc, #12]	; (c0d01904 <io_usb_send_ep+0x48>)
c0d018f6:	1808      	adds	r0, r1, r0
c0d018f8:	217d      	movs	r1, #125	; 0x7d
c0d018fa:	0109      	lsls	r1, r1, #4
c0d018fc:	8281      	strh	r1, [r0, #20]
}
c0d018fe:	bd70      	pop	{r4, r5, r6, pc}
c0d01900:	20000202 	.word	0x20000202
c0d01904:	200003b4 	.word	0x200003b4

c0d01908 <io_usb_send_apdu_data>:

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d01908:	b580      	push	{r7, lr}
c0d0190a:	460a      	mov	r2, r1
c0d0190c:	4601      	mov	r1, r0
c0d0190e:	2082      	movs	r0, #130	; 0x82
c0d01910:	2314      	movs	r3, #20
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01912:	f7ff ffd3 	bl	c0d018bc <io_usb_send_ep>
}
c0d01916:	bd80      	pop	{r7, pc}

c0d01918 <io_usb_send_apdu_data_ep0x83>:

#ifdef HAVE_WEBUSB
void io_usb_send_apdu_data_ep0x83(unsigned char* buffer, unsigned short length) {
c0d01918:	b580      	push	{r7, lr}
c0d0191a:	460a      	mov	r2, r1
c0d0191c:	4601      	mov	r1, r0
c0d0191e:	2083      	movs	r0, #131	; 0x83
c0d01920:	2314      	movs	r3, #20
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x83, buffer, length, 20);
c0d01922:	f7ff ffcb 	bl	c0d018bc <io_usb_send_ep>
}
c0d01926:	bd80      	pop	{r7, pc}

c0d01928 <io_seproxyhal_handle_event>:
    // copy apdu to apdu buffer
    memcpy(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_app.apdu_length);
  }
}

unsigned int io_seproxyhal_handle_event(void) {
c0d01928:	b510      	push	{r4, lr}
#define U2(hi, lo) ((((hi)&0xFFu) << 8) | ((lo)&0xFFu))
#define U4(hi3, hi2, lo1, lo0)                                                 \
  ((((hi3)&0xFFu) << 24) | (((hi2)&0xFFu) << 16) | (((lo1)&0xFFu) << 8) |      \
   ((lo0)&0xFFu))
static inline uint16_t U2BE(const uint8_t *buf, size_t off) {
  return (buf[off] << 8) | buf[off + 1];
c0d0192a:	4826      	ldr	r0, [pc, #152]	; (c0d019c4 <io_seproxyhal_handle_event+0x9c>)
c0d0192c:	7881      	ldrb	r1, [r0, #2]
c0d0192e:	7842      	ldrb	r2, [r0, #1]
c0d01930:	0212      	lsls	r2, r2, #8
c0d01932:	1852      	adds	r2, r2, r1
#if defined(HAVE_IO_USB) || defined(HAVE_BLE)
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
#endif

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01934:	7801      	ldrb	r1, [r0, #0]
c0d01936:	290f      	cmp	r1, #15
c0d01938:	dc08      	bgt.n	c0d0194c <io_seproxyhal_handle_event+0x24>
c0d0193a:	290e      	cmp	r1, #14
c0d0193c:	d01c      	beq.n	c0d01978 <io_seproxyhal_handle_event+0x50>
c0d0193e:	290f      	cmp	r1, #15
c0d01940:	d12d      	bne.n	c0d0199e <io_seproxyhal_handle_event+0x76>
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 1) {
c0d01942:	2a01      	cmp	r2, #1
c0d01944:	d132      	bne.n	c0d019ac <io_seproxyhal_handle_event+0x84>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d01946:	f7ff ff43 	bl	c0d017d0 <io_seproxyhal_handle_usb_event>
c0d0194a:	e033      	b.n	c0d019b4 <io_seproxyhal_handle_event+0x8c>
  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d0194c:	2910      	cmp	r1, #16
c0d0194e:	d02b      	beq.n	c0d019a8 <io_seproxyhal_handle_event+0x80>
c0d01950:	2916      	cmp	r1, #22
c0d01952:	d124      	bne.n	c0d0199e <io_seproxyhal_handle_event+0x76>
  if (G_io_app.apdu_state == APDU_IDLE) {
c0d01954:	491c      	ldr	r1, [pc, #112]	; (c0d019c8 <io_seproxyhal_handle_event+0xa0>)
c0d01956:	780b      	ldrb	r3, [r1, #0]
c0d01958:	2401      	movs	r4, #1
c0d0195a:	2b00      	cmp	r3, #0
c0d0195c:	d12b      	bne.n	c0d019b6 <io_seproxyhal_handle_event+0x8e>
c0d0195e:	230a      	movs	r3, #10
    G_io_app.apdu_state = APDU_RAW; // for next call to io_exchange
c0d01960:	700b      	strb	r3, [r1, #0]
c0d01962:	2306      	movs	r3, #6
    G_io_app.apdu_media = IO_APDU_MEDIA_RAW; // for application code
c0d01964:	718b      	strb	r3, [r1, #6]
    G_io_app.apdu_length = MIN(size, max);
c0d01966:	2a7d      	cmp	r2, #125	; 0x7d
c0d01968:	d300      	bcc.n	c0d0196c <io_seproxyhal_handle_event+0x44>
c0d0196a:	227d      	movs	r2, #125	; 0x7d
c0d0196c:	804a      	strh	r2, [r1, #2]
    memcpy(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_app.apdu_length);
c0d0196e:	1cc1      	adds	r1, r0, #3
c0d01970:	4816      	ldr	r0, [pc, #88]	; (c0d019cc <io_seproxyhal_handle_event+0xa4>)
c0d01972:	f005 fccf 	bl	c0d07314 <__aeabi_memcpy>
c0d01976:	e01e      	b.n	c0d019b6 <io_seproxyhal_handle_event+0x8e>
      return 1;

      // ask the user if not processed here
    case SEPROXYHAL_TAG_TICKER_EVENT:
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
      G_io_app.ms += 100; // value is by default, don't change the ticker configuration
c0d01978:	4813      	ldr	r0, [pc, #76]	; (c0d019c8 <io_seproxyhal_handle_event+0xa0>)
c0d0197a:	6881      	ldr	r1, [r0, #8]
c0d0197c:	3164      	adds	r1, #100	; 0x64
c0d0197e:	6081      	str	r1, [r0, #8]
c0d01980:	2120      	movs	r1, #32
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
          if (G_io_app.usb_ep_timeouts[i].timeout) {
c0d01982:	5a42      	ldrh	r2, [r0, r1]
c0d01984:	2a00      	cmp	r2, #0
c0d01986:	d007      	beq.n	c0d01998 <io_seproxyhal_handle_event+0x70>
            G_io_app.usb_ep_timeouts[i].timeout-=MIN(G_io_app.usb_ep_timeouts[i].timeout, 100);
c0d01988:	2a64      	cmp	r2, #100	; 0x64
c0d0198a:	4613      	mov	r3, r2
c0d0198c:	d800      	bhi.n	c0d01990 <io_seproxyhal_handle_event+0x68>
c0d0198e:	2364      	movs	r3, #100	; 0x64
c0d01990:	3b64      	subs	r3, #100	; 0x64
c0d01992:	5243      	strh	r3, [r0, r1]
            if (!G_io_app.usb_ep_timeouts[i].timeout) {
c0d01994:	2a64      	cmp	r2, #100	; 0x64
c0d01996:	d910      	bls.n	c0d019ba <io_seproxyhal_handle_event+0x92>
        while(i--) {
c0d01998:	1e89      	subs	r1, r1, #2
c0d0199a:	2912      	cmp	r1, #18
c0d0199c:	d1f1      	bne.n	c0d01982 <io_seproxyhal_handle_event+0x5a>
c0d0199e:	2002      	movs	r0, #2
      }
#endif // HAVE_BLE_APDU
      __attribute__((fallthrough));
      // no break is intentional
    default:
      return io_event(CHANNEL_SPI);
c0d019a0:	f7fe fe2a 	bl	c0d005f8 <io_event>
c0d019a4:	4604      	mov	r4, r0
c0d019a6:	e006      	b.n	c0d019b6 <io_seproxyhal_handle_event+0x8e>
      if (rx_len < 3) {
c0d019a8:	2a03      	cmp	r2, #3
c0d019aa:	d201      	bcs.n	c0d019b0 <io_seproxyhal_handle_event+0x88>
c0d019ac:	2400      	movs	r4, #0
c0d019ae:	e002      	b.n	c0d019b6 <io_seproxyhal_handle_event+0x8e>
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d019b0:	f7ff ff52 	bl	c0d01858 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d019b4:	2401      	movs	r4, #1
  }
  // defaultly return as not processed
  return 0;
}
c0d019b6:	4620      	mov	r0, r4
c0d019b8:	bd10      	pop	{r4, pc}
c0d019ba:	2100      	movs	r1, #0
              G_io_app.apdu_state = APDU_IDLE;
c0d019bc:	7001      	strb	r1, [r0, #0]
c0d019be:	2005      	movs	r0, #5
              THROW(EXCEPTION_IO_RESET);
c0d019c0:	f7ff fe31 	bl	c0d01626 <os_longjmp>
c0d019c4:	20000202 	.word	0x20000202
c0d019c8:	200003b4 	.word	0x200003b4
c0d019cc:	200002b0 	.word	0x200002b0

c0d019d0 <io_seproxyhal_init>:
  1,
  SEPROXYHAL_TAG_MCU_TYPE_PROTECT,
};
#endif // (!defined(HAVE_BOLOS) && defined(HAVE_MCU_PROTECT))

void io_seproxyhal_init(void) {
c0d019d0:	b580      	push	{r7, lr}
// get API level
SYSCALL unsigned int get_api_level(void);

#ifndef HAVE_BOLOS
static inline void check_api_level(unsigned int apiLevel) {
  if (apiLevel < get_api_level()) {
c0d019d2:	f003 f997 	bl	c0d04d04 <get_api_level>
c0d019d6:	280d      	cmp	r0, #13
c0d019d8:	d302      	bcc.n	c0d019e0 <io_seproxyhal_init+0x10>
c0d019da:	20ff      	movs	r0, #255	; 0xff
    os_sched_exit(-1);
c0d019dc:	f003 fa40 	bl	c0d04e60 <os_sched_exit>
  io_seproxyhal_spi_send(seph_io_mcu_protect, sizeof(seph_io_mcu_protect));
#endif // HAVE_MCU_PROTECT
#endif // HAVE_BOLOS

#ifdef HAVE_BOLOS_APP_STACK_CANARY
  app_stack_canary = APP_STACK_CANARY_MAGIC;
c0d019e0:	4807      	ldr	r0, [pc, #28]	; (c0d01a00 <io_seproxyhal_init+0x30>)
c0d019e2:	4908      	ldr	r1, [pc, #32]	; (c0d01a04 <io_seproxyhal_init+0x34>)
c0d019e4:	6001      	str	r1, [r0, #0]
  memset(&G_io_app, 0, sizeof(G_io_app));
#ifdef HAVE_BLE
  G_io_app.plane_mode = plane;
#endif // HAVE_BLE

  G_io_app.apdu_state = APDU_IDLE;
c0d019e6:	4808      	ldr	r0, [pc, #32]	; (c0d01a08 <io_seproxyhal_init+0x38>)
c0d019e8:	2124      	movs	r1, #36	; 0x24
c0d019ea:	f005 fc8d 	bl	c0d07308 <__aeabi_memclr>
  #ifdef DEBUG_APDU
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU

  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d019ee:	f000 fb39 	bl	c0d02064 <io_usb_hid_init>
#endif // TARGET_BLUE
}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_ux_os.button_mask = 0;
c0d019f2:	4806      	ldr	r0, [pc, #24]	; (c0d01a0c <io_seproxyhal_init+0x3c>)
c0d019f4:	2100      	movs	r1, #0
c0d019f6:	6001      	str	r1, [r0, #0]
  G_ux_os.button_same_mask_counter = 0;
c0d019f8:	6041      	str	r1, [r0, #4]
  check_audited_app();
c0d019fa:	f7ff fb43 	bl	c0d01084 <check_audited_app>
}
c0d019fe:	bd80      	pop	{r7, pc}
c0d01a00:	20000648 	.word	0x20000648
c0d01a04:	dead0031 	.word	0xdead0031
c0d01a08:	200003b4 	.word	0x200003b4
c0d01a0c:	200003d8 	.word	0x200003d8

c0d01a10 <io_seproxyhal_init_ux>:
}
c0d01a10:	4770      	bx	lr
	...

c0d01a14 <io_seproxyhal_init_button>:
  G_ux_os.button_mask = 0;
c0d01a14:	4802      	ldr	r0, [pc, #8]	; (c0d01a20 <io_seproxyhal_init_button+0xc>)
c0d01a16:	2100      	movs	r1, #0
c0d01a18:	6001      	str	r1, [r0, #0]
  G_ux_os.button_same_mask_counter = 0;
c0d01a1a:	6041      	str	r1, [r0, #4]
}
c0d01a1c:	4770      	bx	lr
c0d01a1e:	46c0      	nop			; (mov r8, r8)
c0d01a20:	200003d8 	.word	0x200003d8

c0d01a24 <io_seproxyhal_display_icon>:
  // remaining length of bitmap bits to be displayed
  return len;
}
#endif // SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_det) {
c0d01a24:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a26:	b087      	sub	sp, #28
c0d01a28:	4605      	mov	r5, r0
  bagl_component_t icon_component_mod;
  const bagl_icon_details_t* icon_details = (bagl_icon_details_t*)PIC(icon_det);
c0d01a2a:	4608      	mov	r0, r1
c0d01a2c:	f001 fca8 	bl	c0d03380 <pic>

  if (icon_details && icon_details->bitmap) {
c0d01a30:	2800      	cmp	r0, #0
c0d01a32:	d043      	beq.n	c0d01abc <io_seproxyhal_display_icon+0x98>
c0d01a34:	4604      	mov	r4, r0
c0d01a36:	6900      	ldr	r0, [r0, #16]
c0d01a38:	2800      	cmp	r0, #0
c0d01a3a:	d03f      	beq.n	c0d01abc <io_seproxyhal_display_icon+0x98>
    // ensure not being out of bounds in the icon component agianst the declared icon real size
    memcpy(&icon_component_mod, (void *)PIC(icon_component), sizeof(bagl_component_t));
c0d01a3c:	4628      	mov	r0, r5
c0d01a3e:	f001 fc9f 	bl	c0d03380 <pic>
c0d01a42:	4601      	mov	r1, r0
c0d01a44:	466d      	mov	r5, sp
c0d01a46:	221c      	movs	r2, #28
c0d01a48:	4628      	mov	r0, r5
c0d01a4a:	f005 fc63 	bl	c0d07314 <__aeabi_memcpy>
    icon_component_mod.width = icon_details->width;
c0d01a4e:	6826      	ldr	r6, [r4, #0]
c0d01a50:	80ee      	strh	r6, [r5, #6]
    icon_component_mod.height = icon_details->height;
c0d01a52:	6867      	ldr	r7, [r4, #4]
c0d01a54:	812f      	strh	r7, [r5, #8]
#else // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
#ifdef HAVE_SE_SCREEN
    bagl_draw_glyph(&icon_component_mod, icon_details);
#endif // HAVE_SE_SCREEN
#if !defined(HAVE_SE_SCREEN) || (defined(HAVE_SE_SCREEN) && defined(HAVE_PRINTF))
    if (io_seproxyhal_spi_is_status_sent()) {
c0d01a56:	f003 fa1d 	bl	c0d04e94 <io_seph_is_status_sent>
c0d01a5a:	2800      	cmp	r0, #0
c0d01a5c:	d12e      	bne.n	c0d01abc <io_seproxyhal_display_icon+0x98>
c0d01a5e:	b2b9      	uxth	r1, r7
c0d01a60:	b2b2      	uxth	r2, r6
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
    unsigned short length = sizeof(bagl_component_t)
                            +1 /* bpp */
                            +h /* color index */
                            +w; /* image bitmap size */
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01a62:	4d17      	ldr	r5, [pc, #92]	; (c0d01ac0 <io_seproxyhal_display_icon+0x9c>)
c0d01a64:	2065      	movs	r0, #101	; 0x65
c0d01a66:	7028      	strb	r0, [r5, #0]
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int);
c0d01a68:	68a0      	ldr	r0, [r4, #8]
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d01a6a:	4342      	muls	r2, r0
c0d01a6c:	434a      	muls	r2, r1
c0d01a6e:	0751      	lsls	r1, r2, #29
c0d01a70:	08d6      	lsrs	r6, r2, #3
c0d01a72:	2900      	cmp	r1, #0
c0d01a74:	d000      	beq.n	c0d01a78 <io_seproxyhal_display_icon+0x54>
c0d01a76:	1c76      	adds	r6, r6, #1
c0d01a78:	2704      	movs	r7, #4
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int);
c0d01a7a:	4087      	lsls	r7, r0
                            +h /* color index */
c0d01a7c:	19b8      	adds	r0, r7, r6
                            +w; /* image bitmap size */
c0d01a7e:	301d      	adds	r0, #29
#if defined(HAVE_SE_SCREEN) && defined(HAVE_PRINTF)
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_DBG_SCREEN_DISPLAY_STATUS;
#endif // HAVE_SE_SCREEN && HAVE_PRINTF
    G_io_seproxyhal_spi_buffer[1] = length>>8;
    G_io_seproxyhal_spi_buffer[2] = length;
c0d01a80:	70a8      	strb	r0, [r5, #2]
    G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01a82:	0a00      	lsrs	r0, r0, #8
c0d01a84:	7068      	strb	r0, [r5, #1]
c0d01a86:	2103      	movs	r1, #3
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01a88:	4628      	mov	r0, r5
c0d01a8a:	f003 f9f7 	bl	c0d04e7c <io_seph_send>
c0d01a8e:	4668      	mov	r0, sp
c0d01a90:	211c      	movs	r1, #28
    io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01a92:	f003 f9f3 	bl	c0d04e7c <io_seph_send>
    G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01a96:	68a0      	ldr	r0, [r4, #8]
c0d01a98:	7028      	strb	r0, [r5, #0]
c0d01a9a:	2101      	movs	r1, #1
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d01a9c:	4628      	mov	r0, r5
c0d01a9e:	f003 f9ed 	bl	c0d04e7c <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d01aa2:	68e0      	ldr	r0, [r4, #12]
c0d01aa4:	f001 fc6c 	bl	c0d03380 <pic>
c0d01aa8:	b2b9      	uxth	r1, r7
c0d01aaa:	f003 f9e7 	bl	c0d04e7c <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01aae:	b2b5      	uxth	r5, r6
c0d01ab0:	6920      	ldr	r0, [r4, #16]
c0d01ab2:	f001 fc65 	bl	c0d03380 <pic>
c0d01ab6:	4629      	mov	r1, r5
c0d01ab8:	f003 f9e0 	bl	c0d04e7c <io_seph_send>
#endif // !HAVE_SE_SCREEN || (HAVE_SE_SCREEN && HAVE_PRINTF)
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
  }
}
c0d01abc:	b007      	add	sp, #28
c0d01abe:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01ac0:	20000202 	.word	0x20000202

c0d01ac4 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(const bagl_element_t* element) {
c0d01ac4:	b570      	push	{r4, r5, r6, lr}

  const bagl_element_t* el = (const bagl_element_t*) PIC(element);
c0d01ac6:	f001 fc5b 	bl	c0d03380 <pic>
c0d01aca:	4604      	mov	r4, r0
  const char* txt = (const char*)PIC(el->text);
c0d01acc:	69c0      	ldr	r0, [r0, #28]
c0d01ace:	f001 fc57 	bl	c0d03380 <pic>
c0d01ad2:	4605      	mov	r5, r0
  // process automagically address from rom and from ram
  unsigned int type = (el->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01ad4:	7821      	ldrb	r1, [r4, #0]
c0d01ad6:	207f      	movs	r0, #127	; 0x7f
c0d01ad8:	4008      	ands	r0, r1

  if (type != BAGL_NONE) {
c0d01ada:	d00a      	beq.n	c0d01af2 <io_seproxyhal_display_default+0x2e>
    if (txt != NULL) {
c0d01adc:	2d00      	cmp	r5, #0
c0d01ade:	d009      	beq.n	c0d01af4 <io_seproxyhal_display_default+0x30>
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && el->component.icon_id == 0) {
c0d01ae0:	2805      	cmp	r0, #5
c0d01ae2:	d102      	bne.n	c0d01aea <io_seproxyhal_display_default+0x26>
c0d01ae4:	7ea0      	ldrb	r0, [r4, #26]
c0d01ae6:	2800      	cmp	r0, #0
c0d01ae8:	d02d      	beq.n	c0d01b46 <io_seproxyhal_display_default+0x82>
      else {
#ifdef HAVE_SE_SCREEN
        bagl_draw_with_context(&el->component, txt, strlen(txt), BAGL_ENCODING_LATIN1);
#endif // HAVE_SE_SCREEN
#if !defined(HAVE_SE_SCREEN) || (defined(HAVE_SE_SCREEN) && defined(HAVE_PRINTF))
        if (io_seproxyhal_spi_is_status_sent()) {
c0d01aea:	f003 f9d3 	bl	c0d04e94 <io_seph_is_status_sent>
c0d01aee:	2800      	cmp	r0, #0
c0d01af0:	d011      	beq.n	c0d01b16 <io_seproxyhal_display_default+0x52>
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
      io_seproxyhal_spi_send((unsigned char*)&el->component, sizeof(bagl_component_t));
#endif // !HAVE_SE_SCREEN || (HAVE_SE_SCREEN && HAVE_PRINTF)
    }
  }
}
c0d01af2:	bd70      	pop	{r4, r5, r6, pc}
      if (io_seproxyhal_spi_is_status_sent()) {
c0d01af4:	f003 f9ce 	bl	c0d04e94 <io_seph_is_status_sent>
c0d01af8:	2800      	cmp	r0, #0
c0d01afa:	d1fa      	bne.n	c0d01af2 <io_seproxyhal_display_default+0x2e>
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01afc:	4814      	ldr	r0, [pc, #80]	; (c0d01b50 <io_seproxyhal_display_default+0x8c>)
c0d01afe:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01b00:	7085      	strb	r5, [r0, #2]
c0d01b02:	2100      	movs	r1, #0
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01b04:	7041      	strb	r1, [r0, #1]
c0d01b06:	2165      	movs	r1, #101	; 0x65
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01b08:	7001      	strb	r1, [r0, #0]
c0d01b0a:	2103      	movs	r1, #3
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01b0c:	f003 f9b6 	bl	c0d04e7c <io_seph_send>
      io_seproxyhal_spi_send((unsigned char*)&el->component, sizeof(bagl_component_t));
c0d01b10:	4620      	mov	r0, r4
c0d01b12:	4629      	mov	r1, r5
c0d01b14:	e014      	b.n	c0d01b40 <io_seproxyhal_display_default+0x7c>
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)txt);
c0d01b16:	4628      	mov	r0, r5
c0d01b18:	f005 fd9c 	bl	c0d07654 <strlen>
c0d01b1c:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01b1e:	480c      	ldr	r0, [pc, #48]	; (c0d01b50 <io_seproxyhal_display_default+0x8c>)
c0d01b20:	2165      	movs	r1, #101	; 0x65
c0d01b22:	7001      	strb	r1, [r0, #0]
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)txt);
c0d01b24:	4631      	mov	r1, r6
c0d01b26:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[2] = length;
c0d01b28:	7081      	strb	r1, [r0, #2]
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d01b2a:	0a09      	lsrs	r1, r1, #8
c0d01b2c:	7041      	strb	r1, [r0, #1]
c0d01b2e:	2103      	movs	r1, #3
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01b30:	f003 f9a4 	bl	c0d04e7c <io_seph_send>
c0d01b34:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((unsigned char*)&el->component, sizeof(bagl_component_t));
c0d01b36:	4620      	mov	r0, r4
c0d01b38:	f003 f9a0 	bl	c0d04e7c <io_seph_send>
        io_seproxyhal_spi_send((unsigned char*)txt, length-sizeof(bagl_component_t));
c0d01b3c:	b2b1      	uxth	r1, r6
c0d01b3e:	4628      	mov	r0, r5
c0d01b40:	f003 f99c 	bl	c0d04e7c <io_seph_send>
}
c0d01b44:	bd70      	pop	{r4, r5, r6, pc}
        io_seproxyhal_display_icon((bagl_component_t*)&el->component, (bagl_icon_details_t*)txt);
c0d01b46:	4620      	mov	r0, r4
c0d01b48:	4629      	mov	r1, r5
c0d01b4a:	f7ff ff6b 	bl	c0d01a24 <io_seproxyhal_display_icon>
}
c0d01b4e:	bd70      	pop	{r4, r5, r6, pc}
c0d01b50:	20000202 	.word	0x20000202

c0d01b54 <bagl_label_roundtrip_duration_ms>:

unsigned int bagl_label_roundtrip_duration_ms(const bagl_element_t* e, unsigned int average_char_width) {
c0d01b54:	b580      	push	{r7, lr}
c0d01b56:	460a      	mov	r2, r1
  return bagl_label_roundtrip_duration_ms_buf(e, e->text, average_char_width);
c0d01b58:	69c1      	ldr	r1, [r0, #28]
c0d01b5a:	f000 f801 	bl	c0d01b60 <bagl_label_roundtrip_duration_ms_buf>
c0d01b5e:	bd80      	pop	{r7, pc}

c0d01b60 <bagl_label_roundtrip_duration_ms_buf>:
}

unsigned int bagl_label_roundtrip_duration_ms_buf(const bagl_element_t* e, const char* str, unsigned int average_char_width) {
c0d01b60:	b570      	push	{r4, r5, r6, lr}
c0d01b62:	2500      	movs	r5, #0
  // not a scrollable label
  if (e == NULL || (e->component.type != BAGL_LABEL && e->component.type != BAGL_LABELINE)) {
c0d01b64:	2800      	cmp	r0, #0
c0d01b66:	d01e      	beq.n	c0d01ba6 <bagl_label_roundtrip_duration_ms_buf+0x46>
c0d01b68:	4616      	mov	r6, r2
c0d01b6a:	4604      	mov	r4, r0
c0d01b6c:	7800      	ldrb	r0, [r0, #0]
c0d01b6e:	2807      	cmp	r0, #7
c0d01b70:	d001      	beq.n	c0d01b76 <bagl_label_roundtrip_duration_ms_buf+0x16>
c0d01b72:	2802      	cmp	r0, #2
c0d01b74:	d117      	bne.n	c0d01ba6 <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0;
  }

  unsigned int text_adr = (unsigned int)PIC((unsigned int)str);
c0d01b76:	4608      	mov	r0, r1
c0d01b78:	f001 fc02 	bl	c0d03380 <pic>
  unsigned int textlen = 0;

  // no delay, no text to display
  if (!text_adr) {
c0d01b7c:	2800      	cmp	r0, #0
c0d01b7e:	d012      	beq.n	c0d01ba6 <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0;
  }
  textlen = strlen((const char*)text_adr);
c0d01b80:	f005 fd68 	bl	c0d07654 <strlen>

  // no delay, all text fits
  textlen = textlen * average_char_width;
c0d01b84:	4346      	muls	r6, r0
  if (textlen <= e->component.width) {
c0d01b86:	88e0      	ldrh	r0, [r4, #6]
c0d01b88:	4286      	cmp	r6, r0
c0d01b8a:	d90c      	bls.n	c0d01ba6 <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0;
  }

  // compute scrolled text length
  return 2*(textlen - e->component.width)*1000/e->component.icon_id + 2*(e->component.stroke & ~(0x80))*100;
c0d01b8c:	1a31      	subs	r1, r6, r0
c0d01b8e:	207d      	movs	r0, #125	; 0x7d
c0d01b90:	0100      	lsls	r0, r0, #4
c0d01b92:	4348      	muls	r0, r1
c0d01b94:	7ea1      	ldrb	r1, [r4, #26]
c0d01b96:	f005 fa25 	bl	c0d06fe4 <__udivsi3>
c0d01b9a:	7aa1      	ldrb	r1, [r4, #10]
c0d01b9c:	0649      	lsls	r1, r1, #25
c0d01b9e:	0e09      	lsrs	r1, r1, #24
c0d01ba0:	2264      	movs	r2, #100	; 0x64
c0d01ba2:	434a      	muls	r2, r1
c0d01ba4:	1815      	adds	r5, r2, r0
}
c0d01ba6:	4628      	mov	r0, r5
c0d01ba8:	bd70      	pop	{r4, r5, r6, pc}
	...

c0d01bac <io_seproxyhal_button_push>:

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d01bac:	b570      	push	{r4, r5, r6, lr}
  if (button_callback) {
c0d01bae:	2800      	cmp	r0, #0
c0d01bb0:	d025      	beq.n	c0d01bfe <io_seproxyhal_button_push+0x52>
c0d01bb2:	460b      	mov	r3, r1
c0d01bb4:	4602      	mov	r2, r0
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_ux_os.button_mask) {
c0d01bb6:	4c12      	ldr	r4, [pc, #72]	; (c0d01c00 <io_seproxyhal_button_push+0x54>)
c0d01bb8:	cc03      	ldmia	r4!, {r0, r1}
c0d01bba:	3c08      	subs	r4, #8
c0d01bbc:	4298      	cmp	r0, r3
c0d01bbe:	d101      	bne.n	c0d01bc4 <io_seproxyhal_button_push+0x18>
      // each 100ms ~
      G_ux_os.button_same_mask_counter++;
c0d01bc0:	1c49      	adds	r1, r1, #1
c0d01bc2:	6061      	str	r1, [r4, #4]
    }

    // when new_button_mask is 0 and

    // append the button mask
    button_mask = G_ux_os.button_mask | new_button_mask;
c0d01bc4:	4318      	orrs	r0, r3

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_ux_os.button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
c0d01bc6:	2b00      	cmp	r3, #0
c0d01bc8:	d002      	beq.n	c0d01bd0 <io_seproxyhal_button_push+0x24>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_ux_os.button_mask = button_mask;
c0d01bca:	6020      	str	r0, [r4, #0]
    }

    // reset counter when button mask changes
    if (new_button_mask != G_ux_os.button_mask) {
c0d01bcc:	4605      	mov	r5, r0
c0d01bce:	e005      	b.n	c0d01bdc <io_seproxyhal_button_push+0x30>
c0d01bd0:	2500      	movs	r5, #0
      G_ux_os.button_mask = 0;
c0d01bd2:	6025      	str	r5, [r4, #0]
      G_ux_os.button_same_mask_counter=0;
c0d01bd4:	6065      	str	r5, [r4, #4]
c0d01bd6:	4e0b      	ldr	r6, [pc, #44]	; (c0d01c04 <io_seproxyhal_button_push+0x58>)
      button_mask |= BUTTON_EVT_RELEASED;
c0d01bd8:	1c76      	adds	r6, r6, #1
c0d01bda:	4330      	orrs	r0, r6
    if (new_button_mask != G_ux_os.button_mask) {
c0d01bdc:	429d      	cmp	r5, r3
c0d01bde:	d001      	beq.n	c0d01be4 <io_seproxyhal_button_push+0x38>
c0d01be0:	2300      	movs	r3, #0
      G_ux_os.button_same_mask_counter=0;
c0d01be2:	6063      	str	r3, [r4, #4]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d01be4:	2908      	cmp	r1, #8
c0d01be6:	d309      	bcc.n	c0d01bfc <io_seproxyhal_button_push+0x50>
c0d01be8:	4c07      	ldr	r4, [pc, #28]	; (c0d01c08 <io_seproxyhal_button_push+0x5c>)
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01bea:	434c      	muls	r4, r1
c0d01bec:	2301      	movs	r3, #1
c0d01bee:	4d07      	ldr	r5, [pc, #28]	; (c0d01c0c <io_seproxyhal_button_push+0x60>)
c0d01bf0:	42ac      	cmp	r4, r5
c0d01bf2:	d201      	bcs.n	c0d01bf8 <io_seproxyhal_button_push+0x4c>
c0d01bf4:	079c      	lsls	r4, r3, #30
c0d01bf6:	4320      	orrs	r0, r4
c0d01bf8:	07db      	lsls	r3, r3, #31
      }
      */

      // discard the release event after a fastskip has been detected, to avoid strange at release behavior
      // and also to enable user to cancel an operation by starting triggering the fast skip
      button_mask &= ~BUTTON_EVT_RELEASED;
c0d01bfa:	4398      	bics	r0, r3
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01bfc:	4790      	blx	r2

  }
}
c0d01bfe:	bd70      	pop	{r4, r5, r6, pc}
c0d01c00:	200003d8 	.word	0x200003d8
c0d01c04:	7fffffff 	.word	0x7fffffff
c0d01c08:	aaaaaaab 	.word	0xaaaaaaab
c0d01c0c:	55555556 	.word	0x55555556

c0d01c10 <io_seproxyhal_se_reset>:
  SEPROXYHAL_TAG_SE_POWER_OFF,
  0,
  0,
};
void io_seproxyhal_se_reset(void) {
  io_seproxyhal_spi_send(seph_io_se_reset, sizeof(seph_io_se_reset));
c0d01c10:	4802      	ldr	r0, [pc, #8]	; (c0d01c1c <io_seproxyhal_se_reset+0xc>)
c0d01c12:	4478      	add	r0, pc
c0d01c14:	2103      	movs	r1, #3
c0d01c16:	f003 f931 	bl	c0d04e7c <io_seph_send>
  for(;;);
c0d01c1a:	e7fe      	b.n	c0d01c1a <io_seproxyhal_se_reset+0xa>
c0d01c1c:	00005c53 	.word	0x00005c53

c0d01c20 <os_io_seproxyhal_get_app_name_and_version>:
#ifdef HAVE_IO_U2F
u2f_service_t G_io_u2f;
#endif // HAVE_IO_U2F

unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
c0d01c20:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c22:	b081      	sub	sp, #4
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d01c24:	4e0f      	ldr	r6, [pc, #60]	; (c0d01c64 <os_io_seproxyhal_get_app_name_and_version+0x44>)
c0d01c26:	2401      	movs	r4, #1
c0d01c28:	7034      	strb	r4, [r6, #0]

#ifndef HAVE_BOLOS
  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len-1);
c0d01c2a:	1cb1      	adds	r1, r6, #2
c0d01c2c:	27ff      	movs	r7, #255	; 0xff
c0d01c2e:	3702      	adds	r7, #2
c0d01c30:	1c7a      	adds	r2, r7, #1
c0d01c32:	4620      	mov	r0, r4
c0d01c34:	f003 f908 	bl	c0d04e48 <os_registry_get_current_app_tag>
c0d01c38:	4605      	mov	r5, r0
  G_io_apdu_buffer[tx_len++] = len;
c0d01c3a:	7070      	strb	r0, [r6, #1]
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len-1);
c0d01c3c:	1a3a      	subs	r2, r7, r0
  tx_len += len;
c0d01c3e:	1987      	adds	r7, r0, r6
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len-1);
c0d01c40:	1cf9      	adds	r1, r7, #3
c0d01c42:	2002      	movs	r0, #2
c0d01c44:	f003 f900 	bl	c0d04e48 <os_registry_get_current_app_tag>
  G_io_apdu_buffer[tx_len++] = len;
c0d01c48:	70b8      	strb	r0, [r7, #2]
c0d01c4a:	182d      	adds	r5, r5, r0
  tx_len += len;
c0d01c4c:	19ae      	adds	r6, r5, r6
#endif // HAVE_BOLOS

#if !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)
  // to be fixed within io tasks
  // return OS flags to notify of platform's global state (pin lock etc)
  G_io_apdu_buffer[tx_len++] = 1; // flags length
c0d01c4e:	70f4      	strb	r4, [r6, #3]
  G_io_apdu_buffer[tx_len++] = os_flags();
c0d01c50:	f003 f8d6 	bl	c0d04e00 <os_flags>
c0d01c54:	2100      	movs	r1, #0
#endif // !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)

  // status words
  G_io_apdu_buffer[tx_len++] = 0x90;
  G_io_apdu_buffer[tx_len++] = 0x00;
c0d01c56:	71b1      	strb	r1, [r6, #6]
c0d01c58:	2190      	movs	r1, #144	; 0x90
  G_io_apdu_buffer[tx_len++] = 0x90;
c0d01c5a:	7171      	strb	r1, [r6, #5]
  G_io_apdu_buffer[tx_len++] = os_flags();
c0d01c5c:	7130      	strb	r0, [r6, #4]
  G_io_apdu_buffer[tx_len++] = 0x00;
c0d01c5e:	1de8      	adds	r0, r5, #7
  return tx_len;
c0d01c60:	b001      	add	sp, #4
c0d01c62:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01c64:	200002b0 	.word	0x200002b0

c0d01c68 <io_exchange>:
  return processed;
}

#endif // HAVE_BOLOS_NO_DEFAULT_APDU

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01c68:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c6a:	b087      	sub	sp, #28
c0d01c6c:	4602      	mov	r2, r0
  unsigned short rx_len;
  unsigned int timeout_ms;

#ifdef HAVE_BOLOS_APP_STACK_CANARY
  // behavior upon detected stack overflow is to reset the SE
  if (app_stack_canary != APP_STACK_CANARY_MAGIC) {
c0d01c6e:	488d      	ldr	r0, [pc, #564]	; (c0d01ea4 <io_exchange+0x23c>)
c0d01c70:	6800      	ldr	r0, [r0, #0]
c0d01c72:	4b8d      	ldr	r3, [pc, #564]	; (c0d01ea8 <io_exchange+0x240>)
c0d01c74:	4298      	cmp	r0, r3
c0d01c76:	d000      	beq.n	c0d01c7a <io_exchange+0x12>
c0d01c78:	e10c      	b.n	c0d01e94 <io_exchange+0x22c>
    }
  }
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d01c7a:	0750      	lsls	r0, r2, #29
c0d01c7c:	d007      	beq.n	c0d01c8e <io_exchange+0x26>
c0d01c7e:	4617      	mov	r7, r2
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01c80:	b2f8      	uxtb	r0, r7
c0d01c82:	b289      	uxth	r1, r1
c0d01c84:	f7fe ff5a 	bl	c0d00b3c <io_exchange_al>
  }
}
c0d01c88:	b280      	uxth	r0, r0
c0d01c8a:	b007      	add	sp, #28
c0d01c8c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01c8e:	4c88      	ldr	r4, [pc, #544]	; (c0d01eb0 <io_exchange+0x248>)
c0d01c90:	4889      	ldr	r0, [pc, #548]	; (c0d01eb8 <io_exchange+0x250>)
c0d01c92:	4478      	add	r0, pc
c0d01c94:	9001      	str	r0, [sp, #4]
c0d01c96:	4889      	ldr	r0, [pc, #548]	; (c0d01ebc <io_exchange+0x254>)
c0d01c98:	4478      	add	r0, pc
c0d01c9a:	9006      	str	r0, [sp, #24]
c0d01c9c:	4d83      	ldr	r5, [pc, #524]	; (c0d01eac <io_exchange+0x244>)
c0d01c9e:	4617      	mov	r7, r2
c0d01ca0:	2610      	movs	r6, #16
c0d01ca2:	4016      	ands	r6, r2
    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01ca4:	0408      	lsls	r0, r1, #16
c0d01ca6:	d076      	beq.n	c0d01d96 <io_exchange+0x12e>
c0d01ca8:	2e00      	cmp	r6, #0
c0d01caa:	d174      	bne.n	c0d01d96 <io_exchange+0x12e>
c0d01cac:	9104      	str	r1, [sp, #16]
c0d01cae:	9205      	str	r2, [sp, #20]
      while (io_seproxyhal_spi_is_status_sent()) {
c0d01cb0:	f003 f8f0 	bl	c0d04e94 <io_seph_is_status_sent>
c0d01cb4:	2800      	cmp	r0, #0
c0d01cb6:	d008      	beq.n	c0d01cca <io_exchange+0x62>
c0d01cb8:	2180      	movs	r1, #128	; 0x80
c0d01cba:	2200      	movs	r2, #0
        io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01cbc:	4628      	mov	r0, r5
c0d01cbe:	f003 f8f5 	bl	c0d04eac <io_seph_recv>
c0d01cc2:	2001      	movs	r0, #1
        os_io_seph_recv_and_process(1);
c0d01cc4:	f000 f902 	bl	c0d01ecc <os_io_seph_recv_and_process>
c0d01cc8:	e7f2      	b.n	c0d01cb0 <io_exchange+0x48>
      timeout_ms = G_io_app.ms + IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d01cca:	68a0      	ldr	r0, [r4, #8]
        switch(G_io_app.apdu_state) {
c0d01ccc:	7821      	ldrb	r1, [r4, #0]
c0d01cce:	2909      	cmp	r1, #9
c0d01cd0:	9703      	str	r7, [sp, #12]
c0d01cd2:	dd08      	ble.n	c0d01ce6 <io_exchange+0x7e>
c0d01cd4:	290a      	cmp	r1, #10
c0d01cd6:	9a04      	ldr	r2, [sp, #16]
c0d01cd8:	d00e      	beq.n	c0d01cf8 <io_exchange+0x90>
c0d01cda:	9002      	str	r0, [sp, #8]
c0d01cdc:	290b      	cmp	r1, #11
c0d01cde:	d122      	bne.n	c0d01d26 <io_exchange+0xbe>
c0d01ce0:	4878      	ldr	r0, [pc, #480]	; (c0d01ec4 <io_exchange+0x25c>)
c0d01ce2:	4478      	add	r0, pc
c0d01ce4:	e004      	b.n	c0d01cf0 <io_exchange+0x88>
c0d01ce6:	9002      	str	r0, [sp, #8]
c0d01ce8:	2907      	cmp	r1, #7
c0d01cea:	9801      	ldr	r0, [sp, #4]
c0d01cec:	9a04      	ldr	r2, [sp, #16]
c0d01cee:	d117      	bne.n	c0d01d20 <io_exchange+0xb8>
c0d01cf0:	b291      	uxth	r1, r2
c0d01cf2:	f000 fa23 	bl	c0d0213c <io_usb_hid_send>
c0d01cf6:	e01d      	b.n	c0d01d34 <io_exchange+0xcc>
c0d01cf8:	20ff      	movs	r0, #255	; 0xff
c0d01cfa:	3006      	adds	r0, #6
            if (tx_len > sizeof(G_io_apdu_buffer)) {
c0d01cfc:	b297      	uxth	r7, r2
c0d01cfe:	4287      	cmp	r7, r0
c0d01d00:	d300      	bcc.n	c0d01d04 <io_exchange+0x9c>
c0d01d02:	e0cc      	b.n	c0d01e9e <io_exchange+0x236>
            G_io_seproxyhal_spi_buffer[2]  = (tx_len);
c0d01d04:	70aa      	strb	r2, [r5, #2]
c0d01d06:	2053      	movs	r0, #83	; 0x53
            G_io_seproxyhal_spi_buffer[0]  = SEPROXYHAL_TAG_RAPDU;
c0d01d08:	7028      	strb	r0, [r5, #0]
            G_io_seproxyhal_spi_buffer[1]  = (tx_len)>>8;
c0d01d0a:	0a10      	lsrs	r0, r2, #8
c0d01d0c:	7068      	strb	r0, [r5, #1]
c0d01d0e:	2103      	movs	r1, #3
            io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01d10:	4628      	mov	r0, r5
c0d01d12:	f003 f8b3 	bl	c0d04e7c <io_seph_send>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d01d16:	4867      	ldr	r0, [pc, #412]	; (c0d01eb4 <io_exchange+0x24c>)
c0d01d18:	4639      	mov	r1, r7
c0d01d1a:	f003 f8af 	bl	c0d04e7c <io_seph_send>
c0d01d1e:	e026      	b.n	c0d01d6e <io_exchange+0x106>
        switch(G_io_app.apdu_state) {
c0d01d20:	2900      	cmp	r1, #0
c0d01d22:	d100      	bne.n	c0d01d26 <io_exchange+0xbe>
c0d01d24:	e0b8      	b.n	c0d01e98 <io_exchange+0x230>
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01d26:	b2f8      	uxtb	r0, r7
c0d01d28:	b291      	uxth	r1, r2
c0d01d2a:	f7fe ff07 	bl	c0d00b3c <io_exchange_al>
c0d01d2e:	2800      	cmp	r0, #0
c0d01d30:	d000      	beq.n	c0d01d34 <io_exchange+0xcc>
c0d01d32:	e0b1      	b.n	c0d01e98 <io_exchange+0x230>
        while (G_io_app.apdu_state != APDU_IDLE) {
c0d01d34:	7820      	ldrb	r0, [r4, #0]
c0d01d36:	2800      	cmp	r0, #0
c0d01d38:	d019      	beq.n	c0d01d6e <io_exchange+0x106>
c0d01d3a:	207d      	movs	r0, #125	; 0x7d
c0d01d3c:	0100      	lsls	r0, r0, #4
c0d01d3e:	9902      	ldr	r1, [sp, #8]
c0d01d40:	180f      	adds	r7, r1, r0
c0d01d42:	2105      	movs	r1, #5
  io_seproxyhal_spi_send(seph_io_general_status, sizeof(seph_io_general_status));
c0d01d44:	9806      	ldr	r0, [sp, #24]
c0d01d46:	f003 f899 	bl	c0d04e7c <io_seph_send>
c0d01d4a:	2180      	movs	r1, #128	; 0x80
c0d01d4c:	2200      	movs	r2, #0
            io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01d4e:	4628      	mov	r0, r5
c0d01d50:	f003 f8ac 	bl	c0d04eac <io_seph_recv>
            if (G_io_app.ms >= timeout_ms) {
c0d01d54:	68a0      	ldr	r0, [r4, #8]
c0d01d56:	42b8      	cmp	r0, r7
c0d01d58:	d300      	bcc.n	c0d01d5c <io_exchange+0xf4>
c0d01d5a:	e098      	b.n	c0d01e8e <io_exchange+0x226>
            io_seproxyhal_handle_event();
c0d01d5c:	f7ff fde4 	bl	c0d01928 <io_seproxyhal_handle_event>
          } while (io_seproxyhal_spi_is_status_sent());
c0d01d60:	f003 f898 	bl	c0d04e94 <io_seph_is_status_sent>
c0d01d64:	2800      	cmp	r0, #0
c0d01d66:	d1f0      	bne.n	c0d01d4a <io_exchange+0xe2>
        while (G_io_app.apdu_state != APDU_IDLE) {
c0d01d68:	7820      	ldrb	r0, [r4, #0]
c0d01d6a:	2800      	cmp	r0, #0
c0d01d6c:	d1e9      	bne.n	c0d01d42 <io_exchange+0xda>
c0d01d6e:	2000      	movs	r0, #0
        G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d01d70:	71a0      	strb	r0, [r4, #6]
        G_io_app.apdu_state = APDU_IDLE;
c0d01d72:	7020      	strb	r0, [r4, #0]
        G_io_app.apdu_length = 0;
c0d01d74:	8060      	strh	r0, [r4, #2]
c0d01d76:	9f03      	ldr	r7, [sp, #12]
        if (channel & IO_RETURN_AFTER_TX) {
c0d01d78:	06b9      	lsls	r1, r7, #26
c0d01d7a:	d485      	bmi.n	c0d01c88 <io_exchange+0x20>
  io_seproxyhal_spi_send(seph_io_general_status, sizeof(seph_io_general_status));
c0d01d7c:	4850      	ldr	r0, [pc, #320]	; (c0d01ec0 <io_exchange+0x258>)
c0d01d7e:	4478      	add	r0, pc
c0d01d80:	2105      	movs	r1, #5
c0d01d82:	f003 f87b 	bl	c0d04e7c <io_seph_send>
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01d86:	b278      	sxtb	r0, r7
c0d01d88:	2800      	cmp	r0, #0
c0d01d8a:	9a05      	ldr	r2, [sp, #20]
c0d01d8c:	d503      	bpl.n	c0d01d96 <io_exchange+0x12e>
c0d01d8e:	2005      	movs	r0, #5
        os_sched_exit((bolos_task_status_t)EXCEPTION_IO_RESET);
c0d01d90:	f003 f866 	bl	c0d04e60 <os_sched_exit>
c0d01d94:	9a05      	ldr	r2, [sp, #20]
    if (!(channel&IO_ASYNCH_REPLY)) {
c0d01d96:	2e00      	cmp	r6, #0
c0d01d98:	d104      	bne.n	c0d01da4 <io_exchange+0x13c>
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01d9a:	0650      	lsls	r0, r2, #25
c0d01d9c:	d474      	bmi.n	c0d01e88 <io_exchange+0x220>
c0d01d9e:	2000      	movs	r0, #0
      G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d01da0:	71a0      	strb	r0, [r4, #6]
      G_io_app.apdu_state = APDU_IDLE;
c0d01da2:	7020      	strb	r0, [r4, #0]
c0d01da4:	2000      	movs	r0, #0
c0d01da6:	8060      	strh	r0, [r4, #2]
  io_seproxyhal_spi_send(seph_io_general_status, sizeof(seph_io_general_status));
c0d01da8:	4847      	ldr	r0, [pc, #284]	; (c0d01ec8 <io_exchange+0x260>)
c0d01daa:	4478      	add	r0, pc
c0d01dac:	2105      	movs	r1, #5
c0d01dae:	f003 f865 	bl	c0d04e7c <io_seph_send>
c0d01db2:	2180      	movs	r1, #128	; 0x80
c0d01db4:	2600      	movs	r6, #0
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01db6:	4628      	mov	r0, r5
c0d01db8:	4632      	mov	r2, r6
c0d01dba:	f003 f877 	bl	c0d04eac <io_seph_recv>
      if (rx_len < 3 || rx_len != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])+3U) {
c0d01dbe:	2803      	cmp	r0, #3
c0d01dc0:	d30f      	bcc.n	c0d01de2 <io_exchange+0x17a>
c0d01dc2:	78a9      	ldrb	r1, [r5, #2]
c0d01dc4:	786a      	ldrb	r2, [r5, #1]
c0d01dc6:	0212      	lsls	r2, r2, #8
c0d01dc8:	1851      	adds	r1, r2, r1
c0d01dca:	1cc9      	adds	r1, r1, #3
c0d01dcc:	4281      	cmp	r1, r0
c0d01dce:	d108      	bne.n	c0d01de2 <io_exchange+0x17a>
      io_seproxyhal_handle_event();
c0d01dd0:	f7ff fdaa 	bl	c0d01928 <io_seproxyhal_handle_event>
      if (G_io_app.apdu_state != APDU_IDLE && G_io_app.apdu_length > 0) {
c0d01dd4:	7820      	ldrb	r0, [r4, #0]
c0d01dd6:	2800      	cmp	r0, #0
c0d01dd8:	d0e6      	beq.n	c0d01da8 <io_exchange+0x140>
c0d01dda:	8860      	ldrh	r0, [r4, #2]
c0d01ddc:	2800      	cmp	r0, #0
c0d01dde:	d0e3      	beq.n	c0d01da8 <io_exchange+0x140>
c0d01de0:	e001      	b.n	c0d01de6 <io_exchange+0x17e>
        G_io_app.apdu_state = APDU_IDLE;
c0d01de2:	7026      	strb	r6, [r4, #0]
c0d01de4:	e7de      	b.n	c0d01da4 <io_exchange+0x13c>
c0d01de6:	4a33      	ldr	r2, [pc, #204]	; (c0d01eb4 <io_exchange+0x24c>)
  if (DEFAULT_APDU_CLA == G_io_apdu_buffer[APDU_OFF_CLA]) {
c0d01de8:	7811      	ldrb	r1, [r2, #0]
c0d01dea:	29b0      	cmp	r1, #176	; 0xb0
c0d01dec:	d000      	beq.n	c0d01df0 <io_exchange+0x188>
c0d01dee:	e74b      	b.n	c0d01c88 <io_exchange+0x20>
    switch (G_io_apdu_buffer[APDU_OFF_INS]) {
c0d01df0:	7851      	ldrb	r1, [r2, #1]
c0d01df2:	29a7      	cmp	r1, #167	; 0xa7
c0d01df4:	d00f      	beq.n	c0d01e16 <io_exchange+0x1ae>
c0d01df6:	2902      	cmp	r1, #2
c0d01df8:	d01d      	beq.n	c0d01e36 <io_exchange+0x1ce>
c0d01dfa:	2901      	cmp	r1, #1
c0d01dfc:	d000      	beq.n	c0d01e00 <io_exchange+0x198>
c0d01dfe:	e743      	b.n	c0d01c88 <io_exchange+0x20>
        if (!G_io_apdu_buffer[APDU_OFF_P1] && !G_io_apdu_buffer[APDU_OFF_P2]) {
c0d01e00:	7891      	ldrb	r1, [r2, #2]
c0d01e02:	78d2      	ldrb	r2, [r2, #3]
c0d01e04:	430a      	orrs	r2, r1
c0d01e06:	d000      	beq.n	c0d01e0a <io_exchange+0x1a2>
c0d01e08:	e73e      	b.n	c0d01c88 <io_exchange+0x20>
c0d01e0a:	2007      	movs	r0, #7
          *channel &= ~IO_FLAGS;
c0d01e0c:	4007      	ands	r7, r0
          *tx_len = os_io_seproxyhal_get_app_name_and_version();
c0d01e0e:	f7ff ff07 	bl	c0d01c20 <os_io_seproxyhal_get_app_name_and_version>
c0d01e12:	4601      	mov	r1, r0
c0d01e14:	e033      	b.n	c0d01e7e <io_exchange+0x216>
        if (!G_io_apdu_buffer[APDU_OFF_P1] && !G_io_apdu_buffer[APDU_OFF_P2]) {
c0d01e16:	7891      	ldrb	r1, [r2, #2]
c0d01e18:	78d2      	ldrb	r2, [r2, #3]
c0d01e1a:	430a      	orrs	r2, r1
c0d01e1c:	d000      	beq.n	c0d01e20 <io_exchange+0x1b8>
c0d01e1e:	e733      	b.n	c0d01c88 <io_exchange+0x20>
c0d01e20:	4924      	ldr	r1, [pc, #144]	; (c0d01eb4 <io_exchange+0x24c>)
          G_io_apdu_buffer[(*tx_len)++] = 0x00;
c0d01e22:	704e      	strb	r6, [r1, #1]
c0d01e24:	2090      	movs	r0, #144	; 0x90
          G_io_apdu_buffer[(*tx_len)++] = 0x90;
c0d01e26:	7008      	strb	r0, [r1, #0]
c0d01e28:	2007      	movs	r0, #7
          *channel &= ~IO_FLAGS;
c0d01e2a:	4007      	ands	r7, r0
c0d01e2c:	207f      	movs	r0, #127	; 0x7f
c0d01e2e:	43c0      	mvns	r0, r0
          *channel |= IO_RESET_AFTER_REPLIED;
c0d01e30:	183f      	adds	r7, r7, r0
c0d01e32:	2102      	movs	r1, #2
c0d01e34:	e023      	b.n	c0d01e7e <io_exchange+0x216>
        if (!G_io_apdu_buffer[APDU_OFF_P1] && !G_io_apdu_buffer[APDU_OFF_P2]) {
c0d01e36:	7891      	ldrb	r1, [r2, #2]
c0d01e38:	78d2      	ldrb	r2, [r2, #3]
c0d01e3a:	430a      	orrs	r2, r1
c0d01e3c:	d000      	beq.n	c0d01e40 <io_exchange+0x1d8>
c0d01e3e:	e723      	b.n	c0d01c88 <io_exchange+0x20>
          if (os_global_pin_is_validated() == BOLOS_UX_OK) {
c0d01e40:	f002 ffc2 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d01e44:	28aa      	cmp	r0, #170	; 0xaa
c0d01e46:	d112      	bne.n	c0d01e6e <io_exchange+0x206>
c0d01e48:	2001      	movs	r0, #1
c0d01e4a:	491a      	ldr	r1, [pc, #104]	; (c0d01eb4 <io_exchange+0x24c>)
            G_io_apdu_buffer[(*tx_len)++] = 0x01;
c0d01e4c:	7008      	strb	r0, [r1, #0]
            i = os_perso_seed_cookie(G_io_apdu_buffer+1+1, MIN(64,sizeof(G_io_apdu_buffer)-1-1-2));
c0d01e4e:	1c88      	adds	r0, r1, #2
c0d01e50:	2140      	movs	r1, #64	; 0x40
c0d01e52:	f002 ffad 	bl	c0d04db0 <os_perso_seed_cookie>
c0d01e56:	4b17      	ldr	r3, [pc, #92]	; (c0d01eb4 <io_exchange+0x24c>)
            G_io_apdu_buffer[(*tx_len)++] = i;
c0d01e58:	7058      	strb	r0, [r3, #1]
            *tx_len += i;
c0d01e5a:	1c81      	adds	r1, r0, #2
            G_io_apdu_buffer[(*tx_len)++] = 0x90;
c0d01e5c:	b289      	uxth	r1, r1
c0d01e5e:	2290      	movs	r2, #144	; 0x90
c0d01e60:	545a      	strb	r2, [r3, r1]
c0d01e62:	461a      	mov	r2, r3
c0d01e64:	1cc1      	adds	r1, r0, #3
            G_io_apdu_buffer[(*tx_len)++] = 0x00;
c0d01e66:	b289      	uxth	r1, r1
c0d01e68:	545e      	strb	r6, [r3, r1]
c0d01e6a:	1d01      	adds	r1, r0, #4
c0d01e6c:	e005      	b.n	c0d01e7a <io_exchange+0x212>
c0d01e6e:	2085      	movs	r0, #133	; 0x85
c0d01e70:	4910      	ldr	r1, [pc, #64]	; (c0d01eb4 <io_exchange+0x24c>)
            G_io_apdu_buffer[(*tx_len)++] = 0x85;
c0d01e72:	7048      	strb	r0, [r1, #1]
c0d01e74:	2069      	movs	r0, #105	; 0x69
            G_io_apdu_buffer[(*tx_len)++] = 0x69;
c0d01e76:	7008      	strb	r0, [r1, #0]
c0d01e78:	2102      	movs	r1, #2
c0d01e7a:	2007      	movs	r0, #7
          *channel &= ~IO_FLAGS;
c0d01e7c:	4007      	ands	r7, r0
  switch(channel&~(IO_FLAGS)) {
c0d01e7e:	b2fa      	uxtb	r2, r7
c0d01e80:	0778      	lsls	r0, r7, #29
c0d01e82:	d100      	bne.n	c0d01e86 <io_exchange+0x21e>
c0d01e84:	e70c      	b.n	c0d01ca0 <io_exchange+0x38>
c0d01e86:	e6fb      	b.n	c0d01c80 <io_exchange+0x18>
        return G_io_app.apdu_length-5;
c0d01e88:	8860      	ldrh	r0, [r4, #2]
c0d01e8a:	1f40      	subs	r0, r0, #5
c0d01e8c:	e6fc      	b.n	c0d01c88 <io_exchange+0x20>
c0d01e8e:	2005      	movs	r0, #5
              THROW(EXCEPTION_IO_RESET);
c0d01e90:	f7ff fbc9 	bl	c0d01626 <os_longjmp>
    io_seproxyhal_se_reset();
c0d01e94:	f7ff febc 	bl	c0d01c10 <io_seproxyhal_se_reset>
c0d01e98:	2004      	movs	r0, #4
            THROW(INVALID_STATE);
c0d01e9a:	f7ff fbc4 	bl	c0d01626 <os_longjmp>
c0d01e9e:	2002      	movs	r0, #2
              THROW(INVALID_PARAMETER);
c0d01ea0:	f7ff fbc1 	bl	c0d01626 <os_longjmp>
c0d01ea4:	20000648 	.word	0x20000648
c0d01ea8:	dead0031 	.word	0xdead0031
c0d01eac:	20000202 	.word	0x20000202
c0d01eb0:	200003b4 	.word	0x200003b4
c0d01eb4:	200002b0 	.word	0x200002b0
c0d01eb8:	fffffc73 	.word	0xfffffc73
c0d01ebc:	00005bc8 	.word	0x00005bc8
c0d01ec0:	00005ae2 	.word	0x00005ae2
c0d01ec4:	fffffc33 	.word	0xfffffc33
c0d01ec8:	00005ab6 	.word	0x00005ab6

c0d01ecc <os_io_seph_recv_and_process>:

unsigned int os_io_seph_recv_and_process(unsigned int dont_process_ux_events) {
c0d01ecc:	b5b0      	push	{r4, r5, r7, lr}
c0d01ece:	4604      	mov	r4, r0
  io_seproxyhal_spi_send(seph_io_general_status, sizeof(seph_io_general_status));
c0d01ed0:	480f      	ldr	r0, [pc, #60]	; (c0d01f10 <os_io_seph_recv_and_process+0x44>)
c0d01ed2:	4478      	add	r0, pc
c0d01ed4:	2105      	movs	r1, #5
c0d01ed6:	f002 ffd1 	bl	c0d04e7c <io_seph_send>
  // send general status before receiving next event
  io_seproxyhal_general_status();

  io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01eda:	4d0b      	ldr	r5, [pc, #44]	; (c0d01f08 <os_io_seph_recv_and_process+0x3c>)
c0d01edc:	2180      	movs	r1, #128	; 0x80
c0d01ede:	2200      	movs	r2, #0
c0d01ee0:	4628      	mov	r0, r5
c0d01ee2:	f002 ffe3 	bl	c0d04eac <io_seph_recv>

  switch (G_io_seproxyhal_spi_buffer[0]) {
c0d01ee6:	7828      	ldrb	r0, [r5, #0]
c0d01ee8:	2815      	cmp	r0, #21
c0d01eea:	d808      	bhi.n	c0d01efe <os_io_seph_recv_and_process+0x32>
c0d01eec:	2101      	movs	r1, #1
c0d01eee:	4081      	lsls	r1, r0
c0d01ef0:	4806      	ldr	r0, [pc, #24]	; (c0d01f0c <os_io_seph_recv_and_process+0x40>)
c0d01ef2:	4201      	tst	r1, r0
c0d01ef4:	d003      	beq.n	c0d01efe <os_io_seph_recv_and_process+0x32>
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
    case SEPROXYHAL_TAG_TICKER_EVENT:
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
    case SEPROXYHAL_TAG_STATUS_EVENT:
      // perform UX event on these ones, don't process as an IO event
      if (dont_process_ux_events) {
c0d01ef6:	2c00      	cmp	r4, #0
c0d01ef8:	d001      	beq.n	c0d01efe <os_io_seph_recv_and_process+0x32>
c0d01efa:	2000      	movs	r0, #0
      if (io_seproxyhal_handle_event()) {
        return 1;
      }
  }
  return 0;
}
c0d01efc:	bdb0      	pop	{r4, r5, r7, pc}
      if (io_seproxyhal_handle_event()) {
c0d01efe:	f7ff fd13 	bl	c0d01928 <io_seproxyhal_handle_event>
c0d01f02:	1e41      	subs	r1, r0, #1
c0d01f04:	4188      	sbcs	r0, r1
c0d01f06:	bdb0      	pop	{r4, r5, r7, pc}
c0d01f08:	20000202 	.word	0x20000202
c0d01f0c:	00207020 	.word	0x00207020
c0d01f10:	0000598e 	.word	0x0000598e

c0d01f14 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_channel;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d01f14:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01f16:	b081      	sub	sp, #4
c0d01f18:	9200      	str	r2, [sp, #0]
c0d01f1a:	4605      	mov	r5, r0
  // avoid over/under flows
  if (buffer != G_io_usb_ep_buffer) {
c0d01f1c:	4c4a      	ldr	r4, [pc, #296]	; (c0d02048 <io_usb_hid_receive+0x134>)
c0d01f1e:	42a1      	cmp	r1, r4
c0d01f20:	d00f      	beq.n	c0d01f42 <io_usb_hid_receive+0x2e>
c0d01f22:	460f      	mov	r7, r1
    memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
c0d01f24:	4c48      	ldr	r4, [pc, #288]	; (c0d02048 <io_usb_hid_receive+0x134>)
c0d01f26:	2640      	movs	r6, #64	; 0x40
c0d01f28:	4620      	mov	r0, r4
c0d01f2a:	4631      	mov	r1, r6
c0d01f2c:	f005 f9ec 	bl	c0d07308 <__aeabi_memclr>
c0d01f30:	9a00      	ldr	r2, [sp, #0]
    memmove(G_io_usb_ep_buffer, buffer, MIN(l, sizeof(G_io_usb_ep_buffer)));
c0d01f32:	2a40      	cmp	r2, #64	; 0x40
c0d01f34:	d300      	bcc.n	c0d01f38 <io_usb_hid_receive+0x24>
c0d01f36:	4632      	mov	r2, r6
c0d01f38:	4620      	mov	r0, r4
c0d01f3a:	4639      	mov	r1, r7
c0d01f3c:	f005 f9ee 	bl	c0d0731c <__aeabi_memmove>
c0d01f40:	4c41      	ldr	r4, [pc, #260]	; (c0d02048 <io_usb_hid_receive+0x134>)
  }

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
c0d01f42:	78a0      	ldrb	r0, [r4, #2]
c0d01f44:	2801      	cmp	r0, #1
c0d01f46:	dc0a      	bgt.n	c0d01f5e <io_usb_hid_receive+0x4a>
c0d01f48:	2800      	cmp	r0, #0
c0d01f4a:	d02e      	beq.n	c0d01faa <io_usb_hid_receive+0x96>
c0d01f4c:	2801      	cmp	r0, #1
c0d01f4e:	d16a      	bne.n	c0d02026 <io_usb_hid_receive+0x112>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng_no_throw(G_io_usb_ep_buffer+3, 4);
c0d01f50:	1ce0      	adds	r0, r4, #3
c0d01f52:	2104      	movs	r1, #4
c0d01f54:	f7ff fb52 	bl	c0d015fc <cx_rng_no_throw>
c0d01f58:	2140      	movs	r1, #64	; 0x40
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01f5a:	4620      	mov	r0, r4
c0d01f5c:	e030      	b.n	c0d01fc0 <io_usb_hid_receive+0xac>
  switch(G_io_usb_ep_buffer[2]) {
c0d01f5e:	2802      	cmp	r0, #2
c0d01f60:	d02c      	beq.n	c0d01fbc <io_usb_hid_receive+0xa8>
c0d01f62:	2805      	cmp	r0, #5
c0d01f64:	d15f      	bne.n	c0d02026 <io_usb_hid_receive+0x112>
c0d01f66:	7920      	ldrb	r0, [r4, #4]
c0d01f68:	78e1      	ldrb	r1, [r4, #3]
c0d01f6a:	0209      	lsls	r1, r1, #8
c0d01f6c:	1808      	adds	r0, r1, r0
    if ((unsigned int)U2BE(G_io_usb_ep_buffer, 3) != (unsigned int)G_io_usb_hid_sequence_number) {
c0d01f6e:	4e37      	ldr	r6, [pc, #220]	; (c0d0204c <io_usb_hid_receive+0x138>)
c0d01f70:	6831      	ldr	r1, [r6, #0]
c0d01f72:	2700      	movs	r7, #0
c0d01f74:	4281      	cmp	r1, r0
c0d01f76:	d15d      	bne.n	c0d02034 <io_usb_hid_receive+0x120>
    if (G_io_usb_hid_sequence_number == 0) {
c0d01f78:	6830      	ldr	r0, [r6, #0]
c0d01f7a:	2800      	cmp	r0, #0
c0d01f7c:	d023      	beq.n	c0d01fc6 <io_usb_hid_receive+0xb2>
c0d01f7e:	9800      	ldr	r0, [sp, #0]
c0d01f80:	1f40      	subs	r0, r0, #5
      if (l > G_io_usb_hid_remaining_length) {
c0d01f82:	b282      	uxth	r2, r0
c0d01f84:	4932      	ldr	r1, [pc, #200]	; (c0d02050 <io_usb_hid_receive+0x13c>)
c0d01f86:	680b      	ldr	r3, [r1, #0]
c0d01f88:	4293      	cmp	r3, r2
c0d01f8a:	d200      	bcs.n	c0d01f8e <io_usb_hid_receive+0x7a>
        l = G_io_usb_hid_remaining_length;
c0d01f8c:	6808      	ldr	r0, [r1, #0]
c0d01f8e:	4622      	mov	r2, r4
      if (l > sizeof(G_io_usb_ep_buffer) - 5) {
c0d01f90:	b281      	uxth	r1, r0
c0d01f92:	293b      	cmp	r1, #59	; 0x3b
c0d01f94:	d300      	bcc.n	c0d01f98 <io_usb_hid_receive+0x84>
c0d01f96:	203b      	movs	r0, #59	; 0x3b
      memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
c0d01f98:	b285      	uxth	r5, r0
c0d01f9a:	4c2e      	ldr	r4, [pc, #184]	; (c0d02054 <io_usb_hid_receive+0x140>)
c0d01f9c:	6820      	ldr	r0, [r4, #0]
c0d01f9e:	1d51      	adds	r1, r2, #5
c0d01fa0:	462a      	mov	r2, r5
c0d01fa2:	f005 f9bb 	bl	c0d0731c <__aeabi_memmove>
    G_io_usb_hid_current_buffer += l;
c0d01fa6:	6824      	ldr	r4, [r4, #0]
c0d01fa8:	e033      	b.n	c0d02012 <io_usb_hid_receive+0xfe>
c0d01faa:	2700      	movs	r7, #0
    memset(G_io_usb_ep_buffer+3, 0, 4); // PROTOCOL VERSION is 0
c0d01fac:	71a7      	strb	r7, [r4, #6]
c0d01fae:	7167      	strb	r7, [r4, #5]
c0d01fb0:	7127      	strb	r7, [r4, #4]
c0d01fb2:	70e7      	strb	r7, [r4, #3]
c0d01fb4:	2140      	movs	r1, #64	; 0x40
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01fb6:	4620      	mov	r0, r4
c0d01fb8:	47a8      	blx	r5
c0d01fba:	e03b      	b.n	c0d02034 <io_usb_hid_receive+0x120>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01fbc:	4822      	ldr	r0, [pc, #136]	; (c0d02048 <io_usb_hid_receive+0x134>)
c0d01fbe:	2140      	movs	r1, #64	; 0x40
c0d01fc0:	47a8      	blx	r5
c0d01fc2:	2700      	movs	r7, #0
c0d01fc4:	e036      	b.n	c0d02034 <io_usb_hid_receive+0x120>
c0d01fc6:	79a0      	ldrb	r0, [r4, #6]
c0d01fc8:	7961      	ldrb	r1, [r4, #5]
c0d01fca:	0209      	lsls	r1, r1, #8
c0d01fcc:	1809      	adds	r1, r1, r0
      G_io_usb_hid_total_length = U2BE(G_io_usb_ep_buffer, 5); //(G_io_usb_ep_buffer[5]<<8)+(G_io_usb_ep_buffer[6]&0xFF);
c0d01fce:	4822      	ldr	r0, [pc, #136]	; (c0d02058 <io_usb_hid_receive+0x144>)
c0d01fd0:	6001      	str	r1, [r0, #0]
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d01fd2:	6801      	ldr	r1, [r0, #0]
c0d01fd4:	2241      	movs	r2, #65	; 0x41
c0d01fd6:	0092      	lsls	r2, r2, #2
c0d01fd8:	4291      	cmp	r1, r2
c0d01fda:	d82b      	bhi.n	c0d02034 <io_usb_hid_receive+0x120>
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d01fdc:	6800      	ldr	r0, [r0, #0]
c0d01fde:	491c      	ldr	r1, [pc, #112]	; (c0d02050 <io_usb_hid_receive+0x13c>)
c0d01fe0:	6008      	str	r0, [r1, #0]
c0d01fe2:	7860      	ldrb	r0, [r4, #1]
c0d01fe4:	7822      	ldrb	r2, [r4, #0]
c0d01fe6:	0212      	lsls	r2, r2, #8
c0d01fe8:	1810      	adds	r0, r2, r0
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);
c0d01fea:	4a1c      	ldr	r2, [pc, #112]	; (c0d0205c <io_usb_hid_receive+0x148>)
c0d01fec:	6010      	str	r0, [r2, #0]
      if (l > G_io_usb_hid_remaining_length) {
c0d01fee:	680a      	ldr	r2, [r1, #0]
      l -= 2;
c0d01ff0:	9800      	ldr	r0, [sp, #0]
c0d01ff2:	1fc0      	subs	r0, r0, #7
      if (l > G_io_usb_hid_remaining_length) {
c0d01ff4:	b283      	uxth	r3, r0
c0d01ff6:	429a      	cmp	r2, r3
c0d01ff8:	d200      	bcs.n	c0d01ffc <io_usb_hid_receive+0xe8>
        l = G_io_usb_hid_remaining_length;
c0d01ffa:	6808      	ldr	r0, [r1, #0]
      if (l > sizeof(G_io_usb_ep_buffer) - 7) {
c0d01ffc:	b281      	uxth	r1, r0
c0d01ffe:	2939      	cmp	r1, #57	; 0x39
c0d02000:	d300      	bcc.n	c0d02004 <io_usb_hid_receive+0xf0>
c0d02002:	2039      	movs	r0, #57	; 0x39
      memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
c0d02004:	b285      	uxth	r5, r0
c0d02006:	1de1      	adds	r1, r4, #7
c0d02008:	4c15      	ldr	r4, [pc, #84]	; (c0d02060 <io_usb_hid_receive+0x14c>)
c0d0200a:	4620      	mov	r0, r4
c0d0200c:	462a      	mov	r2, r5
c0d0200e:	f005 f981 	bl	c0d07314 <__aeabi_memcpy>
    G_io_usb_hid_remaining_length -= l;
c0d02012:	480f      	ldr	r0, [pc, #60]	; (c0d02050 <io_usb_hid_receive+0x13c>)
c0d02014:	6801      	ldr	r1, [r0, #0]
c0d02016:	1b49      	subs	r1, r1, r5
c0d02018:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_current_buffer += l;
c0d0201a:	1960      	adds	r0, r4, r5
c0d0201c:	490d      	ldr	r1, [pc, #52]	; (c0d02054 <io_usb_hid_receive+0x140>)
c0d0201e:	6008      	str	r0, [r1, #0]
    G_io_usb_hid_sequence_number++;
c0d02020:	6830      	ldr	r0, [r6, #0]
c0d02022:	1c40      	adds	r0, r0, #1
c0d02024:	6030      	str	r0, [r6, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d02026:	480a      	ldr	r0, [pc, #40]	; (c0d02050 <io_usb_hid_receive+0x13c>)
c0d02028:	6800      	ldr	r0, [r0, #0]
c0d0202a:	2800      	cmp	r0, #0
c0d0202c:	d001      	beq.n	c0d02032 <io_usb_hid_receive+0x11e>
c0d0202e:	2701      	movs	r7, #1
c0d02030:	e007      	b.n	c0d02042 <io_usb_hid_receive+0x12e>
c0d02032:	2702      	movs	r7, #2
c0d02034:	4805      	ldr	r0, [pc, #20]	; (c0d0204c <io_usb_hid_receive+0x138>)
c0d02036:	2100      	movs	r1, #0
c0d02038:	6001      	str	r1, [r0, #0]
c0d0203a:	4806      	ldr	r0, [pc, #24]	; (c0d02054 <io_usb_hid_receive+0x140>)
c0d0203c:	6001      	str	r1, [r0, #0]
c0d0203e:	4804      	ldr	r0, [pc, #16]	; (c0d02050 <io_usb_hid_receive+0x13c>)
c0d02040:	6001      	str	r1, [r0, #0]
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d02042:	4638      	mov	r0, r7
c0d02044:	b001      	add	sp, #4
c0d02046:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02048:	200003e0 	.word	0x200003e0
c0d0204c:	20000420 	.word	0x20000420
c0d02050:	20000428 	.word	0x20000428
c0d02054:	2000042c 	.word	0x2000042c
c0d02058:	20000424 	.word	0x20000424
c0d0205c:	20000430 	.word	0x20000430
c0d02060:	200002b0 	.word	0x200002b0

c0d02064 <io_usb_hid_init>:

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d02064:	4803      	ldr	r0, [pc, #12]	; (c0d02074 <io_usb_hid_init+0x10>)
c0d02066:	2100      	movs	r1, #0
c0d02068:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
  G_io_usb_hid_current_buffer = NULL;
c0d0206a:	4803      	ldr	r0, [pc, #12]	; (c0d02078 <io_usb_hid_init+0x14>)
c0d0206c:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
c0d0206e:	4803      	ldr	r0, [pc, #12]	; (c0d0207c <io_usb_hid_init+0x18>)
c0d02070:	6001      	str	r1, [r0, #0]
}
c0d02072:	4770      	bx	lr
c0d02074:	20000420 	.word	0x20000420
c0d02078:	2000042c 	.word	0x2000042c
c0d0207c:	20000428 	.word	0x20000428

c0d02080 <io_usb_hid_sent>:

/**
 * sent the next io_usb_hid transport chunk (rx on the host, tx on the device)
 */
void io_usb_hid_sent(io_send_t sndfct) {
c0d02080:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02082:	b081      	sub	sp, #4
c0d02084:	4a27      	ldr	r2, [pc, #156]	; (c0d02124 <io_usb_hid_sent+0xa4>)
c0d02086:	6815      	ldr	r5, [r2, #0]
  unsigned int l;

  // only prepare next chunk if some data to be sent remain
  if (G_io_usb_hid_remaining_length && G_io_usb_hid_current_buffer) {
c0d02088:	4b27      	ldr	r3, [pc, #156]	; (c0d02128 <io_usb_hid_sent+0xa8>)
c0d0208a:	6819      	ldr	r1, [r3, #0]
c0d0208c:	2900      	cmp	r1, #0
c0d0208e:	d021      	beq.n	c0d020d4 <io_usb_hid_sent+0x54>
c0d02090:	2d00      	cmp	r5, #0
c0d02092:	d01f      	beq.n	c0d020d4 <io_usb_hid_sent+0x54>
c0d02094:	9000      	str	r0, [sp, #0]
    // fill the chunk
    memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
c0d02096:	4c27      	ldr	r4, [pc, #156]	; (c0d02134 <io_usb_hid_sent+0xb4>)
c0d02098:	1d67      	adds	r7, r4, #5
c0d0209a:	263b      	movs	r6, #59	; 0x3b
c0d0209c:	4638      	mov	r0, r7
c0d0209e:	4631      	mov	r1, r6
c0d020a0:	f005 f932 	bl	c0d07308 <__aeabi_memclr>
c0d020a4:	4a20      	ldr	r2, [pc, #128]	; (c0d02128 <io_usb_hid_sent+0xa8>)
c0d020a6:	2005      	movs	r0, #5

    // keep the channel identifier
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
    G_io_usb_ep_buffer[2] = 0x05;
c0d020a8:	70a0      	strb	r0, [r4, #2]
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
c0d020aa:	4823      	ldr	r0, [pc, #140]	; (c0d02138 <io_usb_hid_sent+0xb8>)
c0d020ac:	6801      	ldr	r1, [r0, #0]
c0d020ae:	0a09      	lsrs	r1, r1, #8
c0d020b0:	7021      	strb	r1, [r4, #0]
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
c0d020b2:	6800      	ldr	r0, [r0, #0]
c0d020b4:	7060      	strb	r0, [r4, #1]
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
c0d020b6:	491d      	ldr	r1, [pc, #116]	; (c0d0212c <io_usb_hid_sent+0xac>)
c0d020b8:	6808      	ldr	r0, [r1, #0]
c0d020ba:	0a00      	lsrs	r0, r0, #8
c0d020bc:	70e0      	strb	r0, [r4, #3]
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;
c0d020be:	6808      	ldr	r0, [r1, #0]
c0d020c0:	7120      	strb	r0, [r4, #4]

    if (G_io_usb_hid_sequence_number == 0) {
c0d020c2:	6809      	ldr	r1, [r1, #0]
c0d020c4:	6810      	ldr	r0, [r2, #0]
c0d020c6:	2900      	cmp	r1, #0
c0d020c8:	d00c      	beq.n	c0d020e4 <io_usb_hid_sent+0x64>
      memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;
    }
    else {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : G_io_usb_hid_remaining_length);
c0d020ca:	283b      	cmp	r0, #59	; 0x3b
c0d020cc:	d800      	bhi.n	c0d020d0 <io_usb_hid_sent+0x50>
c0d020ce:	6816      	ldr	r6, [r2, #0]
      memmove(G_io_usb_ep_buffer+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d020d0:	4638      	mov	r0, r7
c0d020d2:	e012      	b.n	c0d020fa <io_usb_hid_sent+0x7a>
  G_io_usb_hid_sequence_number = 0; 
c0d020d4:	4815      	ldr	r0, [pc, #84]	; (c0d0212c <io_usb_hid_sent+0xac>)
c0d020d6:	2100      	movs	r1, #0
c0d020d8:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_current_buffer = NULL;
c0d020da:	6011      	str	r1, [r2, #0]
  // cleanup when everything has been sent (ack for the last sent usb in packet)
  else {
    io_usb_hid_init();

    // we sent the whole response
    G_io_app.apdu_state = APDU_IDLE;
c0d020dc:	4814      	ldr	r0, [pc, #80]	; (c0d02130 <io_usb_hid_sent+0xb0>)
c0d020de:	7001      	strb	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
c0d020e0:	6019      	str	r1, [r3, #0]
c0d020e2:	e01d      	b.n	c0d02120 <io_usb_hid_sent+0xa0>
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : G_io_usb_hid_remaining_length);
c0d020e4:	2839      	cmp	r0, #57	; 0x39
c0d020e6:	d901      	bls.n	c0d020ec <io_usb_hid_sent+0x6c>
c0d020e8:	2639      	movs	r6, #57	; 0x39
c0d020ea:	e000      	b.n	c0d020ee <io_usb_hid_sent+0x6e>
c0d020ec:	6816      	ldr	r6, [r2, #0]
      G_io_usb_ep_buffer[5] = G_io_usb_hid_remaining_length>>8;
c0d020ee:	6810      	ldr	r0, [r2, #0]
c0d020f0:	0a00      	lsrs	r0, r0, #8
c0d020f2:	7160      	strb	r0, [r4, #5]
      G_io_usb_ep_buffer[6] = G_io_usb_hid_remaining_length;
c0d020f4:	6810      	ldr	r0, [r2, #0]
c0d020f6:	71a0      	strb	r0, [r4, #6]
      memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d020f8:	1de0      	adds	r0, r4, #7
c0d020fa:	4629      	mov	r1, r5
c0d020fc:	4632      	mov	r2, r6
c0d020fe:	f005 f90d 	bl	c0d0731c <__aeabi_memmove>
c0d02102:	4b09      	ldr	r3, [pc, #36]	; (c0d02128 <io_usb_hid_sent+0xa8>)
c0d02104:	9a00      	ldr	r2, [sp, #0]
c0d02106:	4907      	ldr	r1, [pc, #28]	; (c0d02124 <io_usb_hid_sent+0xa4>)
c0d02108:	6818      	ldr	r0, [r3, #0]
c0d0210a:	1b80      	subs	r0, r0, r6
c0d0210c:	6018      	str	r0, [r3, #0]
c0d0210e:	19a8      	adds	r0, r5, r6
c0d02110:	6008      	str	r0, [r1, #0]
c0d02112:	4906      	ldr	r1, [pc, #24]	; (c0d0212c <io_usb_hid_sent+0xac>)
    G_io_usb_hid_sequence_number++;
c0d02114:	6808      	ldr	r0, [r1, #0]
c0d02116:	1c40      	adds	r0, r0, #1
c0d02118:	6008      	str	r0, [r1, #0]
    sndfct(G_io_usb_ep_buffer, sizeof(G_io_usb_ep_buffer));
c0d0211a:	4806      	ldr	r0, [pc, #24]	; (c0d02134 <io_usb_hid_sent+0xb4>)
c0d0211c:	2140      	movs	r1, #64	; 0x40
c0d0211e:	4790      	blx	r2
  }
}
c0d02120:	b001      	add	sp, #4
c0d02122:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02124:	2000042c 	.word	0x2000042c
c0d02128:	20000428 	.word	0x20000428
c0d0212c:	20000420 	.word	0x20000420
c0d02130:	200003b4 	.word	0x200003b4
c0d02134:	200003e0 	.word	0x200003e0
c0d02138:	20000430 	.word	0x20000430

c0d0213c <io_usb_hid_send>:

void io_usb_hid_send(io_send_t sndfct, unsigned short sndlength) {
c0d0213c:	b580      	push	{r7, lr}
  // perform send
  if (sndlength) {
c0d0213e:	2900      	cmp	r1, #0
c0d02140:	d00b      	beq.n	c0d0215a <io_usb_hid_send+0x1e>
    G_io_usb_hid_sequence_number = 0; 
c0d02142:	4a06      	ldr	r2, [pc, #24]	; (c0d0215c <io_usb_hid_send+0x20>)
c0d02144:	2300      	movs	r3, #0
c0d02146:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
    G_io_usb_hid_remaining_length = sndlength;
c0d02148:	4a05      	ldr	r2, [pc, #20]	; (c0d02160 <io_usb_hid_send+0x24>)
c0d0214a:	6011      	str	r1, [r2, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d0214c:	4a05      	ldr	r2, [pc, #20]	; (c0d02164 <io_usb_hid_send+0x28>)
c0d0214e:	4b06      	ldr	r3, [pc, #24]	; (c0d02168 <io_usb_hid_send+0x2c>)
c0d02150:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_total_length = sndlength;
c0d02152:	4a06      	ldr	r2, [pc, #24]	; (c0d0216c <io_usb_hid_send+0x30>)
c0d02154:	6011      	str	r1, [r2, #0]
    io_usb_hid_sent(sndfct);
c0d02156:	f7ff ff93 	bl	c0d02080 <io_usb_hid_sent>
  }
}
c0d0215a:	bd80      	pop	{r7, pc}
c0d0215c:	20000420 	.word	0x20000420
c0d02160:	20000428 	.word	0x20000428
c0d02164:	2000042c 	.word	0x2000042c
c0d02168:	200002b0 	.word	0x200002b0
c0d0216c:	20000424 	.word	0x20000424

c0d02170 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d02170:	b081      	sub	sp, #4
c0d02172:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02174:	b090      	sub	sp, #64	; 0x40
c0d02176:	9315      	str	r3, [sp, #84]	; 0x54
c0d02178:	9009      	str	r0, [sp, #36]	; 0x24
    char cStrlenSet;

    //
    // Check the arguments.
    //
    if(str == NULL ||str_size < 2) {
c0d0217a:	2800      	cmp	r0, #0
c0d0217c:	d100      	bne.n	c0d02180 <snprintf+0x10>
c0d0217e:	e1ad      	b.n	c0d024dc <snprintf+0x36c>
c0d02180:	460d      	mov	r5, r1
c0d02182:	2902      	cmp	r1, #2
c0d02184:	d200      	bcs.n	c0d02188 <snprintf+0x18>
c0d02186:	e1a9      	b.n	c0d024dc <snprintf+0x36c>
c0d02188:	4614      	mov	r4, r2
      return 0;
    }

    // ensure terminating string with a \0
    memset(str, 0, str_size);
c0d0218a:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d0218c:	4629      	mov	r1, r5
c0d0218e:	f005 f8bb 	bl	c0d07308 <__aeabi_memclr>
c0d02192:	a815      	add	r0, sp, #84	; 0x54


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d02194:	900b      	str	r0, [sp, #44]	; 0x2c

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d02196:	7820      	ldrb	r0, [r4, #0]
c0d02198:	2800      	cmp	r0, #0
c0d0219a:	d100      	bne.n	c0d0219e <snprintf+0x2e>
c0d0219c:	e19e      	b.n	c0d024dc <snprintf+0x36c>
    str_size--;
c0d0219e:	1e69      	subs	r1, r5, #1
c0d021a0:	9108      	str	r1, [sp, #32]
c0d021a2:	2101      	movs	r1, #1
c0d021a4:	9106      	str	r1, [sp, #24]
c0d021a6:	2600      	movs	r6, #0
c0d021a8:	9d08      	ldr	r5, [sp, #32]
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d021aa:	2800      	cmp	r0, #0
c0d021ac:	d005      	beq.n	c0d021ba <snprintf+0x4a>
c0d021ae:	2825      	cmp	r0, #37	; 0x25
c0d021b0:	d003      	beq.n	c0d021ba <snprintf+0x4a>
c0d021b2:	19a0      	adds	r0, r4, r6
c0d021b4:	7840      	ldrb	r0, [r0, #1]
            ulIdx++)
c0d021b6:	1c76      	adds	r6, r6, #1
c0d021b8:	e7f7      	b.n	c0d021aa <snprintf+0x3a>
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d021ba:	42ae      	cmp	r6, r5
c0d021bc:	d300      	bcc.n	c0d021c0 <snprintf+0x50>
c0d021be:	462e      	mov	r6, r5
        memmove(str, format, ulIdx);
c0d021c0:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d021c2:	4621      	mov	r1, r4
c0d021c4:	4632      	mov	r2, r6
c0d021c6:	f005 f8a9 	bl	c0d0731c <__aeabi_memmove>
        str+= ulIdx;
        str_size -= ulIdx;
c0d021ca:	1bad      	subs	r5, r5, r6
c0d021cc:	9508      	str	r5, [sp, #32]
c0d021ce:	d100      	bne.n	c0d021d2 <snprintf+0x62>
c0d021d0:	e184      	b.n	c0d024dc <snprintf+0x36c>
c0d021d2:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d021d4:	1980      	adds	r0, r0, r6
        format += ulIdx;

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d021d6:	9009      	str	r0, [sp, #36]	; 0x24
c0d021d8:	5da0      	ldrb	r0, [r4, r6]
        format += ulIdx;
c0d021da:	19a4      	adds	r4, r4, r6
        if(*format == '%')
c0d021dc:	2825      	cmp	r0, #37	; 0x25
c0d021de:	d000      	beq.n	c0d021e2 <snprintf+0x72>
c0d021e0:	e177      	b.n	c0d024d2 <snprintf+0x362>
        {
            //
            // Skip the %.
            //
            format++;
c0d021e2:	1c64      	adds	r4, r4, #1
c0d021e4:	2000      	movs	r0, #0
c0d021e6:	2320      	movs	r3, #32
c0d021e8:	4607      	mov	r7, r0
c0d021ea:	9007      	str	r0, [sp, #28]
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d021ec:	7821      	ldrb	r1, [r4, #0]
c0d021ee:	1c64      	adds	r4, r4, #1
c0d021f0:	2200      	movs	r2, #0
c0d021f2:	292d      	cmp	r1, #45	; 0x2d
c0d021f4:	dc0d      	bgt.n	c0d02212 <snprintf+0xa2>
c0d021f6:	4610      	mov	r0, r2
c0d021f8:	d0f8      	beq.n	c0d021ec <snprintf+0x7c>
c0d021fa:	2925      	cmp	r1, #37	; 0x25
c0d021fc:	d100      	bne.n	c0d02200 <snprintf+0x90>
c0d021fe:	e0e1      	b.n	c0d023c4 <snprintf+0x254>
c0d02200:	292a      	cmp	r1, #42	; 0x2a
c0d02202:	d000      	beq.n	c0d02206 <snprintf+0x96>
c0d02204:	e164      	b.n	c0d024d0 <snprintf+0x360>
                  goto error;
                }

                case '*':
                {
                  if (*format == 's' ) {
c0d02206:	7820      	ldrb	r0, [r4, #0]
c0d02208:	2873      	cmp	r0, #115	; 0x73
c0d0220a:	d000      	beq.n	c0d0220e <snprintf+0x9e>
c0d0220c:	e161      	b.n	c0d024d2 <snprintf+0x362>
c0d0220e:	2002      	movs	r0, #2
c0d02210:	e028      	b.n	c0d02264 <snprintf+0xf4>
            switch(*format++)
c0d02212:	2947      	cmp	r1, #71	; 0x47
c0d02214:	dc2b      	bgt.n	c0d0226e <snprintf+0xfe>
c0d02216:	460a      	mov	r2, r1
c0d02218:	3a30      	subs	r2, #48	; 0x30
c0d0221a:	2a0a      	cmp	r2, #10
c0d0221c:	d211      	bcs.n	c0d02242 <snprintf+0xd2>
c0d0221e:	970a      	str	r7, [sp, #40]	; 0x28
c0d02220:	461f      	mov	r7, r3
c0d02222:	2230      	movs	r2, #48	; 0x30
                    if((format[-1] == '0') && (ulCount == 0))
c0d02224:	460b      	mov	r3, r1
c0d02226:	4053      	eors	r3, r2
c0d02228:	9d07      	ldr	r5, [sp, #28]
c0d0222a:	432b      	orrs	r3, r5
c0d0222c:	d000      	beq.n	c0d02230 <snprintf+0xc0>
c0d0222e:	463a      	mov	r2, r7
c0d02230:	230a      	movs	r3, #10
                    ulCount *= 10;
c0d02232:	9d07      	ldr	r5, [sp, #28]
c0d02234:	436b      	muls	r3, r5
                    ulCount += format[-1] - '0';
c0d02236:	1859      	adds	r1, r3, r1
c0d02238:	3930      	subs	r1, #48	; 0x30
c0d0223a:	9107      	str	r1, [sp, #28]
c0d0223c:	4613      	mov	r3, r2
c0d0223e:	9f0a      	ldr	r7, [sp, #40]	; 0x28
c0d02240:	e7d4      	b.n	c0d021ec <snprintf+0x7c>
            switch(*format++)
c0d02242:	292e      	cmp	r1, #46	; 0x2e
c0d02244:	d000      	beq.n	c0d02248 <snprintf+0xd8>
c0d02246:	e143      	b.n	c0d024d0 <snprintf+0x360>
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d02248:	7820      	ldrb	r0, [r4, #0]
c0d0224a:	282a      	cmp	r0, #42	; 0x2a
c0d0224c:	d000      	beq.n	c0d02250 <snprintf+0xe0>
c0d0224e:	e140      	b.n	c0d024d2 <snprintf+0x362>
c0d02250:	7860      	ldrb	r0, [r4, #1]
c0d02252:	2848      	cmp	r0, #72	; 0x48
c0d02254:	d004      	beq.n	c0d02260 <snprintf+0xf0>
c0d02256:	2873      	cmp	r0, #115	; 0x73
c0d02258:	d002      	beq.n	c0d02260 <snprintf+0xf0>
c0d0225a:	2868      	cmp	r0, #104	; 0x68
c0d0225c:	d000      	beq.n	c0d02260 <snprintf+0xf0>
c0d0225e:	e13b      	b.n	c0d024d8 <snprintf+0x368>
c0d02260:	1c64      	adds	r4, r4, #1
c0d02262:	2001      	movs	r0, #1
c0d02264:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02266:	1d0a      	adds	r2, r1, #4
c0d02268:	920b      	str	r2, [sp, #44]	; 0x2c
c0d0226a:	680f      	ldr	r7, [r1, #0]
c0d0226c:	e7be      	b.n	c0d021ec <snprintf+0x7c>
            switch(*format++)
c0d0226e:	2967      	cmp	r1, #103	; 0x67
c0d02270:	dc09      	bgt.n	c0d02286 <snprintf+0x116>
c0d02272:	2962      	cmp	r1, #98	; 0x62
c0d02274:	dc0f      	bgt.n	c0d02296 <snprintf+0x126>
c0d02276:	2948      	cmp	r1, #72	; 0x48
c0d02278:	d100      	bne.n	c0d0227c <snprintf+0x10c>
c0d0227a:	e0a5      	b.n	c0d023c8 <snprintf+0x258>
c0d0227c:	2958      	cmp	r1, #88	; 0x58
c0d0227e:	d000      	beq.n	c0d02282 <snprintf+0x112>
c0d02280:	e126      	b.n	c0d024d0 <snprintf+0x360>
c0d02282:	2001      	movs	r0, #1
c0d02284:	e020      	b.n	c0d022c8 <snprintf+0x158>
c0d02286:	2972      	cmp	r1, #114	; 0x72
c0d02288:	dc17      	bgt.n	c0d022ba <snprintf+0x14a>
c0d0228a:	2968      	cmp	r1, #104	; 0x68
c0d0228c:	d100      	bne.n	c0d02290 <snprintf+0x120>
c0d0228e:	e09f      	b.n	c0d023d0 <snprintf+0x260>
c0d02290:	2970      	cmp	r1, #112	; 0x70
c0d02292:	d018      	beq.n	c0d022c6 <snprintf+0x156>
c0d02294:	e11c      	b.n	c0d024d0 <snprintf+0x360>
c0d02296:	2963      	cmp	r1, #99	; 0x63
c0d02298:	d100      	bne.n	c0d0229c <snprintf+0x12c>
c0d0229a:	e09e      	b.n	c0d023da <snprintf+0x26a>
c0d0229c:	2964      	cmp	r1, #100	; 0x64
c0d0229e:	d000      	beq.n	c0d022a2 <snprintf+0x132>
c0d022a0:	e116      	b.n	c0d024d0 <snprintf+0x360>
                    ulValue = va_arg(vaArgP, unsigned long);
c0d022a2:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d022a4:	1d01      	adds	r1, r0, #4
c0d022a6:	910b      	str	r1, [sp, #44]	; 0x2c
c0d022a8:	6800      	ldr	r0, [r0, #0]
                    if((long)ulValue < 0)
c0d022aa:	17c1      	asrs	r1, r0, #31
c0d022ac:	1842      	adds	r2, r0, r1
c0d022ae:	404a      	eors	r2, r1
c0d022b0:	0fc1      	lsrs	r1, r0, #31
c0d022b2:	2000      	movs	r0, #0
c0d022b4:	9002      	str	r0, [sp, #8]
c0d022b6:	270a      	movs	r7, #10
c0d022b8:	e00d      	b.n	c0d022d6 <snprintf+0x166>
            switch(*format++)
c0d022ba:	2973      	cmp	r1, #115	; 0x73
c0d022bc:	d100      	bne.n	c0d022c0 <snprintf+0x150>
c0d022be:	e099      	b.n	c0d023f4 <snprintf+0x284>
c0d022c0:	2978      	cmp	r1, #120	; 0x78
c0d022c2:	d000      	beq.n	c0d022c6 <snprintf+0x156>
c0d022c4:	e104      	b.n	c0d024d0 <snprintf+0x360>
c0d022c6:	2000      	movs	r0, #0
c0d022c8:	9002      	str	r0, [sp, #8]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d022ca:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d022cc:	1d01      	adds	r1, r0, #4
c0d022ce:	910b      	str	r1, [sp, #44]	; 0x2c
c0d022d0:	6802      	ldr	r2, [r0, #0]
c0d022d2:	2100      	movs	r1, #0
c0d022d4:	2710      	movs	r7, #16
c0d022d6:	9e07      	ldr	r6, [sp, #28]
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d022d8:	920a      	str	r2, [sp, #40]	; 0x28
c0d022da:	4297      	cmp	r7, r2
c0d022dc:	9303      	str	r3, [sp, #12]
c0d022de:	9104      	str	r1, [sp, #16]
c0d022e0:	d901      	bls.n	c0d022e6 <snprintf+0x176>
c0d022e2:	2501      	movs	r5, #1
c0d022e4:	e011      	b.n	c0d0230a <snprintf+0x19a>
                    for(ulIdx = 1;
c0d022e6:	1e72      	subs	r2, r6, #1
c0d022e8:	4638      	mov	r0, r7
c0d022ea:	4605      	mov	r5, r0
c0d022ec:	4616      	mov	r6, r2
c0d022ee:	2100      	movs	r1, #0
                        (((ulIdx * ulBase) <= ulValue) &&
c0d022f0:	4638      	mov	r0, r7
c0d022f2:	462a      	mov	r2, r5
c0d022f4:	460b      	mov	r3, r1
c0d022f6:	f004 ff3d 	bl	c0d07174 <__aeabi_lmul>
c0d022fa:	1e4a      	subs	r2, r1, #1
c0d022fc:	4191      	sbcs	r1, r2
c0d022fe:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d02300:	4290      	cmp	r0, r2
c0d02302:	d802      	bhi.n	c0d0230a <snprintf+0x19a>
                    for(ulIdx = 1;
c0d02304:	1e72      	subs	r2, r6, #1
c0d02306:	2900      	cmp	r1, #0
c0d02308:	d0ef      	beq.n	c0d022ea <snprintf+0x17a>
c0d0230a:	9607      	str	r6, [sp, #28]
c0d0230c:	2600      	movs	r6, #0
c0d0230e:	9904      	ldr	r1, [sp, #16]

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d02310:	2900      	cmp	r1, #0
c0d02312:	9405      	str	r4, [sp, #20]
c0d02314:	d101      	bne.n	c0d0231a <snprintf+0x1aa>
c0d02316:	9101      	str	r1, [sp, #4]
c0d02318:	e001      	b.n	c0d0231e <snprintf+0x1ae>
c0d0231a:	43f0      	mvns	r0, r6
c0d0231c:	9001      	str	r0, [sp, #4]
c0d0231e:	9b03      	ldr	r3, [sp, #12]
c0d02320:	9807      	ldr	r0, [sp, #28]
c0d02322:	1a40      	subs	r0, r0, r1

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d02324:	2900      	cmp	r1, #0
c0d02326:	9c06      	ldr	r4, [sp, #24]
c0d02328:	d009      	beq.n	c0d0233e <snprintf+0x1ce>
c0d0232a:	b2d9      	uxtb	r1, r3
c0d0232c:	2600      	movs	r6, #0
c0d0232e:	2930      	cmp	r1, #48	; 0x30
c0d02330:	4634      	mov	r4, r6
c0d02332:	d104      	bne.n	c0d0233e <snprintf+0x1ce>
c0d02334:	a90c      	add	r1, sp, #48	; 0x30
c0d02336:	222d      	movs	r2, #45	; 0x2d
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d02338:	700a      	strb	r2, [r1, #0]
c0d0233a:	2601      	movs	r6, #1
c0d0233c:	9c06      	ldr	r4, [sp, #24]

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d0233e:	1e81      	subs	r1, r0, #2
c0d02340:	290d      	cmp	r1, #13
c0d02342:	d80b      	bhi.n	c0d0235c <snprintf+0x1ec>
c0d02344:	1e41      	subs	r1, r0, #1
c0d02346:	d009      	beq.n	c0d0235c <snprintf+0x1ec>
c0d02348:	a80c      	add	r0, sp, #48	; 0x30
                    {
                        for(ulCount--; ulCount; ulCount--)
c0d0234a:	1980      	adds	r0, r0, r6
                        {
                            pcBuf[ulPos++] = cFill;
c0d0234c:	b2da      	uxtb	r2, r3
c0d0234e:	f004 ffe9 	bl	c0d07324 <__aeabi_memset>
                        for(ulCount--; ulCount; ulCount--)
c0d02352:	9807      	ldr	r0, [sp, #28]
c0d02354:	1830      	adds	r0, r6, r0
c0d02356:	9901      	ldr	r1, [sp, #4]
c0d02358:	1840      	adds	r0, r0, r1
c0d0235a:	1e46      	subs	r6, r0, #1

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d0235c:	2c00      	cmp	r4, #0
c0d0235e:	d103      	bne.n	c0d02368 <snprintf+0x1f8>
c0d02360:	a80c      	add	r0, sp, #48	; 0x30
c0d02362:	212d      	movs	r1, #45	; 0x2d
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d02364:	5581      	strb	r1, [r0, r6]
c0d02366:	1c76      	adds	r6, r6, #1
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d02368:	2d00      	cmp	r5, #0
c0d0236a:	d01a      	beq.n	c0d023a2 <snprintf+0x232>
c0d0236c:	463c      	mov	r4, r7
c0d0236e:	9802      	ldr	r0, [sp, #8]
c0d02370:	2800      	cmp	r0, #0
c0d02372:	d002      	beq.n	c0d0237a <snprintf+0x20a>
c0d02374:	4f60      	ldr	r7, [pc, #384]	; (c0d024f8 <snprintf+0x388>)
c0d02376:	447f      	add	r7, pc
c0d02378:	e001      	b.n	c0d0237e <snprintf+0x20e>
c0d0237a:	4f5e      	ldr	r7, [pc, #376]	; (c0d024f4 <snprintf+0x384>)
c0d0237c:	447f      	add	r7, pc
c0d0237e:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d02380:	4629      	mov	r1, r5
c0d02382:	f004 fe2f 	bl	c0d06fe4 <__udivsi3>
c0d02386:	4621      	mov	r1, r4
c0d02388:	f004 fe68 	bl	c0d0705c <__aeabi_uidivmod>
c0d0238c:	5c78      	ldrb	r0, [r7, r1]
c0d0238e:	a90c      	add	r1, sp, #48	; 0x30
                    {
                        if (!ulCap) {
                          pcBuf[ulPos++] = g_pcHex[(ulValue / ulIdx) % ulBase];
c0d02390:	5588      	strb	r0, [r1, r6]
                    for(; ulIdx; ulIdx /= ulBase)
c0d02392:	4628      	mov	r0, r5
c0d02394:	4621      	mov	r1, r4
c0d02396:	f004 fe25 	bl	c0d06fe4 <__udivsi3>
c0d0239a:	1c76      	adds	r6, r6, #1
c0d0239c:	42ac      	cmp	r4, r5
c0d0239e:	4605      	mov	r5, r0
c0d023a0:	d9ed      	bls.n	c0d0237e <snprintf+0x20e>
c0d023a2:	9c08      	ldr	r4, [sp, #32]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d023a4:	42a6      	cmp	r6, r4
c0d023a6:	d300      	bcc.n	c0d023aa <snprintf+0x23a>
c0d023a8:	4626      	mov	r6, r4
c0d023aa:	a90c      	add	r1, sp, #48	; 0x30
                    memmove(str, pcBuf, ulPos);
c0d023ac:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d023ae:	4632      	mov	r2, r6
c0d023b0:	f004 ffb4 	bl	c0d0731c <__aeabi_memmove>
                    str+= ulPos;
                    str_size -= ulPos;
c0d023b4:	1ba4      	subs	r4, r4, r6
c0d023b6:	9408      	str	r4, [sp, #32]
c0d023b8:	9c05      	ldr	r4, [sp, #20]
c0d023ba:	d100      	bne.n	c0d023be <snprintf+0x24e>
c0d023bc:	e08e      	b.n	c0d024dc <snprintf+0x36c>
c0d023be:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d023c0:	1980      	adds	r0, r0, r6
c0d023c2:	e084      	b.n	c0d024ce <snprintf+0x35e>
c0d023c4:	2025      	movs	r0, #37	; 0x25
c0d023c6:	e00c      	b.n	c0d023e2 <snprintf+0x272>
c0d023c8:	4625      	mov	r5, r4
c0d023ca:	4a48      	ldr	r2, [pc, #288]	; (c0d024ec <snprintf+0x37c>)
c0d023cc:	447a      	add	r2, pc
c0d023ce:	e002      	b.n	c0d023d6 <snprintf+0x266>
c0d023d0:	4625      	mov	r5, r4
c0d023d2:	4a47      	ldr	r2, [pc, #284]	; (c0d024f0 <snprintf+0x380>)
c0d023d4:	447a      	add	r2, pc
c0d023d6:	9b06      	ldr	r3, [sp, #24]
c0d023d8:	e010      	b.n	c0d023fc <snprintf+0x28c>
                    ulValue = va_arg(vaArgP, unsigned long);
c0d023da:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d023dc:	1d01      	adds	r1, r0, #4
c0d023de:	910b      	str	r1, [sp, #44]	; 0x2c
c0d023e0:	6800      	ldr	r0, [r0, #0]
c0d023e2:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d023e4:	7008      	strb	r0, [r1, #0]
c0d023e6:	9808      	ldr	r0, [sp, #32]
c0d023e8:	1e40      	subs	r0, r0, #1
c0d023ea:	9008      	str	r0, [sp, #32]
c0d023ec:	d076      	beq.n	c0d024dc <snprintf+0x36c>
c0d023ee:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d023f0:	1c40      	adds	r0, r0, #1
c0d023f2:	e06c      	b.n	c0d024ce <snprintf+0x35e>
c0d023f4:	4625      	mov	r5, r4
c0d023f6:	4a3c      	ldr	r2, [pc, #240]	; (c0d024e8 <snprintf+0x378>)
c0d023f8:	447a      	add	r2, pc
c0d023fa:	2300      	movs	r3, #0
                    pcStr = va_arg(vaArgP, char *);
c0d023fc:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d023fe:	1d0c      	adds	r4, r1, #4
c0d02400:	940b      	str	r4, [sp, #44]	; 0x2c
                    switch(cStrlenSet) {
c0d02402:	b2c0      	uxtb	r0, r0
                    pcStr = va_arg(vaArgP, char *);
c0d02404:	6809      	ldr	r1, [r1, #0]
                    switch(cStrlenSet) {
c0d02406:	2802      	cmp	r0, #2
c0d02408:	d03c      	beq.n	c0d02484 <snprintf+0x314>
c0d0240a:	2801      	cmp	r0, #1
c0d0240c:	462c      	mov	r4, r5
c0d0240e:	d00a      	beq.n	c0d02426 <snprintf+0x2b6>
c0d02410:	2800      	cmp	r0, #0
c0d02412:	4637      	mov	r7, r6
c0d02414:	d107      	bne.n	c0d02426 <snprintf+0x2b6>
c0d02416:	4625      	mov	r5, r4
c0d02418:	2000      	movs	r0, #0
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d0241a:	5c0c      	ldrb	r4, [r1, r0]
c0d0241c:	1c40      	adds	r0, r0, #1
c0d0241e:	2c00      	cmp	r4, #0
c0d02420:	d1fb      	bne.n	c0d0241a <snprintf+0x2aa>
                    switch(ulBase) {
c0d02422:	1e47      	subs	r7, r0, #1
c0d02424:	462c      	mov	r4, r5
c0d02426:	2b00      	cmp	r3, #0
c0d02428:	d020      	beq.n	c0d0246c <snprintf+0x2fc>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d0242a:	2f00      	cmp	r7, #0
c0d0242c:	9d08      	ldr	r5, [sp, #32]
c0d0242e:	d04f      	beq.n	c0d024d0 <snprintf+0x360>
c0d02430:	0078      	lsls	r0, r7, #1
c0d02432:	1a28      	subs	r0, r5, r0
c0d02434:	900a      	str	r0, [sp, #40]	; 0x28
                          if (str_size < 2) {
c0d02436:	2d02      	cmp	r5, #2
c0d02438:	d350      	bcc.n	c0d024dc <snprintf+0x36c>
c0d0243a:	4628      	mov	r0, r5
c0d0243c:	780b      	ldrb	r3, [r1, #0]
c0d0243e:	4625      	mov	r5, r4
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d02440:	091c      	lsrs	r4, r3, #4
c0d02442:	5d14      	ldrb	r4, [r2, r4]
c0d02444:	9e09      	ldr	r6, [sp, #36]	; 0x24
c0d02446:	7034      	strb	r4, [r6, #0]
c0d02448:	240f      	movs	r4, #15
                          nibble2 = pcStr[ulCount]&0xF;
c0d0244a:	401c      	ands	r4, r3
c0d0244c:	5d13      	ldrb	r3, [r2, r4]
                                str[1] = g_pcHex[nibble2];
c0d0244e:	7073      	strb	r3, [r6, #1]
                          if (str_size == 0) {
c0d02450:	2802      	cmp	r0, #2
c0d02452:	d043      	beq.n	c0d024dc <snprintf+0x36c>
c0d02454:	462c      	mov	r4, r5
c0d02456:	4605      	mov	r5, r0
c0d02458:	1e85      	subs	r5, r0, #2
                          str+= 2;
c0d0245a:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d0245c:	1c9b      	adds	r3, r3, #2
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d0245e:	9309      	str	r3, [sp, #36]	; 0x24
c0d02460:	1c49      	adds	r1, r1, #1
c0d02462:	1e7f      	subs	r7, r7, #1
c0d02464:	d1e7      	bne.n	c0d02436 <snprintf+0x2c6>
c0d02466:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d02468:	9008      	str	r0, [sp, #32]
c0d0246a:	e031      	b.n	c0d024d0 <snprintf+0x360>
c0d0246c:	9d08      	ldr	r5, [sp, #32]
                        ulIdx = MIN(ulIdx, str_size);
c0d0246e:	42af      	cmp	r7, r5
c0d02470:	463e      	mov	r6, r7
c0d02472:	d301      	bcc.n	c0d02478 <snprintf+0x308>
c0d02474:	462e      	mov	r6, r5
c0d02476:	462f      	mov	r7, r5
                        memmove(str, pcStr, ulIdx);
c0d02478:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d0247a:	4632      	mov	r2, r6
c0d0247c:	f004 ff4e 	bl	c0d0731c <__aeabi_memmove>
                        str_size -= ulIdx;
c0d02480:	1bad      	subs	r5, r5, r6
c0d02482:	e00d      	b.n	c0d024a0 <snprintf+0x330>
                        if (pcStr[0] == '\0') {
c0d02484:	7808      	ldrb	r0, [r1, #0]
c0d02486:	2800      	cmp	r0, #0
c0d02488:	462c      	mov	r4, r5
c0d0248a:	d121      	bne.n	c0d024d0 <snprintf+0x360>
c0d0248c:	9d08      	ldr	r5, [sp, #32]
                          ulStrlen = MIN(ulStrlen, str_size);
c0d0248e:	42af      	cmp	r7, r5
c0d02490:	d300      	bcc.n	c0d02494 <snprintf+0x324>
c0d02492:	462f      	mov	r7, r5
c0d02494:	2220      	movs	r2, #32
                          memset(str, ' ', ulStrlen);
c0d02496:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d02498:	4639      	mov	r1, r7
c0d0249a:	f004 ff43 	bl	c0d07324 <__aeabi_memset>
                          str_size -= ulStrlen;
c0d0249e:	1bed      	subs	r5, r5, r7
c0d024a0:	9508      	str	r5, [sp, #32]
c0d024a2:	d01b      	beq.n	c0d024dc <snprintf+0x36c>
c0d024a4:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d024a6:	19c0      	adds	r0, r0, r7
                    if(ulCount > ulIdx)
c0d024a8:	9009      	str	r0, [sp, #36]	; 0x24
c0d024aa:	9807      	ldr	r0, [sp, #28]
c0d024ac:	42b0      	cmp	r0, r6
c0d024ae:	d90f      	bls.n	c0d024d0 <snprintf+0x360>
                        ulCount -= ulIdx;
c0d024b0:	1b85      	subs	r5, r0, r6
c0d024b2:	9e08      	ldr	r6, [sp, #32]
                        ulCount = MIN(ulCount, str_size);
c0d024b4:	42b5      	cmp	r5, r6
c0d024b6:	d300      	bcc.n	c0d024ba <snprintf+0x34a>
c0d024b8:	4635      	mov	r5, r6
c0d024ba:	2220      	movs	r2, #32
                        memset(str, ' ', ulCount);
c0d024bc:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d024be:	4629      	mov	r1, r5
c0d024c0:	f004 ff30 	bl	c0d07324 <__aeabi_memset>
                        str_size -= ulCount;
c0d024c4:	1b76      	subs	r6, r6, r5
c0d024c6:	9608      	str	r6, [sp, #32]
                        if (str_size == 0) {
c0d024c8:	d008      	beq.n	c0d024dc <snprintf+0x36c>
c0d024ca:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d024cc:	1940      	adds	r0, r0, r5
c0d024ce:	9009      	str	r0, [sp, #36]	; 0x24
    while(*format)
c0d024d0:	7820      	ldrb	r0, [r4, #0]
c0d024d2:	2800      	cmp	r0, #0
c0d024d4:	d002      	beq.n	c0d024dc <snprintf+0x36c>
c0d024d6:	e666      	b.n	c0d021a6 <snprintf+0x36>
c0d024d8:	202a      	movs	r0, #42	; 0x2a
c0d024da:	e7fa      	b.n	c0d024d2 <snprintf+0x362>
c0d024dc:	2000      	movs	r0, #0
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d024de:	b010      	add	sp, #64	; 0x40
c0d024e0:	bcf0      	pop	{r4, r5, r6, r7}
c0d024e2:	bc02      	pop	{r1}
c0d024e4:	b001      	add	sp, #4
c0d024e6:	4708      	bx	r1
c0d024e8:	00005470 	.word	0x00005470
c0d024ec:	000054ac 	.word	0x000054ac
c0d024f0:	00005494 	.word	0x00005494
c0d024f4:	000054ec 	.word	0x000054ec
c0d024f8:	00005502 	.word	0x00005502

c0d024fc <parser_parse>:
#define FIELD_ERA_PERIOD    5
#define FIELD_BLOCK_HASH    6

#define EXPERT_FIELDS_TOTAL_COUNT 5

parser_error_t parser_parse(parser_context_t *ctx, const uint8_t *data, size_t dataLen, parser_tx_t *tx_obj) {
c0d024fc:	b570      	push	{r4, r5, r6, lr}
c0d024fe:	461d      	mov	r5, r3
c0d02500:	4604      	mov	r4, r0
    CHECK_PARSER_ERR(parser_init(ctx, data, dataLen))
c0d02502:	b292      	uxth	r2, r2
c0d02504:	f000 fad8 	bl	c0d02ab8 <parser_init>
c0d02508:	4606      	mov	r6, r0
c0d0250a:	f004 fd5b 	bl	c0d06fc4 <check_app_canary>
c0d0250e:	2e00      	cmp	r6, #0
c0d02510:	d116      	bne.n	c0d02540 <parser_parse+0x44>
c0d02512:	2075      	movs	r0, #117	; 0x75
c0d02514:	2101      	movs	r1, #1
    ctx->tx_obj = tx_obj;
    ctx->tx_obj->nestCallIdx.slotIdx = 0;
    ctx->tx_obj->nestCallIdx._lenBuffer = 0;
    ctx->tx_obj->nestCallIdx._ptr = NULL;
    ctx->tx_obj->nestCallIdx._nextPtr = NULL;
    ctx->tx_obj->nestCallIdx.isTail = true;
c0d02516:	5429      	strb	r1, [r5, r0]
    ctx->tx_obj = tx_obj;
c0d02518:	60a5      	str	r5, [r4, #8]
c0d0251a:	2074      	movs	r0, #116	; 0x74
c0d0251c:	2100      	movs	r1, #0
    ctx->tx_obj->nestCallIdx._lenBuffer = 0;
c0d0251e:	5429      	strb	r1, [r5, r0]
c0d02520:	66a9      	str	r1, [r5, #104]	; 0x68
c0d02522:	66e9      	str	r1, [r5, #108]	; 0x6c
c0d02524:	6729      	str	r1, [r5, #112]	; 0x70
    parser_error_t err = _readTx(ctx, ctx->tx_obj);
c0d02526:	4620      	mov	r0, r4
c0d02528:	4629      	mov	r1, r5
c0d0252a:	f000 fe35 	bl	c0d03198 <_readTx>
c0d0252e:	4606      	mov	r6, r0
    CTX_CHECK_AVAIL(ctx, 0)
c0d02530:	88a0      	ldrh	r0, [r4, #4]
c0d02532:	88e1      	ldrh	r1, [r4, #6]
c0d02534:	4281      	cmp	r1, r0
c0d02536:	d901      	bls.n	c0d0253c <parser_parse+0x40>
c0d02538:	260b      	movs	r6, #11
c0d0253a:	e001      	b.n	c0d02540 <parser_parse+0x44>
    zb_check_canary();
c0d0253c:	f004 fcae 	bl	c0d06e9c <zb_check_canary>

    return err;
}
c0d02540:	4630      	mov	r0, r6
c0d02542:	bd70      	pop	{r4, r5, r6, pc}

c0d02544 <parser_validate>:
        }
    }
    return true;
}

parser_error_t parser_validate(const parser_context_t *ctx) {
c0d02544:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02546:	b09b      	sub	sp, #108	; 0x6c
c0d02548:	4604      	mov	r4, r0
c0d0254a:	a91a      	add	r1, sp, #104	; 0x68
c0d0254c:	2600      	movs	r6, #0
    // Iterate through all items to check that all can be shown and are valid
    uint8_t numItems = 0;
c0d0254e:	700e      	strb	r6, [r1, #0]
    CHECK_PARSER_ERR(parser_getNumItems(ctx, &numItems))
c0d02550:	f000 f828 	bl	c0d025a4 <parser_getNumItems>
c0d02554:	4605      	mov	r5, r0
c0d02556:	f004 fd35 	bl	c0d06fc4 <check_app_canary>
c0d0255a:	2d00      	cmp	r5, #0
c0d0255c:	d002      	beq.n	c0d02564 <parser_validate+0x20>
        uint8_t pageCount = 0;
        CHECK_PARSER_ERR(parser_getItem(ctx, idx, tmpKey, sizeof(tmpKey), tmpVal, sizeof(tmpVal), 0, &pageCount))
    }

    return parser_ok;
}
c0d0255e:	4628      	mov	r0, r5
c0d02560:	b01b      	add	sp, #108	; 0x6c
c0d02562:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02564:	a81a      	add	r0, sp, #104	; 0x68
    for (uint8_t idx = 0; idx < numItems; idx++) {
c0d02566:	7800      	ldrb	r0, [r0, #0]
c0d02568:	9004      	str	r0, [sp, #16]
c0d0256a:	2800      	cmp	r0, #0
c0d0256c:	4635      	mov	r5, r6
c0d0256e:	d0f6      	beq.n	c0d0255e <parser_validate+0x1a>
c0d02570:	2600      	movs	r6, #0
c0d02572:	4637      	mov	r7, r6
c0d02574:	a805      	add	r0, sp, #20
        uint8_t pageCount = 0;
c0d02576:	7006      	strb	r6, [r0, #0]
        CHECK_PARSER_ERR(parser_getItem(ctx, idx, tmpKey, sizeof(tmpKey), tmpVal, sizeof(tmpVal), 0, &pageCount))
c0d02578:	9003      	str	r0, [sp, #12]
c0d0257a:	9602      	str	r6, [sp, #8]
c0d0257c:	2328      	movs	r3, #40	; 0x28
c0d0257e:	9301      	str	r3, [sp, #4]
c0d02580:	a806      	add	r0, sp, #24
c0d02582:	9000      	str	r0, [sp, #0]
c0d02584:	b2f9      	uxtb	r1, r7
c0d02586:	aa10      	add	r2, sp, #64	; 0x40
c0d02588:	4620      	mov	r0, r4
c0d0258a:	f000 f857 	bl	c0d0263c <parser_getItem>
c0d0258e:	4605      	mov	r5, r0
c0d02590:	f004 fd18 	bl	c0d06fc4 <check_app_canary>
c0d02594:	2d00      	cmp	r5, #0
c0d02596:	d1e2      	bne.n	c0d0255e <parser_validate+0x1a>
c0d02598:	1c7f      	adds	r7, r7, #1
    for (uint8_t idx = 0; idx < numItems; idx++) {
c0d0259a:	9804      	ldr	r0, [sp, #16]
c0d0259c:	4287      	cmp	r7, r0
c0d0259e:	d3e9      	bcc.n	c0d02574 <parser_validate+0x30>
c0d025a0:	2500      	movs	r5, #0
c0d025a2:	e7dc      	b.n	c0d0255e <parser_validate+0x1a>

c0d025a4 <parser_getNumItems>:

parser_error_t parser_getNumItems(const parser_context_t *ctx, uint8_t *num_items) {
c0d025a4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d025a6:	b085      	sub	sp, #20
c0d025a8:	460c      	mov	r4, r1
c0d025aa:	4605      	mov	r5, r0
c0d025ac:	ab01      	add	r3, sp, #4
c0d025ae:	2700      	movs	r7, #0
    uint8_t methodArgCount = 0;
c0d025b0:	701f      	strb	r7, [r3, #0]
    CHECK_PARSER_ERR(_getMethod_NumItems(ctx->tx_obj->transactionVersion,
c0d025b2:	6881      	ldr	r1, [r0, #8]
c0d025b4:	6dc8      	ldr	r0, [r1, #92]	; 0x5c
c0d025b6:	784a      	ldrb	r2, [r1, #1]
c0d025b8:	7809      	ldrb	r1, [r1, #0]
c0d025ba:	f000 ff73 	bl	c0d034a4 <_getMethod_NumItems>
c0d025be:	4606      	mov	r6, r0
c0d025c0:	f004 fd00 	bl	c0d06fc4 <check_app_canary>
c0d025c4:	2e00      	cmp	r6, #0
c0d025c6:	d136      	bne.n	c0d02636 <parser_getNumItems+0x92>
    if (ctx->tx_obj->tip.value.len <= 4) {
c0d025c8:	68a8      	ldr	r0, [r5, #8]
c0d025ca:	2154      	movs	r1, #84	; 0x54
c0d025cc:	5c41      	ldrb	r1, [r0, r1]
c0d025ce:	2904      	cmp	r1, #4
c0d025d0:	d807      	bhi.n	c0d025e2 <parser_getNumItems+0x3e>
        _getValue(&ctx->tx_obj->tip.value, &v);
c0d025d2:	3050      	adds	r0, #80	; 0x50
c0d025d4:	a902      	add	r1, sp, #8
c0d025d6:	f000 fb89 	bl	c0d02cec <_getValue>
        if ( v == 0 ){
c0d025da:	9803      	ldr	r0, [sp, #12]
c0d025dc:	9902      	ldr	r1, [sp, #8]
c0d025de:	4301      	orrs	r1, r0
c0d025e0:	d001      	beq.n	c0d025e6 <parser_getNumItems+0x42>
c0d025e2:	2607      	movs	r6, #7
c0d025e4:	e000      	b.n	c0d025e8 <parser_getNumItems+0x44>
c0d025e6:	2606      	movs	r6, #6
    return app_mode_expert();
c0d025e8:	f7fe fb94 	bl	c0d00d14 <app_mode_expert>

    uint8_t total = FIELD_FIXED_TOTAL_COUNT;
    if(!parser_show_tip(ctx)){
        total -= 1;
    }
    if(!parser_show_expert_fields()){
c0d025ec:	2800      	cmp	r0, #0
c0d025ee:	d002      	beq.n	c0d025f6 <parser_getNumItems+0x52>
c0d025f0:	a801      	add	r0, sp, #4
                methodArgCount--;
            }
        }
    }

    *num_items = total + methodArgCount;
c0d025f2:	7801      	ldrb	r1, [r0, #0]
c0d025f4:	e01c      	b.n	c0d02630 <parser_getNumItems+0x8c>
        total -= EXPERT_FIELDS_TOTAL_COUNT;
c0d025f6:	1f76      	subs	r6, r6, #5
c0d025f8:	a801      	add	r0, sp, #4
        for (uint8_t argIdx = 0; argIdx < methodArgCount; argIdx++) {
c0d025fa:	7800      	ldrb	r0, [r0, #0]
c0d025fc:	2800      	cmp	r0, #0
c0d025fe:	d016      	beq.n	c0d0262e <parser_getNumItems+0x8a>
c0d02600:	9400      	str	r4, [sp, #0]
c0d02602:	2400      	movs	r4, #0
            bool isArgExpert = _getMethod_ItemIsExpert(ctx->tx_obj->transactionVersion,
c0d02604:	68a8      	ldr	r0, [r5, #8]
                                                    ctx->tx_obj->callIndex.idx, argIdx);
c0d02606:	7842      	ldrb	r2, [r0, #1]
                                                    ctx->tx_obj->callIndex.moduleIdx,
c0d02608:	7801      	ldrb	r1, [r0, #0]
            bool isArgExpert = _getMethod_ItemIsExpert(ctx->tx_obj->transactionVersion,
c0d0260a:	6dc0      	ldr	r0, [r0, #92]	; 0x5c
c0d0260c:	b2e3      	uxtb	r3, r4
c0d0260e:	f000 ff89 	bl	c0d03524 <_getMethod_ItemIsExpert>
c0d02612:	a901      	add	r1, sp, #4
c0d02614:	7809      	ldrb	r1, [r1, #0]
            if(isArgExpert) {
c0d02616:	2800      	cmp	r0, #0
c0d02618:	d002      	beq.n	c0d02620 <parser_getNumItems+0x7c>
                methodArgCount--;
c0d0261a:	1e49      	subs	r1, r1, #1
c0d0261c:	a801      	add	r0, sp, #4
c0d0261e:	7001      	strb	r1, [r0, #0]
        for (uint8_t argIdx = 0; argIdx < methodArgCount; argIdx++) {
c0d02620:	b2c8      	uxtb	r0, r1
c0d02622:	1c64      	adds	r4, r4, #1
c0d02624:	b2e2      	uxtb	r2, r4
c0d02626:	4282      	cmp	r2, r0
c0d02628:	d3ec      	bcc.n	c0d02604 <parser_getNumItems+0x60>
c0d0262a:	9c00      	ldr	r4, [sp, #0]
c0d0262c:	e000      	b.n	c0d02630 <parser_getNumItems+0x8c>
    *num_items = total + methodArgCount;
c0d0262e:	4639      	mov	r1, r7
c0d02630:	1988      	adds	r0, r1, r6
c0d02632:	7020      	strb	r0, [r4, #0]
c0d02634:	463e      	mov	r6, r7
    return parser_ok;
}
c0d02636:	4630      	mov	r0, r6
c0d02638:	b005      	add	sp, #20
c0d0263a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0263c <parser_getItem>:

parser_error_t parser_getItem(const parser_context_t *ctx,
                              uint8_t displayIdx,
                              char *outKey, uint16_t outKeyLen,
                              char *outVal, uint16_t outValLen,
                              uint8_t pageIdx, uint8_t *pageCount) {
c0d0263c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0263e:	b093      	sub	sp, #76	; 0x4c
c0d02640:	461e      	mov	r6, r3
c0d02642:	4615      	mov	r5, r2
c0d02644:	910c      	str	r1, [sp, #48]	; 0x30
c0d02646:	900d      	str	r0, [sp, #52]	; 0x34
    MEMZERO(outKey, outKeyLen);
c0d02648:	4610      	mov	r0, r2
c0d0264a:	4619      	mov	r1, r3
c0d0264c:	f004 fe72 	bl	c0d07334 <explicit_bzero>
c0d02650:	9f18      	ldr	r7, [sp, #96]	; 0x60
c0d02652:	9c19      	ldr	r4, [sp, #100]	; 0x64
    MEMZERO(outVal, outValLen);
c0d02654:	4638      	mov	r0, r7
c0d02656:	4621      	mov	r1, r4
c0d02658:	f004 fe6c 	bl	c0d07334 <explicit_bzero>
    snprintf(outKey, outKeyLen, "?");
c0d0265c:	4af8      	ldr	r2, [pc, #992]	; (c0d02a40 <parser_getItem+0x404>)
c0d0265e:	447a      	add	r2, pc
c0d02660:	9508      	str	r5, [sp, #32]
c0d02662:	4628      	mov	r0, r5
c0d02664:	9609      	str	r6, [sp, #36]	; 0x24
c0d02666:	4631      	mov	r1, r6
c0d02668:	4615      	mov	r5, r2
c0d0266a:	f7ff fd81 	bl	c0d02170 <snprintf>
c0d0266e:	970b      	str	r7, [sp, #44]	; 0x2c
    snprintf(outVal, outValLen, "?");
c0d02670:	4638      	mov	r0, r7
c0d02672:	940a      	str	r4, [sp, #40]	; 0x28
c0d02674:	4621      	mov	r1, r4
c0d02676:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d02678:	462a      	mov	r2, r5
c0d0267a:	f7ff fd79 	bl	c0d02170 <snprintf>
c0d0267e:	9e1b      	ldr	r6, [sp, #108]	; 0x6c
c0d02680:	2501      	movs	r5, #1
    *pageCount = 1;
c0d02682:	7035      	strb	r5, [r6, #0]
c0d02684:	a90f      	add	r1, sp, #60	; 0x3c

    uint8_t numItems;
    CHECK_PARSER_ERR(parser_getNumItems(ctx, &numItems))
c0d02686:	4620      	mov	r0, r4
c0d02688:	f7ff ff8c 	bl	c0d025a4 <parser_getNumItems>
c0d0268c:	4607      	mov	r7, r0
c0d0268e:	f004 fc99 	bl	c0d06fc4 <check_app_canary>
c0d02692:	2f00      	cmp	r7, #0
c0d02694:	d000      	beq.n	c0d02698 <parser_getItem+0x5c>
c0d02696:	e120      	b.n	c0d028da <parser_getItem+0x29e>
    CHECK_APP_CANARY()
c0d02698:	f004 fc94 	bl	c0d06fc4 <check_app_canary>
c0d0269c:	a80f      	add	r0, sp, #60	; 0x3c

    if (displayIdx >= numItems) {
c0d0269e:	7800      	ldrb	r0, [r0, #0]
c0d026a0:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d026a2:	4288      	cmp	r0, r1
c0d026a4:	462f      	mov	r7, r5
c0d026a6:	d800      	bhi.n	c0d026aa <parser_getItem+0x6e>
c0d026a8:	e117      	b.n	c0d028da <parser_getItem+0x29e>
c0d026aa:	980c      	ldr	r0, [sp, #48]	; 0x30
        return parser_no_data;
    }

    parser_error_t err = parser_ok;
    if (displayIdx == FIELD_METHOD) {
c0d026ac:	2800      	cmp	r0, #0
c0d026ae:	d028      	beq.n	c0d02702 <parser_getItem+0xc6>
c0d026b0:	ab0e      	add	r3, sp, #56	; 0x38
c0d026b2:	2500      	movs	r5, #0
                                                                  ctx->tx_obj->callIndex.idx));
        return err;
    }

    // VARIABLE ARGUMENTS
    uint8_t methodArgCount = 0;
c0d026b4:	701d      	strb	r5, [r3, #0]
    CHECK_PARSER_ERR(_getMethod_NumItems(ctx->tx_obj->transactionVersion,
c0d026b6:	68a1      	ldr	r1, [r4, #8]
c0d026b8:	6dc8      	ldr	r0, [r1, #92]	; 0x5c
c0d026ba:	784a      	ldrb	r2, [r1, #1]
c0d026bc:	7809      	ldrb	r1, [r1, #0]
c0d026be:	f000 fef1 	bl	c0d034a4 <_getMethod_NumItems>
c0d026c2:	4607      	mov	r7, r0
c0d026c4:	f004 fc7e 	bl	c0d06fc4 <check_app_canary>
c0d026c8:	2f00      	cmp	r7, #0
c0d026ca:	d000      	beq.n	c0d026ce <parser_getItem+0x92>
c0d026cc:	e105      	b.n	c0d028da <parser_getItem+0x29e>
c0d026ce:	9507      	str	r5, [sp, #28]
c0d026d0:	9f0c      	ldr	r7, [sp, #48]	; 0x30
                                         ctx->tx_obj->callIndex.moduleIdx,
                                         ctx->tx_obj->callIndex.idx, &methodArgCount));
    uint8_t argIdx = displayIdx - 1;
c0d026d2:	1e7d      	subs	r5, r7, #1
    return app_mode_expert();
c0d026d4:	f7fe fb1e 	bl	c0d00d14 <app_mode_expert>
c0d026d8:	a90e      	add	r1, sp, #56	; 0x38
c0d026da:	7809      	ldrb	r1, [r1, #0]


    if (!parser_show_expert_fields()) {
c0d026dc:	2800      	cmp	r0, #0
c0d026de:	d12d      	bne.n	c0d0273c <parser_getItem+0x100>
c0d026e0:	b2e8      	uxtb	r0, r5
c0d026e2:	4288      	cmp	r0, r1
c0d026e4:	d22a      	bcs.n	c0d0273c <parser_getItem+0x100>
        // Search for the next non expert item
        while ((argIdx < methodArgCount) && _getMethod_ItemIsExpert(ctx->tx_obj->transactionVersion,
c0d026e6:	68a0      	ldr	r0, [r4, #8]
                                                                    ctx->tx_obj->callIndex.moduleIdx,
                                                                    ctx->tx_obj->callIndex.idx, argIdx)) {
c0d026e8:	7842      	ldrb	r2, [r0, #1]
                                                                    ctx->tx_obj->callIndex.moduleIdx,
c0d026ea:	7801      	ldrb	r1, [r0, #0]
        while ((argIdx < methodArgCount) && _getMethod_ItemIsExpert(ctx->tx_obj->transactionVersion,
c0d026ec:	6dc0      	ldr	r0, [r0, #92]	; 0x5c
c0d026ee:	b2eb      	uxtb	r3, r5
c0d026f0:	f000 ff18 	bl	c0d03524 <_getMethod_ItemIsExpert>
c0d026f4:	2800      	cmp	r0, #0
c0d026f6:	d01f      	beq.n	c0d02738 <parser_getItem+0xfc>
c0d026f8:	a80e      	add	r0, sp, #56	; 0x38
c0d026fa:	7801      	ldrb	r1, [r0, #0]
            argIdx++;
            displayIdx++;
c0d026fc:	1c7f      	adds	r7, r7, #1
            argIdx++;
c0d026fe:	1c6d      	adds	r5, r5, #1
c0d02700:	e7ee      	b.n	c0d026e0 <parser_getItem+0xa4>
        snprintf(outKey, outKeyLen, "%s", _getMethod_ModuleName(ctx->tx_obj->transactionVersion, ctx->tx_obj->callIndex.moduleIdx));
c0d02702:	68a0      	ldr	r0, [r4, #8]
c0d02704:	7801      	ldrb	r1, [r0, #0]
c0d02706:	6dc0      	ldr	r0, [r0, #92]	; 0x5c
c0d02708:	f000 fed7 	bl	c0d034ba <_getMethod_ModuleName>
c0d0270c:	4603      	mov	r3, r0
c0d0270e:	4de0      	ldr	r5, [pc, #896]	; (c0d02a90 <parser_getItem+0x454>)
c0d02710:	447d      	add	r5, pc
c0d02712:	9808      	ldr	r0, [sp, #32]
c0d02714:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d02716:	462a      	mov	r2, r5
c0d02718:	f7ff fd2a 	bl	c0d02170 <snprintf>
        snprintf(outVal, outValLen, "%s", _getMethod_Name(ctx->tx_obj->transactionVersion,
c0d0271c:	68a1      	ldr	r1, [r4, #8]
c0d0271e:	6dc8      	ldr	r0, [r1, #92]	; 0x5c
                                                                  ctx->tx_obj->callIndex.idx));
c0d02720:	784a      	ldrb	r2, [r1, #1]
                                                                  ctx->tx_obj->callIndex.moduleIdx,
c0d02722:	7809      	ldrb	r1, [r1, #0]
        snprintf(outVal, outValLen, "%s", _getMethod_Name(ctx->tx_obj->transactionVersion,
c0d02724:	f000 fed2 	bl	c0d034cc <_getMethod_Name>
c0d02728:	4603      	mov	r3, r0
c0d0272a:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0272c:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d0272e:	462a      	mov	r2, r5
c0d02730:	f7ff fd1e 	bl	c0d02170 <snprintf>
c0d02734:	2700      	movs	r7, #0
c0d02736:	e0d0      	b.n	c0d028da <parser_getItem+0x29e>
c0d02738:	a80e      	add	r0, sp, #56	; 0x38
        }
    }

    if (argIdx < methodArgCount) {
c0d0273a:	7801      	ldrb	r1, [r0, #0]
c0d0273c:	4638      	mov	r0, r7
c0d0273e:	9f1a      	ldr	r7, [sp, #104]	; 0x68
c0d02740:	b2ed      	uxtb	r5, r5
c0d02742:	428d      	cmp	r5, r1
c0d02744:	d21d      	bcs.n	c0d02782 <parser_getItem+0x146>
        snprintf(outKey, outKeyLen, "%s",
                 _getMethod_ItemName(ctx->tx_obj->transactionVersion,
c0d02746:	68a0      	ldr	r0, [r4, #8]
                                     ctx->tx_obj->callIndex.moduleIdx,
                                     ctx->tx_obj->callIndex.idx,
c0d02748:	7842      	ldrb	r2, [r0, #1]
                                     ctx->tx_obj->callIndex.moduleIdx,
c0d0274a:	7801      	ldrb	r1, [r0, #0]
                 _getMethod_ItemName(ctx->tx_obj->transactionVersion,
c0d0274c:	6dc0      	ldr	r0, [r0, #92]	; 0x5c
c0d0274e:	462b      	mov	r3, r5
c0d02750:	f000 fec6 	bl	c0d034e0 <_getMethod_ItemName>
c0d02754:	4603      	mov	r3, r0
        snprintf(outKey, outKeyLen, "%s",
c0d02756:	4acf      	ldr	r2, [pc, #828]	; (c0d02a94 <parser_getItem+0x458>)
c0d02758:	447a      	add	r2, pc
c0d0275a:	9808      	ldr	r0, [sp, #32]
c0d0275c:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d0275e:	f7ff fd07 	bl	c0d02170 <snprintf>
                                     argIdx));

        err = _getMethod_ItemValue(ctx->tx_obj->transactionVersion,
c0d02762:	68a1      	ldr	r1, [r4, #8]
c0d02764:	6dc8      	ldr	r0, [r1, #92]	; 0x5c
                                   &ctx->tx_obj->method,
                                   ctx->tx_obj->callIndex.moduleIdx, ctx->tx_obj->callIndex.idx, argIdx,
c0d02766:	784b      	ldrb	r3, [r1, #1]
c0d02768:	780a      	ldrb	r2, [r1, #0]
        err = _getMethod_ItemValue(ctx->tx_obj->transactionVersion,
c0d0276a:	9500      	str	r5, [sp, #0]
c0d0276c:	9c0b      	ldr	r4, [sp, #44]	; 0x2c
c0d0276e:	9401      	str	r4, [sp, #4]
c0d02770:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d02772:	9402      	str	r4, [sp, #8]
c0d02774:	9703      	str	r7, [sp, #12]
c0d02776:	9604      	str	r6, [sp, #16]
                                   &ctx->tx_obj->method,
c0d02778:	3108      	adds	r1, #8
        err = _getMethod_ItemValue(ctx->tx_obj->transactionVersion,
c0d0277a:	f000 febc 	bl	c0d034f6 <_getMethod_ItemValue>
c0d0277e:	4607      	mov	r7, r0
c0d02780:	e0ab      	b.n	c0d028da <parser_getItem+0x29e>
c0d02782:	960c      	str	r6, [sp, #48]	; 0x30
                                   outVal, outValLen,
                                   pageIdx, pageCount);
        return err;
    } else {
        // CONTINUE WITH FIXED ARGUMENTS
        displayIdx -= methodArgCount;
c0d02784:	1a46      	subs	r6, r0, r1
c0d02786:	b2f0      	uxtb	r0, r6
        if( displayIdx == FIELD_NETWORK ){
c0d02788:	2801      	cmp	r0, #1
c0d0278a:	d115      	bne.n	c0d027b8 <parser_getItem+0x17c>
            if (_getAddressType() == PK_ADDRESS_TYPE) {
c0d0278c:	f000 fcde 	bl	c0d0314c <_getAddressType>
c0d02790:	2816      	cmp	r0, #22
c0d02792:	d000      	beq.n	c0d02796 <parser_getItem+0x15a>
c0d02794:	e091      	b.n	c0d028ba <parser_getItem+0x27e>
    return app_mode_expert();
c0d02796:	f7fe fabd 	bl	c0d00d14 <app_mode_expert>
                if(parser_show_expert_fields()){
c0d0279a:	2800      	cmp	r0, #0
c0d0279c:	d00c      	beq.n	c0d027b8 <parser_getItem+0x17c>
                    snprintf(outKey, outKeyLen, "Chain");
c0d0279e:	4abe      	ldr	r2, [pc, #760]	; (c0d02a98 <parser_getItem+0x45c>)
c0d027a0:	447a      	add	r2, pc
c0d027a2:	9808      	ldr	r0, [sp, #32]
c0d027a4:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d027a6:	f7ff fce3 	bl	c0d02170 <snprintf>
                    snprintf(outVal, outValLen, COIN_NAME);
c0d027aa:	4abc      	ldr	r2, [pc, #752]	; (c0d02a9c <parser_getItem+0x460>)
c0d027ac:	447a      	add	r2, pc
c0d027ae:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d027b0:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d027b2:	f7ff fcdd 	bl	c0d02170 <snprintf>
c0d027b6:	e08f      	b.n	c0d028d8 <parser_getItem+0x29c>
c0d027b8:	9706      	str	r7, [sp, #24]
    return app_mode_expert();
c0d027ba:	f7fe faab 	bl	c0d00d14 <app_mode_expert>
c0d027be:	2701      	movs	r7, #1
                              pageIdx, pageCount);
                return err;
            }
        }

        if( !parser_show_expert_fields() ){
c0d027c0:	4078      	eors	r0, r7
c0d027c2:	1835      	adds	r5, r6, r0
c0d027c4:	b2e8      	uxtb	r0, r5
            displayIdx++;
        }

        if( displayIdx == FIELD_NONCE && parser_show_expert_fields()) {
c0d027c6:	2802      	cmp	r0, #2
c0d027c8:	d113      	bne.n	c0d027f2 <parser_getItem+0x1b6>
    return app_mode_expert();
c0d027ca:	f7fe faa3 	bl	c0d00d14 <app_mode_expert>
        if( displayIdx == FIELD_NONCE && parser_show_expert_fields()) {
c0d027ce:	2800      	cmp	r0, #0
c0d027d0:	d00f      	beq.n	c0d027f2 <parser_getItem+0x1b6>
            snprintf(outKey, outKeyLen, "Nonce");
c0d027d2:	4ab4      	ldr	r2, [pc, #720]	; (c0d02aa4 <parser_getItem+0x468>)
c0d027d4:	447a      	add	r2, pc
c0d027d6:	9808      	ldr	r0, [sp, #32]
c0d027d8:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d027da:	f7ff fcc9 	bl	c0d02170 <snprintf>
            return _toStringCompactIndex(&ctx->tx_obj->nonce,
c0d027de:	68a0      	ldr	r0, [r4, #8]
c0d027e0:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d027e2:	9100      	str	r1, [sp, #0]
c0d027e4:	3048      	adds	r0, #72	; 0x48
c0d027e6:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d027e8:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d027ea:	9b06      	ldr	r3, [sp, #24]
c0d027ec:	f000 fc2c 	bl	c0d03048 <_toStringCompactIndex>
c0d027f0:	e7c5      	b.n	c0d0277e <parser_getItem+0x142>
    return app_mode_expert();
c0d027f2:	f7fe fa8f 	bl	c0d00d14 <app_mode_expert>
                                  outVal, outValLen,
                                  pageIdx, pageCount);
        }

        if( !parser_show_expert_fields() ){
c0d027f6:	4078      	eors	r0, r7
c0d027f8:	182e      	adds	r6, r5, r0
c0d027fa:	b2f0      	uxtb	r0, r6
            displayIdx++;
        }

        if( displayIdx == FIELD_TIP && parser_show_tip(ctx)) {
c0d027fc:	2803      	cmp	r0, #3
c0d027fe:	d14b      	bne.n	c0d02898 <parser_getItem+0x25c>
    if (ctx->tx_obj->tip.value.len <= 4) {
c0d02800:	68a0      	ldr	r0, [r4, #8]
c0d02802:	2154      	movs	r1, #84	; 0x54
c0d02804:	5c41      	ldrb	r1, [r0, r1]
c0d02806:	2904      	cmp	r1, #4
c0d02808:	d807      	bhi.n	c0d0281a <parser_getItem+0x1de>
        _getValue(&ctx->tx_obj->tip.value, &v);
c0d0280a:	3050      	adds	r0, #80	; 0x50
c0d0280c:	a910      	add	r1, sp, #64	; 0x40
c0d0280e:	f000 fa6d 	bl	c0d02cec <_getValue>
        if ( v == 0 ){
c0d02812:	9811      	ldr	r0, [sp, #68]	; 0x44
c0d02814:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02816:	4301      	orrs	r1, r0
c0d02818:	d03e      	beq.n	c0d02898 <parser_getItem+0x25c>
            snprintf(outKey, outKeyLen, "Tip");
c0d0281a:	4aa3      	ldr	r2, [pc, #652]	; (c0d02aa8 <parser_getItem+0x46c>)
c0d0281c:	447a      	add	r2, pc
c0d0281e:	9808      	ldr	r0, [sp, #32]
c0d02820:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d02822:	f7ff fca5 	bl	c0d02170 <snprintf>
            err = _toStringCompactBalance(&ctx->tx_obj->tip,
c0d02826:	68a0      	ldr	r0, [r4, #8]
c0d02828:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d0282a:	9100      	str	r1, [sp, #0]
c0d0282c:	3050      	adds	r0, #80	; 0x50
c0d0282e:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02830:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d02832:	9b06      	ldr	r3, [sp, #24]
c0d02834:	f000 fc1a 	bl	c0d0306c <_toStringCompactBalance>
c0d02838:	4607      	mov	r7, r0
                                    outVal, outValLen,
                                    pageIdx, pageCount);
            if( err != parser_ok ) return err;
c0d0283a:	2800      	cmp	r0, #0
c0d0283c:	9c07      	ldr	r4, [sp, #28]
c0d0283e:	d14c      	bne.n	c0d028da <parser_getItem+0x29e>
    const size_t len = strlen(s);
c0d02840:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d02842:	f004 ff07 	bl	c0d07654 <strlen>
    if (len == 0 || len == 1 || len > 1024) {
c0d02846:	1e81      	subs	r1, r0, #2
c0d02848:	4a8f      	ldr	r2, [pc, #572]	; (c0d02a88 <parser_getItem+0x44c>)
c0d0284a:	4291      	cmp	r1, r2
c0d0284c:	4627      	mov	r7, r4
c0d0284e:	d844      	bhi.n	c0d028da <parser_getItem+0x29e>
c0d02850:	498e      	ldr	r1, [pc, #568]	; (c0d02a8c <parser_getItem+0x450>)
c0d02852:	2300      	movs	r3, #0
c0d02854:	461a      	mov	r2, r3
c0d02856:	9c0b      	ldr	r4, [sp, #44]	; 0x2c
        if (s[i] == '.') {
c0d02858:	5ce3      	ldrb	r3, [r4, r3]
c0d0285a:	2b2e      	cmp	r3, #46	; 0x2e
c0d0285c:	4613      	mov	r3, r2
c0d0285e:	d000      	beq.n	c0d02862 <parser_getItem+0x226>
c0d02860:	460b      	mov	r3, r1
c0d02862:	b219      	sxth	r1, r3
    for (int16_t i = 0; i < (int16_t) len && dec_point < 0; i++) {
c0d02864:	1c52      	adds	r2, r2, #1
c0d02866:	b213      	sxth	r3, r2
c0d02868:	4298      	cmp	r0, r3
c0d0286a:	dd01      	ble.n	c0d02870 <parser_getItem+0x234>
c0d0286c:	2900      	cmp	r1, #0
c0d0286e:	d4f3      	bmi.n	c0d02858 <parser_getItem+0x21c>
c0d02870:	2200      	movs	r2, #0
    if (dec_point < 0) {
c0d02872:	2900      	cmp	r1, #0
c0d02874:	d500      	bpl.n	c0d02878 <parser_getItem+0x23c>
c0d02876:	e0df      	b.n	c0d02a38 <parser_getItem+0x3fc>
c0d02878:	1e40      	subs	r0, r0, #1
c0d0287a:	1c49      	adds	r1, r1, #1
c0d0287c:	4288      	cmp	r0, r1
c0d0287e:	d800      	bhi.n	c0d02882 <parser_getItem+0x246>
c0d02880:	e0da      	b.n	c0d02a38 <parser_getItem+0x3fc>
c0d02882:	9c0b      	ldr	r4, [sp, #44]	; 0x2c
    for (size_t i = (len - 1); i > limit && s[i] == '0'; i--) {
c0d02884:	5c23      	ldrb	r3, [r4, r0]
c0d02886:	2b30      	cmp	r3, #48	; 0x30
c0d02888:	d000      	beq.n	c0d0288c <parser_getItem+0x250>
c0d0288a:	e0d5      	b.n	c0d02a38 <parser_getItem+0x3fc>
c0d0288c:	2700      	movs	r7, #0
        s[i] = 0;
c0d0288e:	5427      	strb	r7, [r4, r0]
c0d02890:	1e40      	subs	r0, r0, #1
    for (size_t i = (len - 1); i > limit && s[i] == '0'; i--) {
c0d02892:	4288      	cmp	r0, r1
c0d02894:	d8f6      	bhi.n	c0d02884 <parser_getItem+0x248>
c0d02896:	e020      	b.n	c0d028da <parser_getItem+0x29e>
    if (ctx->tx_obj->tip.value.len <= 4) {
c0d02898:	68a0      	ldr	r0, [r4, #8]
c0d0289a:	2154      	movs	r1, #84	; 0x54
c0d0289c:	5c41      	ldrb	r1, [r0, r1]
c0d0289e:	2904      	cmp	r1, #4
c0d028a0:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d028a2:	d81d      	bhi.n	c0d028e0 <parser_getItem+0x2a4>
        _getValue(&ctx->tx_obj->tip.value, &v);
c0d028a4:	3050      	adds	r0, #80	; 0x50
c0d028a6:	a910      	add	r1, sp, #64	; 0x40
c0d028a8:	f000 fa20 	bl	c0d02cec <_getValue>
        if ( v == 0 ){
c0d028ac:	9811      	ldr	r0, [sp, #68]	; 0x44
c0d028ae:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d028b0:	4301      	orrs	r1, r0
c0d028b2:	9d07      	ldr	r5, [sp, #28]
c0d028b4:	d115      	bne.n	c0d028e2 <parser_getItem+0x2a6>
c0d028b6:	1c76      	adds	r6, r6, #1
c0d028b8:	e013      	b.n	c0d028e2 <parser_getItem+0x2a6>
                snprintf(outKey, outKeyLen, "Genesis Hash");
c0d028ba:	4a79      	ldr	r2, [pc, #484]	; (c0d02aa0 <parser_getItem+0x464>)
c0d028bc:	447a      	add	r2, pc
c0d028be:	9808      	ldr	r0, [sp, #32]
c0d028c0:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d028c2:	f7ff fc55 	bl	c0d02170 <snprintf>
                _toStringHash(&ctx->tx_obj->genesisHash,
c0d028c6:	68a0      	ldr	r0, [r4, #8]
c0d028c8:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d028ca:	9100      	str	r1, [sp, #0]
c0d028cc:	3060      	adds	r0, #96	; 0x60
c0d028ce:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d028d0:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d028d2:	463b      	mov	r3, r7
c0d028d4:	f001 fe86 	bl	c0d045e4 <_toStringHash>
c0d028d8:	9f07      	ldr	r7, [sp, #28]
        }

        return parser_no_data;
    }

}
c0d028da:	4638      	mov	r0, r7
c0d028dc:	b013      	add	sp, #76	; 0x4c
c0d028de:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d028e0:	9d07      	ldr	r5, [sp, #28]
        if( displayIdx == FIELD_ERA_PHASE && parser_show_expert_fields() ) {
c0d028e2:	b2f0      	uxtb	r0, r6
c0d028e4:	2804      	cmp	r0, #4
c0d028e6:	d140      	bne.n	c0d0296a <parser_getItem+0x32e>
    return app_mode_expert();
c0d028e8:	f7fe fa14 	bl	c0d00d14 <app_mode_expert>
        if( displayIdx == FIELD_ERA_PHASE && parser_show_expert_fields() ) {
c0d028ec:	2800      	cmp	r0, #0
c0d028ee:	d03c      	beq.n	c0d0296a <parser_getItem+0x32e>
            snprintf(outKey, outKeyLen, "Era Phase");
c0d028f0:	4a6e      	ldr	r2, [pc, #440]	; (c0d02aac <parser_getItem+0x470>)
c0d028f2:	447a      	add	r2, pc
c0d028f4:	9808      	ldr	r0, [sp, #32]
c0d028f6:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d028f8:	f7ff fc3a 	bl	c0d02170 <snprintf>
NUM_TO_STR(uint64)
c0d028fc:	2c02      	cmp	r4, #2
c0d028fe:	462f      	mov	r7, r5
c0d02900:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d02902:	d3ea      	bcc.n	c0d028da <parser_getItem+0x29e>
c0d02904:	6880      	ldr	r0, [r0, #8]
c0d02906:	6c04      	ldr	r4, [r0, #64]	; 0x40
c0d02908:	6c46      	ldr	r6, [r0, #68]	; 0x44
c0d0290a:	9d0b      	ldr	r5, [sp, #44]	; 0x2c
c0d0290c:	4628      	mov	r0, r5
c0d0290e:	9f0a      	ldr	r7, [sp, #40]	; 0x28
c0d02910:	4639      	mov	r1, r7
c0d02912:	f004 fd0f 	bl	c0d07334 <explicit_bzero>
c0d02916:	4620      	mov	r0, r4
c0d02918:	4330      	orrs	r0, r6
c0d0291a:	d100      	bne.n	c0d0291e <parser_getItem+0x2e2>
c0d0291c:	e092      	b.n	c0d02a44 <parser_getItem+0x408>
c0d0291e:	1e78      	subs	r0, r7, #1
c0d02920:	9009      	str	r0, [sp, #36]	; 0x24
c0d02922:	2500      	movs	r5, #0
c0d02924:	9508      	str	r5, [sp, #32]
c0d02926:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d02928:	4285      	cmp	r5, r0
c0d0292a:	db00      	blt.n	c0d0292e <parser_getItem+0x2f2>
c0d0292c:	e086      	b.n	c0d02a3c <parser_getItem+0x400>
c0d0292e:	220a      	movs	r2, #10
c0d02930:	920a      	str	r2, [sp, #40]	; 0x28
c0d02932:	2700      	movs	r7, #0
c0d02934:	4620      	mov	r0, r4
c0d02936:	4631      	mov	r1, r6
c0d02938:	463b      	mov	r3, r7
c0d0293a:	f004 fbfb 	bl	c0d07134 <__aeabi_uldivmod>
c0d0293e:	900d      	str	r0, [sp, #52]	; 0x34
c0d02940:	910c      	str	r1, [sp, #48]	; 0x30
c0d02942:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d02944:	463b      	mov	r3, r7
c0d02946:	f004 fc15 	bl	c0d07174 <__aeabi_lmul>
c0d0294a:	1a20      	subs	r0, r4, r0
c0d0294c:	2130      	movs	r1, #48	; 0x30
c0d0294e:	4301      	orrs	r1, r0
c0d02950:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d02952:	5541      	strb	r1, [r0, r5]
c0d02954:	1c6d      	adds	r5, r5, #1
c0d02956:	3c0a      	subs	r4, #10
c0d02958:	41be      	sbcs	r6, r7
c0d0295a:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d0295c:	9e0c      	ldr	r6, [sp, #48]	; 0x30
c0d0295e:	d2e2      	bcs.n	c0d02926 <parser_getItem+0x2ea>
c0d02960:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02962:	1948      	adds	r0, r1, r5
c0d02964:	4288      	cmp	r0, r1
c0d02966:	d870      	bhi.n	c0d02a4a <parser_getItem+0x40e>
c0d02968:	e7b7      	b.n	c0d028da <parser_getItem+0x29e>
    return app_mode_expert();
c0d0296a:	f7fe f9d3 	bl	c0d00d14 <app_mode_expert>
        if( !parser_show_expert_fields() ){
c0d0296e:	4078      	eors	r0, r7
c0d02970:	1835      	adds	r5, r6, r0
c0d02972:	b2e8      	uxtb	r0, r5
        if( displayIdx == FIELD_ERA_PERIOD && parser_show_expert_fields() ) {
c0d02974:	2805      	cmp	r0, #5
c0d02976:	d13f      	bne.n	c0d029f8 <parser_getItem+0x3bc>
    return app_mode_expert();
c0d02978:	f7fe f9cc 	bl	c0d00d14 <app_mode_expert>
        if( displayIdx == FIELD_ERA_PERIOD && parser_show_expert_fields() ) {
c0d0297c:	2800      	cmp	r0, #0
c0d0297e:	d03b      	beq.n	c0d029f8 <parser_getItem+0x3bc>
            snprintf(outKey, outKeyLen, "Era Period");
c0d02980:	4a4b      	ldr	r2, [pc, #300]	; (c0d02ab0 <parser_getItem+0x474>)
c0d02982:	447a      	add	r2, pc
c0d02984:	9808      	ldr	r0, [sp, #32]
c0d02986:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d02988:	f7ff fbf2 	bl	c0d02170 <snprintf>
c0d0298c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0298e:	2802      	cmp	r0, #2
c0d02990:	9f07      	ldr	r7, [sp, #28]
c0d02992:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d02994:	d3a1      	bcc.n	c0d028da <parser_getItem+0x29e>
c0d02996:	6880      	ldr	r0, [r0, #8]
c0d02998:	6b84      	ldr	r4, [r0, #56]	; 0x38
c0d0299a:	6bc6      	ldr	r6, [r0, #60]	; 0x3c
c0d0299c:	9d0b      	ldr	r5, [sp, #44]	; 0x2c
c0d0299e:	4628      	mov	r0, r5
c0d029a0:	9f0a      	ldr	r7, [sp, #40]	; 0x28
c0d029a2:	4639      	mov	r1, r7
c0d029a4:	f004 fcc6 	bl	c0d07334 <explicit_bzero>
c0d029a8:	4620      	mov	r0, r4
c0d029aa:	4330      	orrs	r0, r6
c0d029ac:	d05b      	beq.n	c0d02a66 <parser_getItem+0x42a>
c0d029ae:	1e78      	subs	r0, r7, #1
c0d029b0:	9009      	str	r0, [sp, #36]	; 0x24
c0d029b2:	2500      	movs	r5, #0
c0d029b4:	9508      	str	r5, [sp, #32]
c0d029b6:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d029b8:	4285      	cmp	r5, r0
c0d029ba:	da3f      	bge.n	c0d02a3c <parser_getItem+0x400>
c0d029bc:	220a      	movs	r2, #10
c0d029be:	920a      	str	r2, [sp, #40]	; 0x28
c0d029c0:	2700      	movs	r7, #0
c0d029c2:	4620      	mov	r0, r4
c0d029c4:	4631      	mov	r1, r6
c0d029c6:	463b      	mov	r3, r7
c0d029c8:	f004 fbb4 	bl	c0d07134 <__aeabi_uldivmod>
c0d029cc:	900d      	str	r0, [sp, #52]	; 0x34
c0d029ce:	910c      	str	r1, [sp, #48]	; 0x30
c0d029d0:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d029d2:	463b      	mov	r3, r7
c0d029d4:	f004 fbce 	bl	c0d07174 <__aeabi_lmul>
c0d029d8:	1a20      	subs	r0, r4, r0
c0d029da:	2130      	movs	r1, #48	; 0x30
c0d029dc:	4301      	orrs	r1, r0
c0d029de:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d029e0:	5541      	strb	r1, [r0, r5]
c0d029e2:	1c6d      	adds	r5, r5, #1
c0d029e4:	3c0a      	subs	r4, #10
c0d029e6:	41be      	sbcs	r6, r7
c0d029e8:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d029ea:	9e0c      	ldr	r6, [sp, #48]	; 0x30
c0d029ec:	d2e3      	bcs.n	c0d029b6 <parser_getItem+0x37a>
c0d029ee:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d029f0:	1948      	adds	r0, r1, r5
c0d029f2:	4288      	cmp	r0, r1
c0d029f4:	d83a      	bhi.n	c0d02a6c <parser_getItem+0x430>
c0d029f6:	e770      	b.n	c0d028da <parser_getItem+0x29e>
    return app_mode_expert();
c0d029f8:	f7fe f98c 	bl	c0d00d14 <app_mode_expert>
        if( !parser_show_expert_fields() ){
c0d029fc:	4078      	eors	r0, r7
c0d029fe:	1828      	adds	r0, r5, r0
c0d02a00:	b2c0      	uxtb	r0, r0
        if( displayIdx == FIELD_BLOCK_HASH && parser_show_expert_fields() ) {
c0d02a02:	2806      	cmp	r0, #6
c0d02a04:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d02a06:	d000      	beq.n	c0d02a0a <parser_getItem+0x3ce>
c0d02a08:	e767      	b.n	c0d028da <parser_getItem+0x29e>
    return app_mode_expert();
c0d02a0a:	f7fe f983 	bl	c0d00d14 <app_mode_expert>
        if( displayIdx == FIELD_BLOCK_HASH && parser_show_expert_fields() ) {
c0d02a0e:	2800      	cmp	r0, #0
c0d02a10:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d02a12:	9e07      	ldr	r6, [sp, #28]
c0d02a14:	d100      	bne.n	c0d02a18 <parser_getItem+0x3dc>
c0d02a16:	e760      	b.n	c0d028da <parser_getItem+0x29e>
            snprintf(outKey, outKeyLen, "Block");
c0d02a18:	4a26      	ldr	r2, [pc, #152]	; (c0d02ab4 <parser_getItem+0x478>)
c0d02a1a:	447a      	add	r2, pc
c0d02a1c:	9808      	ldr	r0, [sp, #32]
c0d02a1e:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d02a20:	f7ff fba6 	bl	c0d02170 <snprintf>
            _toStringHash(&ctx->tx_obj->blockHash,
c0d02a24:	68a0      	ldr	r0, [r4, #8]
c0d02a26:	9500      	str	r5, [sp, #0]
c0d02a28:	3064      	adds	r0, #100	; 0x64
c0d02a2a:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02a2c:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d02a2e:	9b06      	ldr	r3, [sp, #24]
c0d02a30:	f001 fdd8 	bl	c0d045e4 <_toStringHash>
c0d02a34:	4637      	mov	r7, r6
c0d02a36:	e750      	b.n	c0d028da <parser_getItem+0x29e>
c0d02a38:	4617      	mov	r7, r2
c0d02a3a:	e74e      	b.n	c0d028da <parser_getItem+0x29e>
c0d02a3c:	9f08      	ldr	r7, [sp, #32]
c0d02a3e:	e74c      	b.n	c0d028da <parser_getItem+0x29e>
c0d02a40:	0000522a 	.word	0x0000522a
c0d02a44:	2030      	movs	r0, #48	; 0x30
c0d02a46:	7028      	strb	r0, [r5, #0]
c0d02a48:	1c68      	adds	r0, r5, #1
c0d02a4a:	1e40      	subs	r0, r0, #1
c0d02a4c:	2700      	movs	r7, #0
c0d02a4e:	43f9      	mvns	r1, r7
c0d02a50:	9c0b      	ldr	r4, [sp, #44]	; 0x2c
c0d02a52:	7822      	ldrb	r2, [r4, #0]
c0d02a54:	7803      	ldrb	r3, [r0, #0]
c0d02a56:	7023      	strb	r3, [r4, #0]
c0d02a58:	7002      	strb	r2, [r0, #0]
c0d02a5a:	1842      	adds	r2, r0, r1
c0d02a5c:	1c64      	adds	r4, r4, #1
c0d02a5e:	42a0      	cmp	r0, r4
c0d02a60:	4610      	mov	r0, r2
c0d02a62:	d8f6      	bhi.n	c0d02a52 <parser_getItem+0x416>
c0d02a64:	e739      	b.n	c0d028da <parser_getItem+0x29e>
c0d02a66:	2030      	movs	r0, #48	; 0x30
c0d02a68:	7028      	strb	r0, [r5, #0]
c0d02a6a:	1c68      	adds	r0, r5, #1
c0d02a6c:	1e40      	subs	r0, r0, #1
c0d02a6e:	2700      	movs	r7, #0
c0d02a70:	43f9      	mvns	r1, r7
c0d02a72:	9c0b      	ldr	r4, [sp, #44]	; 0x2c
c0d02a74:	7822      	ldrb	r2, [r4, #0]
c0d02a76:	7803      	ldrb	r3, [r0, #0]
c0d02a78:	7023      	strb	r3, [r4, #0]
c0d02a7a:	7002      	strb	r2, [r0, #0]
c0d02a7c:	1842      	adds	r2, r0, r1
c0d02a7e:	1c64      	adds	r4, r4, #1
c0d02a80:	42a0      	cmp	r0, r4
c0d02a82:	4610      	mov	r0, r2
c0d02a84:	d8f6      	bhi.n	c0d02a74 <parser_getItem+0x438>
c0d02a86:	e728      	b.n	c0d028da <parser_getItem+0x29e>
c0d02a88:	000003fe 	.word	0x000003fe
c0d02a8c:	0000ffff 	.word	0x0000ffff
c0d02a90:	0000517a 	.word	0x0000517a
c0d02a94:	00005132 	.word	0x00005132
c0d02a98:	000050ed 	.word	0x000050ed
c0d02a9c:	000050e7 	.word	0x000050e7
c0d02aa0:	00004fdc 	.word	0x00004fdc
c0d02aa4:	000050d1 	.word	0x000050d1
c0d02aa8:	0000508f 	.word	0x0000508f
c0d02aac:	00004fbd 	.word	0x00004fbd
c0d02ab0:	00004f37 	.word	0x00004f37
c0d02ab4:	00004eaa 	.word	0x00004eaa

c0d02ab8 <parser_init>:
    ctx->buffer = buffer;
    ctx->bufferLen = bufferSize;
    return parser_ok;
}

parser_error_t parser_init(parser_context_t *ctx, const uint8_t *buffer, uint16_t bufferSize) {
c0d02ab8:	b510      	push	{r4, lr}
c0d02aba:	2300      	movs	r3, #0
    ctx->buffer = NULL;
c0d02abc:	6003      	str	r3, [r0, #0]
c0d02abe:	6043      	str	r3, [r0, #4]
c0d02ac0:	2402      	movs	r4, #2
    if (bufferSize == 0 || buffer == NULL) {
c0d02ac2:	2900      	cmp	r1, #0
c0d02ac4:	d004      	beq.n	c0d02ad0 <parser_init+0x18>
c0d02ac6:	2a00      	cmp	r2, #0
c0d02ac8:	d002      	beq.n	c0d02ad0 <parser_init+0x18>
    ctx->bufferLen = bufferSize;
c0d02aca:	8082      	strh	r2, [r0, #4]
    ctx->buffer = buffer;
c0d02acc:	6001      	str	r1, [r0, #0]
c0d02ace:	461c      	mov	r4, r3
    CHECK_PARSER_ERR(parser_init_context(ctx, buffer, bufferSize))
c0d02ad0:	f004 fa78 	bl	c0d06fc4 <check_app_canary>
    return parser_ok;
}
c0d02ad4:	4620      	mov	r0, r4
c0d02ad6:	bd10      	pop	{r4, pc}

c0d02ad8 <parser_getErrorDescription>:

const char *parser_getErrorDescription(parser_error_t err) {
    switch (err) {
c0d02ad8:	280b      	cmp	r0, #11
c0d02ada:	dc0c      	bgt.n	c0d02af6 <parser_getErrorDescription+0x1e>
c0d02adc:	2806      	cmp	r0, #6
c0d02ade:	dc17      	bgt.n	c0d02b10 <parser_getErrorDescription+0x38>
c0d02ae0:	2801      	cmp	r0, #1
c0d02ae2:	dd2b      	ble.n	c0d02b3c <parser_getErrorDescription+0x64>
c0d02ae4:	2802      	cmp	r0, #2
c0d02ae6:	d045      	beq.n	c0d02b74 <parser_getErrorDescription+0x9c>
c0d02ae8:	2803      	cmp	r0, #3
c0d02aea:	d046      	beq.n	c0d02b7a <parser_getErrorDescription+0xa2>
c0d02aec:	2804      	cmp	r0, #4
c0d02aee:	d165      	bne.n	c0d02bbc <parser_getErrorDescription+0xe4>
c0d02af0:	4835      	ldr	r0, [pc, #212]	; (c0d02bc8 <parser_getErrorDescription+0xf0>)
c0d02af2:	4478      	add	r0, pc
        case parser_tx_call_vec_too_large:
            return "Call vector exceeds limit";
        default:
            return "Unrecognized error code";
    }
}
c0d02af4:	4770      	bx	lr
    switch (err) {
c0d02af6:	2811      	cmp	r0, #17
c0d02af8:	dc15      	bgt.n	c0d02b26 <parser_getErrorDescription+0x4e>
c0d02afa:	280d      	cmp	r0, #13
c0d02afc:	dd25      	ble.n	c0d02b4a <parser_getErrorDescription+0x72>
c0d02afe:	280e      	cmp	r0, #14
c0d02b00:	d03e      	beq.n	c0d02b80 <parser_getErrorDescription+0xa8>
c0d02b02:	280f      	cmp	r0, #15
c0d02b04:	d03f      	beq.n	c0d02b86 <parser_getErrorDescription+0xae>
c0d02b06:	2810      	cmp	r0, #16
c0d02b08:	d158      	bne.n	c0d02bbc <parser_getErrorDescription+0xe4>
c0d02b0a:	4833      	ldr	r0, [pc, #204]	; (c0d02bd8 <parser_getErrorDescription+0x100>)
c0d02b0c:	4478      	add	r0, pc
}
c0d02b0e:	4770      	bx	lr
    switch (err) {
c0d02b10:	2808      	cmp	r0, #8
c0d02b12:	dd21      	ble.n	c0d02b58 <parser_getErrorDescription+0x80>
c0d02b14:	2809      	cmp	r0, #9
c0d02b16:	d039      	beq.n	c0d02b8c <parser_getErrorDescription+0xb4>
c0d02b18:	280a      	cmp	r0, #10
c0d02b1a:	d03a      	beq.n	c0d02b92 <parser_getErrorDescription+0xba>
c0d02b1c:	280b      	cmp	r0, #11
c0d02b1e:	d14d      	bne.n	c0d02bbc <parser_getErrorDescription+0xe4>
c0d02b20:	482b      	ldr	r0, [pc, #172]	; (c0d02bd0 <parser_getErrorDescription+0xf8>)
c0d02b22:	4478      	add	r0, pc
}
c0d02b24:	4770      	bx	lr
    switch (err) {
c0d02b26:	2813      	cmp	r0, #19
c0d02b28:	dd1d      	ble.n	c0d02b66 <parser_getErrorDescription+0x8e>
c0d02b2a:	2814      	cmp	r0, #20
c0d02b2c:	d034      	beq.n	c0d02b98 <parser_getErrorDescription+0xc0>
c0d02b2e:	2815      	cmp	r0, #21
c0d02b30:	d035      	beq.n	c0d02b9e <parser_getErrorDescription+0xc6>
c0d02b32:	2816      	cmp	r0, #22
c0d02b34:	d142      	bne.n	c0d02bbc <parser_getErrorDescription+0xe4>
c0d02b36:	482a      	ldr	r0, [pc, #168]	; (c0d02be0 <parser_getErrorDescription+0x108>)
c0d02b38:	4478      	add	r0, pc
}
c0d02b3a:	4770      	bx	lr
    switch (err) {
c0d02b3c:	2800      	cmp	r0, #0
c0d02b3e:	d031      	beq.n	c0d02ba4 <parser_getErrorDescription+0xcc>
c0d02b40:	2801      	cmp	r0, #1
c0d02b42:	d13b      	bne.n	c0d02bbc <parser_getErrorDescription+0xe4>
c0d02b44:	4827      	ldr	r0, [pc, #156]	; (c0d02be4 <parser_getErrorDescription+0x10c>)
c0d02b46:	4478      	add	r0, pc
}
c0d02b48:	4770      	bx	lr
    switch (err) {
c0d02b4a:	280c      	cmp	r0, #12
c0d02b4c:	d02d      	beq.n	c0d02baa <parser_getErrorDescription+0xd2>
c0d02b4e:	280d      	cmp	r0, #13
c0d02b50:	d134      	bne.n	c0d02bbc <parser_getErrorDescription+0xe4>
c0d02b52:	4820      	ldr	r0, [pc, #128]	; (c0d02bd4 <parser_getErrorDescription+0xfc>)
c0d02b54:	4478      	add	r0, pc
}
c0d02b56:	4770      	bx	lr
    switch (err) {
c0d02b58:	2807      	cmp	r0, #7
c0d02b5a:	d029      	beq.n	c0d02bb0 <parser_getErrorDescription+0xd8>
c0d02b5c:	2808      	cmp	r0, #8
c0d02b5e:	d12d      	bne.n	c0d02bbc <parser_getErrorDescription+0xe4>
c0d02b60:	481a      	ldr	r0, [pc, #104]	; (c0d02bcc <parser_getErrorDescription+0xf4>)
c0d02b62:	4478      	add	r0, pc
}
c0d02b64:	4770      	bx	lr
    switch (err) {
c0d02b66:	2812      	cmp	r0, #18
c0d02b68:	d025      	beq.n	c0d02bb6 <parser_getErrorDescription+0xde>
c0d02b6a:	2813      	cmp	r0, #19
c0d02b6c:	d126      	bne.n	c0d02bbc <parser_getErrorDescription+0xe4>
c0d02b6e:	481b      	ldr	r0, [pc, #108]	; (c0d02bdc <parser_getErrorDescription+0x104>)
c0d02b70:	4478      	add	r0, pc
}
c0d02b72:	4770      	bx	lr
c0d02b74:	481c      	ldr	r0, [pc, #112]	; (c0d02be8 <parser_getErrorDescription+0x110>)
c0d02b76:	4478      	add	r0, pc
c0d02b78:	4770      	bx	lr
c0d02b7a:	481c      	ldr	r0, [pc, #112]	; (c0d02bec <parser_getErrorDescription+0x114>)
c0d02b7c:	4478      	add	r0, pc
c0d02b7e:	4770      	bx	lr
c0d02b80:	481f      	ldr	r0, [pc, #124]	; (c0d02c00 <parser_getErrorDescription+0x128>)
c0d02b82:	4478      	add	r0, pc
c0d02b84:	4770      	bx	lr
c0d02b86:	481f      	ldr	r0, [pc, #124]	; (c0d02c04 <parser_getErrorDescription+0x12c>)
c0d02b88:	4478      	add	r0, pc
c0d02b8a:	4770      	bx	lr
c0d02b8c:	4819      	ldr	r0, [pc, #100]	; (c0d02bf4 <parser_getErrorDescription+0x11c>)
c0d02b8e:	4478      	add	r0, pc
c0d02b90:	4770      	bx	lr
c0d02b92:	4819      	ldr	r0, [pc, #100]	; (c0d02bf8 <parser_getErrorDescription+0x120>)
c0d02b94:	4478      	add	r0, pc
c0d02b96:	4770      	bx	lr
c0d02b98:	481c      	ldr	r0, [pc, #112]	; (c0d02c0c <parser_getErrorDescription+0x134>)
c0d02b9a:	4478      	add	r0, pc
c0d02b9c:	4770      	bx	lr
c0d02b9e:	481c      	ldr	r0, [pc, #112]	; (c0d02c10 <parser_getErrorDescription+0x138>)
c0d02ba0:	4478      	add	r0, pc
c0d02ba2:	4770      	bx	lr
c0d02ba4:	4807      	ldr	r0, [pc, #28]	; (c0d02bc4 <parser_getErrorDescription+0xec>)
c0d02ba6:	4478      	add	r0, pc
c0d02ba8:	4770      	bx	lr
c0d02baa:	4814      	ldr	r0, [pc, #80]	; (c0d02bfc <parser_getErrorDescription+0x124>)
c0d02bac:	4478      	add	r0, pc
c0d02bae:	4770      	bx	lr
c0d02bb0:	480f      	ldr	r0, [pc, #60]	; (c0d02bf0 <parser_getErrorDescription+0x118>)
c0d02bb2:	4478      	add	r0, pc
c0d02bb4:	4770      	bx	lr
c0d02bb6:	4814      	ldr	r0, [pc, #80]	; (c0d02c08 <parser_getErrorDescription+0x130>)
c0d02bb8:	4478      	add	r0, pc
c0d02bba:	4770      	bx	lr
c0d02bbc:	4815      	ldr	r0, [pc, #84]	; (c0d02c14 <parser_getErrorDescription+0x13c>)
c0d02bbe:	4478      	add	r0, pc
c0d02bc0:	4770      	bx	lr
c0d02bc2:	46c0      	nop			; (mov r8, r8)
c0d02bc4:	00004d24 	.word	0x00004d24
c0d02bc8:	00004e21 	.word	0x00004e21
c0d02bcc:	00004de6 	.word	0x00004de6
c0d02bd0:	00004e5a 	.word	0x00004e5a
c0d02bd4:	00004e4f 	.word	0x00004e4f
c0d02bd8:	00004ed1 	.word	0x00004ed1
c0d02bdc:	00004e9d 	.word	0x00004e9d
c0d02be0:	00004f21 	.word	0x00004f21
c0d02be4:	00004d8d 	.word	0x00004d8d
c0d02be8:	00004d6a 	.word	0x00004d6a
c0d02bec:	00004d7e 	.word	0x00004d7e
c0d02bf0:	00004d7b 	.word	0x00004d7b
c0d02bf4:	00004dd4 	.word	0x00004dd4
c0d02bf8:	00004dda 	.word	0x00004dda
c0d02bfc:	00004de6 	.word	0x00004de6
c0d02c00:	00004e34 	.word	0x00004e34
c0d02c04:	00004e43 	.word	0x00004e43
c0d02c08:	00004e3b 	.word	0x00004e3b
c0d02c0c:	00004e8b 	.word	0x00004e8b
c0d02c10:	00004ea0 	.word	0x00004ea0
c0d02c14:	00004eb5 	.word	0x00004eb5

c0d02c18 <_readUInt8>:

GEN_DEF_READFIX_UNSIGNED(8)
c0d02c18:	b510      	push	{r4, lr}
c0d02c1a:	2900      	cmp	r1, #0
c0d02c1c:	d00d      	beq.n	c0d02c3a <_readUInt8+0x22>
c0d02c1e:	4602      	mov	r2, r0
c0d02c20:	2000      	movs	r0, #0
c0d02c22:	7008      	strb	r0, [r1, #0]
c0d02c24:	88d3      	ldrh	r3, [r2, #6]
c0d02c26:	8894      	ldrh	r4, [r2, #4]
c0d02c28:	42a3      	cmp	r3, r4
c0d02c2a:	d208      	bcs.n	c0d02c3e <_readUInt8+0x26>
c0d02c2c:	6814      	ldr	r4, [r2, #0]
c0d02c2e:	5ce3      	ldrb	r3, [r4, r3]
c0d02c30:	700b      	strb	r3, [r1, #0]
c0d02c32:	88d1      	ldrh	r1, [r2, #6]
c0d02c34:	1c49      	adds	r1, r1, #1
c0d02c36:	80d1      	strh	r1, [r2, #6]
c0d02c38:	bd10      	pop	{r4, pc}
c0d02c3a:	2001      	movs	r0, #1
c0d02c3c:	bd10      	pop	{r4, pc}
c0d02c3e:	200b      	movs	r0, #11
c0d02c40:	bd10      	pop	{r4, pc}

c0d02c42 <_readUInt32>:

GEN_DEF_READFIX_UNSIGNED(16)

GEN_DEF_READFIX_UNSIGNED(32)
c0d02c42:	b570      	push	{r4, r5, r6, lr}
c0d02c44:	2900      	cmp	r1, #0
c0d02c46:	d012      	beq.n	c0d02c6e <_readUInt32+0x2c>
c0d02c48:	2200      	movs	r2, #0
c0d02c4a:	600a      	str	r2, [r1, #0]
c0d02c4c:	88c3      	ldrh	r3, [r0, #6]
c0d02c4e:	8884      	ldrh	r4, [r0, #4]
c0d02c50:	4615      	mov	r5, r2
c0d02c52:	42a3      	cmp	r3, r4
c0d02c54:	d20d      	bcs.n	c0d02c72 <_readUInt32+0x30>
c0d02c56:	6806      	ldr	r6, [r0, #0]
c0d02c58:	5cf6      	ldrb	r6, [r6, r3]
c0d02c5a:	1c5b      	adds	r3, r3, #1
c0d02c5c:	80c3      	strh	r3, [r0, #6]
c0d02c5e:	4096      	lsls	r6, r2
c0d02c60:	1975      	adds	r5, r6, r5
c0d02c62:	600d      	str	r5, [r1, #0]
c0d02c64:	3208      	adds	r2, #8
c0d02c66:	2a20      	cmp	r2, #32
c0d02c68:	d1f3      	bne.n	c0d02c52 <_readUInt32+0x10>
c0d02c6a:	2000      	movs	r0, #0
c0d02c6c:	bd70      	pop	{r4, r5, r6, pc}
c0d02c6e:	2001      	movs	r0, #1
c0d02c70:	bd70      	pop	{r4, r5, r6, pc}
c0d02c72:	200b      	movs	r0, #11
c0d02c74:	bd70      	pop	{r4, r5, r6, pc}

c0d02c76 <_readCompactInt>:
            return parser_unexpected_value;
    }
    return parser_ok;
}

parser_error_t _readCompactInt(parser_context_t *c, compactInt_t *v) {
c0d02c76:	b5b0      	push	{r4, r5, r7, lr}
c0d02c78:	b082      	sub	sp, #8
    CHECK_INPUT();
c0d02c7a:	2900      	cmp	r1, #0
c0d02c7c:	d014      	beq.n	c0d02ca8 <_readCompactInt+0x32>
c0d02c7e:	220b      	movs	r2, #11
c0d02c80:	2800      	cmp	r0, #0
c0d02c82:	d02f      	beq.n	c0d02ce4 <_readCompactInt+0x6e>
c0d02c84:	8883      	ldrh	r3, [r0, #4]
c0d02c86:	88c4      	ldrh	r4, [r0, #6]
c0d02c88:	429c      	cmp	r4, r3
c0d02c8a:	d22b      	bcs.n	c0d02ce4 <_readCompactInt+0x6e>

    v->ptr = c->buffer + c->offset;
c0d02c8c:	6802      	ldr	r2, [r0, #0]
c0d02c8e:	1915      	adds	r5, r2, r4
c0d02c90:	600d      	str	r5, [r1, #0]
    const uint8_t mode = *v->ptr & 0x03u;      // get mode from two least significant bits
c0d02c92:	5d12      	ldrb	r2, [r2, r4]
c0d02c94:	2503      	movs	r5, #3
c0d02c96:	4015      	ands	r5, r2

    uint64_t tmp;
    switch (mode) {
c0d02c98:	2d01      	cmp	r5, #1
c0d02c9a:	dc07      	bgt.n	c0d02cac <_readCompactInt+0x36>
c0d02c9c:	2d00      	cmp	r5, #0
c0d02c9e:	d10b      	bne.n	c0d02cb8 <_readCompactInt+0x42>
c0d02ca0:	2201      	movs	r2, #1
        case 0:         // single byte
            v->len = 1;
c0d02ca2:	710a      	strb	r2, [r1, #4]
            CTX_CHECK_AND_ADVANCE(c, v->len)
c0d02ca4:	1c62      	adds	r2, r4, #1
c0d02ca6:	e00c      	b.n	c0d02cc2 <_readCompactInt+0x4c>
c0d02ca8:	2201      	movs	r2, #1
c0d02caa:	e01b      	b.n	c0d02ce4 <_readCompactInt+0x6e>
    switch (mode) {
c0d02cac:	2d02      	cmp	r5, #2
c0d02cae:	d10f      	bne.n	c0d02cd0 <_readCompactInt+0x5a>
c0d02cb0:	2204      	movs	r2, #4
            v->len = 2;
            CTX_CHECK_AND_ADVANCE(c, v->len)
            _getValue(v, &tmp);
            break;
        case 2:         // 4-byte
            v->len = 4;
c0d02cb2:	710a      	strb	r2, [r1, #4]
            CTX_CHECK_AND_ADVANCE(c, v->len)
c0d02cb4:	1d22      	adds	r2, r4, #4
c0d02cb6:	e002      	b.n	c0d02cbe <_readCompactInt+0x48>
c0d02cb8:	2202      	movs	r2, #2
            v->len = 2;
c0d02cba:	710a      	strb	r2, [r1, #4]
            CTX_CHECK_AND_ADVANCE(c, v->len)
c0d02cbc:	1ca2      	adds	r2, r4, #2
c0d02cbe:	429a      	cmp	r2, r3
c0d02cc0:	d80c      	bhi.n	c0d02cdc <_readCompactInt+0x66>
c0d02cc2:	80c2      	strh	r2, [r0, #6]
c0d02cc4:	466a      	mov	r2, sp
c0d02cc6:	4608      	mov	r0, r1
c0d02cc8:	4611      	mov	r1, r2
c0d02cca:	f000 f80f 	bl	c0d02cec <_getValue>
c0d02cce:	e008      	b.n	c0d02ce2 <_readCompactInt+0x6c>
            _getValue(v, &tmp);
            break;
        case 3:         // bigint
            v->len = (*v->ptr >> 2u) + 4 + 1;
c0d02cd0:	0892      	lsrs	r2, r2, #2
c0d02cd2:	1d52      	adds	r2, r2, #5
c0d02cd4:	710a      	strb	r2, [r1, #4]
            CTX_CHECK_AND_ADVANCE(c, v->len)
c0d02cd6:	1911      	adds	r1, r2, r4
c0d02cd8:	4299      	cmp	r1, r3
c0d02cda:	d901      	bls.n	c0d02ce0 <_readCompactInt+0x6a>
c0d02cdc:	220b      	movs	r2, #11
c0d02cde:	e001      	b.n	c0d02ce4 <_readCompactInt+0x6e>
c0d02ce0:	80c1      	strh	r1, [r0, #6]
c0d02ce2:	2200      	movs	r2, #0
            // this is actually impossible
            return parser_unexpected_value;
    }

    return parser_ok;
}
c0d02ce4:	4610      	mov	r0, r2
c0d02ce6:	b002      	add	sp, #8
c0d02ce8:	bdb0      	pop	{r4, r5, r7, pc}
	...

c0d02cec <_getValue>:

parser_error_t _getValue(const compactInt_t *c, uint64_t *v) {
c0d02cec:	b570      	push	{r4, r5, r6, lr}
c0d02cee:	4602      	mov	r2, r0
c0d02cf0:	2300      	movs	r3, #0
    *v = 0;
c0d02cf2:	600b      	str	r3, [r1, #0]
c0d02cf4:	604b      	str	r3, [r1, #4]

    switch (c->len) {
c0d02cf6:	7904      	ldrb	r4, [r0, #4]
c0d02cf8:	200d      	movs	r0, #13
c0d02cfa:	2c04      	cmp	r4, #4
c0d02cfc:	d008      	beq.n	c0d02d10 <_getValue+0x24>
c0d02cfe:	2c02      	cmp	r4, #2
c0d02d00:	d021      	beq.n	c0d02d46 <_getValue+0x5a>
c0d02d02:	2c01      	cmp	r4, #1
c0d02d04:	d11e      	bne.n	c0d02d44 <_getValue+0x58>
        case 1:
            *v = (*c->ptr) >> 2u;
c0d02d06:	6810      	ldr	r0, [r2, #0]
c0d02d08:	7800      	ldrb	r0, [r0, #0]
c0d02d0a:	0880      	lsrs	r0, r0, #2
c0d02d0c:	c109      	stmia	r1!, {r0, r3}
c0d02d0e:	e018      	b.n	c0d02d42 <_getValue+0x56>
            if (*v < 64) {
                return parser_value_out_of_range;
            }
            break;
        case 4:
            *v = (*c->ptr) >> 2u;
c0d02d10:	6814      	ldr	r4, [r2, #0]
c0d02d12:	7825      	ldrb	r5, [r4, #0]
c0d02d14:	2200      	movs	r2, #0
c0d02d16:	08ad      	lsrs	r5, r5, #2
c0d02d18:	600d      	str	r5, [r1, #0]
c0d02d1a:	604a      	str	r2, [r1, #4]
            *v += *(c->ptr + 1) << 6u;
c0d02d1c:	7866      	ldrb	r6, [r4, #1]
c0d02d1e:	01b6      	lsls	r6, r6, #6
c0d02d20:	1975      	adds	r5, r6, r5
c0d02d22:	600d      	str	r5, [r1, #0]
c0d02d24:	604a      	str	r2, [r1, #4]
            *v += *(c->ptr + 2) << (8u + 6u);
c0d02d26:	78a6      	ldrb	r6, [r4, #2]
c0d02d28:	03b6      	lsls	r6, r6, #14
c0d02d2a:	19ad      	adds	r5, r5, r6
c0d02d2c:	600d      	str	r5, [r1, #0]
c0d02d2e:	604a      	str	r2, [r1, #4]
            *v += *(c->ptr + 3) << (16u + 6u);
c0d02d30:	78e4      	ldrb	r4, [r4, #3]
c0d02d32:	05a4      	lsls	r4, r4, #22
c0d02d34:	192c      	adds	r4, r5, r4
c0d02d36:	600c      	str	r4, [r1, #0]
c0d02d38:	604a      	str	r2, [r1, #4]
c0d02d3a:	490a      	ldr	r1, [pc, #40]	; (c0d02d64 <_getValue+0x78>)
            if (*v < 16383) {
c0d02d3c:	1a61      	subs	r1, r4, r1
c0d02d3e:	4192      	sbcs	r2, r2
c0d02d40:	d300      	bcc.n	c0d02d44 <_getValue+0x58>
c0d02d42:	4618      	mov	r0, r3
        default:
            return parser_value_out_of_range;
    }

    return parser_ok;
}
c0d02d44:	bd70      	pop	{r4, r5, r6, pc}
            *v = (*c->ptr) >> 2u;
c0d02d46:	6812      	ldr	r2, [r2, #0]
c0d02d48:	7814      	ldrb	r4, [r2, #0]
c0d02d4a:	08a4      	lsrs	r4, r4, #2
c0d02d4c:	600c      	str	r4, [r1, #0]
c0d02d4e:	604b      	str	r3, [r1, #4]
            *v += *(c->ptr + 1) << 6u;
c0d02d50:	7852      	ldrb	r2, [r2, #1]
c0d02d52:	0192      	lsls	r2, r2, #6
c0d02d54:	1912      	adds	r2, r2, r4
c0d02d56:	c10c      	stmia	r1!, {r2, r3}
            if (*v < 64) {
c0d02d58:	3a40      	subs	r2, #64	; 0x40
c0d02d5a:	4619      	mov	r1, r3
c0d02d5c:	4199      	sbcs	r1, r3
c0d02d5e:	d2f0      	bcs.n	c0d02d42 <_getValue+0x56>
c0d02d60:	e7f0      	b.n	c0d02d44 <_getValue+0x58>
c0d02d62:	46c0      	nop			; (mov r8, r8)
c0d02d64:	00003fff 	.word	0x00003fff

c0d02d68 <_toStringCompactInt>:
parser_error_t _toStringCompactInt(const compactInt_t *c,
                                   uint8_t decimalPlaces,
                                   char postfix,
                                   char prefix[],
                                   char *outValue, uint16_t outValueLen,
                                   uint8_t pageIdx, uint8_t *pageCount) {
c0d02d68:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02d6a:	b0ef      	sub	sp, #444	; 0x1bc
c0d02d6c:	461d      	mov	r5, r3
c0d02d6e:	4617      	mov	r7, r2
c0d02d70:	9105      	str	r1, [sp, #20]
c0d02d72:	4604      	mov	r4, r0
c0d02d74:	9e74      	ldr	r6, [sp, #464]	; 0x1d0
c0d02d76:	9975      	ldr	r1, [sp, #468]	; 0x1d4
    char bufferUI[200];
    MEMZERO(outValue, outValueLen);
c0d02d78:	4630      	mov	r0, r6
c0d02d7a:	9103      	str	r1, [sp, #12]
c0d02d7c:	f004 fada 	bl	c0d07334 <explicit_bzero>
c0d02d80:	a83d      	add	r0, sp, #244	; 0xf4
c0d02d82:	21c8      	movs	r1, #200	; 0xc8
    MEMZERO(bufferUI, sizeof(bufferUI));
c0d02d84:	f004 fad6 	bl	c0d07334 <explicit_bzero>
c0d02d88:	9977      	ldr	r1, [sp, #476]	; 0x1dc
c0d02d8a:	2001      	movs	r0, #1
c0d02d8c:	9104      	str	r1, [sp, #16]
    *pageCount = 1;
c0d02d8e:	7008      	strb	r0, [r1, #0]

    if (c->len <= 4) {
c0d02d90:	7920      	ldrb	r0, [r4, #4]
c0d02d92:	2804      	cmp	r0, #4
c0d02d94:	9606      	str	r6, [sp, #24]
c0d02d96:	d82f      	bhi.n	c0d02df8 <_toStringCompactInt+0x90>
c0d02d98:	9702      	str	r7, [sp, #8]
c0d02d9a:	a90a      	add	r1, sp, #40	; 0x28
        uint64_t v;
        _getValue(c, &v);
c0d02d9c:	4620      	mov	r0, r4
c0d02d9e:	f7ff ffa5 	bl	c0d02cec <_getValue>
        if (uint64_to_str(bufferUI, sizeof(bufferUI), v) != NULL) {
c0d02da2:	9c0b      	ldr	r4, [sp, #44]	; 0x2c
c0d02da4:	9f0a      	ldr	r7, [sp, #40]	; 0x28
c0d02da6:	a83d      	add	r0, sp, #244	; 0xf4
c0d02da8:	21c8      	movs	r1, #200	; 0xc8
c0d02daa:	f004 fac3 	bl	c0d07334 <explicit_bzero>
c0d02dae:	4638      	mov	r0, r7
c0d02db0:	4320      	orrs	r0, r4
c0d02db2:	d037      	beq.n	c0d02e24 <_toStringCompactInt+0xbc>
c0d02db4:	9501      	str	r5, [sp, #4]
c0d02db6:	2600      	movs	r6, #0
c0d02db8:	2ec7      	cmp	r6, #199	; 0xc7
c0d02dba:	d100      	bne.n	c0d02dbe <_toStringCompactInt+0x56>
c0d02dbc:	e0b9      	b.n	c0d02f32 <_toStringCompactInt+0x1ca>
c0d02dbe:	220a      	movs	r2, #10
c0d02dc0:	9207      	str	r2, [sp, #28]
c0d02dc2:	2500      	movs	r5, #0
c0d02dc4:	4638      	mov	r0, r7
c0d02dc6:	4621      	mov	r1, r4
c0d02dc8:	462b      	mov	r3, r5
c0d02dca:	f004 f9b3 	bl	c0d07134 <__aeabi_uldivmod>
c0d02dce:	9009      	str	r0, [sp, #36]	; 0x24
c0d02dd0:	9108      	str	r1, [sp, #32]
c0d02dd2:	9a07      	ldr	r2, [sp, #28]
c0d02dd4:	462b      	mov	r3, r5
c0d02dd6:	f004 f9cd 	bl	c0d07174 <__aeabi_lmul>
c0d02dda:	1a38      	subs	r0, r7, r0
c0d02ddc:	2130      	movs	r1, #48	; 0x30
c0d02dde:	4301      	orrs	r1, r0
c0d02de0:	a83d      	add	r0, sp, #244	; 0xf4
c0d02de2:	5581      	strb	r1, [r0, r6]
c0d02de4:	1c76      	adds	r6, r6, #1
c0d02de6:	3f0a      	subs	r7, #10
c0d02de8:	41ac      	sbcs	r4, r5
c0d02dea:	9f09      	ldr	r7, [sp, #36]	; 0x24
c0d02dec:	9c08      	ldr	r4, [sp, #32]
c0d02dee:	d2e3      	bcs.n	c0d02db8 <_toStringCompactInt+0x50>
c0d02df0:	a83d      	add	r0, sp, #244	; 0xf4
c0d02df2:	1980      	adds	r0, r0, r6
c0d02df4:	9d01      	ldr	r5, [sp, #4]
c0d02df6:	e019      	b.n	c0d02e2c <_toStringCompactInt+0xc4>
    } else {
        // This is longer number
        uint8_t bcdOut[100];
        const uint16_t bcdOutLen = sizeof(bcdOut);

        bignumLittleEndian_to_bcd(bcdOut, bcdOutLen, c->ptr + 1, c->len - 1);
c0d02df8:	6821      	ldr	r1, [r4, #0]
c0d02dfa:	1c4a      	adds	r2, r1, #1
c0d02dfc:	1e40      	subs	r0, r0, #1
c0d02dfe:	b283      	uxth	r3, r0
c0d02e00:	ac0a      	add	r4, sp, #40	; 0x28
c0d02e02:	462e      	mov	r6, r5
c0d02e04:	2564      	movs	r5, #100	; 0x64
c0d02e06:	4620      	mov	r0, r4
c0d02e08:	4629      	mov	r1, r5
c0d02e0a:	f7fe f87b 	bl	c0d00f04 <bignumLittleEndian_to_bcd>
c0d02e0e:	a83d      	add	r0, sp, #244	; 0xf4
c0d02e10:	21c8      	movs	r1, #200	; 0xc8
        if (!bignumLittleEndian_bcdprint(bufferUI, sizeof(bufferUI), bcdOut, bcdOutLen))
c0d02e12:	4622      	mov	r2, r4
c0d02e14:	462b      	mov	r3, r5
c0d02e16:	4635      	mov	r5, r6
c0d02e18:	f7fe f82a 	bl	c0d00e70 <bignumLittleEndian_bcdprint>
c0d02e1c:	2800      	cmp	r0, #0
c0d02e1e:	d113      	bne.n	c0d02e48 <_toStringCompactInt+0xe0>
c0d02e20:	260b      	movs	r6, #11
c0d02e22:	e08c      	b.n	c0d02f3e <_toStringCompactInt+0x1d6>
c0d02e24:	a83d      	add	r0, sp, #244	; 0xf4
c0d02e26:	2130      	movs	r1, #48	; 0x30
c0d02e28:	7001      	strb	r1, [r0, #0]
c0d02e2a:	1c40      	adds	r0, r0, #1
c0d02e2c:	1e40      	subs	r0, r0, #1
c0d02e2e:	2100      	movs	r1, #0
c0d02e30:	43c9      	mvns	r1, r1
c0d02e32:	aa3d      	add	r2, sp, #244	; 0xf4
c0d02e34:	9f02      	ldr	r7, [sp, #8]
c0d02e36:	7813      	ldrb	r3, [r2, #0]
c0d02e38:	7804      	ldrb	r4, [r0, #0]
c0d02e3a:	7014      	strb	r4, [r2, #0]
c0d02e3c:	7003      	strb	r3, [r0, #0]
c0d02e3e:	1843      	adds	r3, r0, r1
c0d02e40:	1c52      	adds	r2, r2, #1
c0d02e42:	4290      	cmp	r0, r2
c0d02e44:	4618      	mov	r0, r3
c0d02e46:	d8f6      	bhi.n	c0d02e36 <_toStringCompactInt+0xce>
c0d02e48:	a83d      	add	r0, sp, #244	; 0xf4
c0d02e4a:	21c8      	movs	r1, #200	; 0xc8
            return parser_unexpected_buffer_end;
    }

    // Format number
    if (intstr_to_fpstr_inplace(bufferUI, sizeof(bufferUI), decimalPlaces) == 0){
c0d02e4c:	9a05      	ldr	r2, [sp, #20]
c0d02e4e:	f004 f83b 	bl	c0d06ec8 <intstr_to_fpstr_inplace>
c0d02e52:	2800      	cmp	r0, #0
c0d02e54:	d06d      	beq.n	c0d02f32 <_toStringCompactInt+0x1ca>
        return parser_unexpected_value;
    }

    // Add prefix
    if (strlen(prefix) > 0) {
c0d02e56:	7828      	ldrb	r0, [r5, #0]
c0d02e58:	2800      	cmp	r0, #0
c0d02e5a:	9e06      	ldr	r6, [sp, #24]
c0d02e5c:	d02f      	beq.n	c0d02ebe <_toStringCompactInt+0x156>
c0d02e5e:	ac3d      	add	r4, sp, #244	; 0xf4
        size_t size = strlen(bufferUI) + strlen(prefix) + 2;
c0d02e60:	4620      	mov	r0, r4
c0d02e62:	f004 fbf7 	bl	c0d07654 <strlen>
c0d02e66:	9009      	str	r0, [sp, #36]	; 0x24
c0d02e68:	4628      	mov	r0, r5
c0d02e6a:	f004 fbf3 	bl	c0d07654 <strlen>
c0d02e6e:	9008      	str	r0, [sp, #32]
c0d02e70:	9702      	str	r7, [sp, #8]
c0d02e72:	af0a      	add	r7, sp, #40	; 0x28
c0d02e74:	26c8      	movs	r6, #200	; 0xc8
        char _tmpBuffer[200];
        MEMZERO(_tmpBuffer, sizeof(_tmpBuffer));
c0d02e76:	4638      	mov	r0, r7
c0d02e78:	4631      	mov	r1, r6
c0d02e7a:	f004 fa5b 	bl	c0d07334 <explicit_bzero>
        strlcat(_tmpBuffer, prefix, sizeof(_tmpBuffer));
c0d02e7e:	4638      	mov	r0, r7
c0d02e80:	4629      	mov	r1, r5
c0d02e82:	4632      	mov	r2, r6
c0d02e84:	f004 fb94 	bl	c0d075b0 <strlcat>
        strlcat(_tmpBuffer, " ", sizeof(_tmpBuffer));
c0d02e88:	492e      	ldr	r1, [pc, #184]	; (c0d02f44 <_toStringCompactInt+0x1dc>)
c0d02e8a:	4479      	add	r1, pc
c0d02e8c:	4638      	mov	r0, r7
c0d02e8e:	4632      	mov	r2, r6
c0d02e90:	f004 fb8e 	bl	c0d075b0 <strlcat>
        strlcat(_tmpBuffer, bufferUI, sizeof(_tmpBuffer));
c0d02e94:	4638      	mov	r0, r7
c0d02e96:	4621      	mov	r1, r4
c0d02e98:	4632      	mov	r2, r6
c0d02e9a:	f004 fb89 	bl	c0d075b0 <strlcat>
        // print length: strlen(value) + strlen(prefix) + strlen(" ") + strlen("\0")
        MEMZERO(bufferUI, sizeof(bufferUI));
c0d02e9e:	4620      	mov	r0, r4
c0d02ea0:	4631      	mov	r1, r6
c0d02ea2:	9e06      	ldr	r6, [sp, #24]
c0d02ea4:	f004 fa46 	bl	c0d07334 <explicit_bzero>
        size_t size = strlen(bufferUI) + strlen(prefix) + 2;
c0d02ea8:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d02eaa:	9908      	ldr	r1, [sp, #32]
c0d02eac:	1840      	adds	r0, r0, r1
c0d02eae:	1c81      	adds	r1, r0, #2
        snprintf(bufferUI, size, "%s", _tmpBuffer);
c0d02eb0:	4a25      	ldr	r2, [pc, #148]	; (c0d02f48 <_toStringCompactInt+0x1e0>)
c0d02eb2:	447a      	add	r2, pc
c0d02eb4:	4620      	mov	r0, r4
c0d02eb6:	463b      	mov	r3, r7
c0d02eb8:	9f02      	ldr	r7, [sp, #8]
c0d02eba:	f7ff f959 	bl	c0d02170 <snprintf>
    }

    // Add postfix
    if (postfix > 32 && postfix < 127) {
c0d02ebe:	4638      	mov	r0, r7
c0d02ec0:	3821      	subs	r0, #33	; 0x21
c0d02ec2:	285d      	cmp	r0, #93	; 0x5d
c0d02ec4:	d805      	bhi.n	c0d02ed2 <_toStringCompactInt+0x16a>
c0d02ec6:	ac3d      	add	r4, sp, #244	; 0xf4
        const uint16_t p = strlen(bufferUI);
c0d02ec8:	4620      	mov	r0, r4
c0d02eca:	f004 fbc3 	bl	c0d07654 <strlen>
        bufferUI[p] = postfix;
c0d02ece:	b280      	uxth	r0, r0
c0d02ed0:	5427      	strb	r7, [r4, r0]
c0d02ed2:	a83d      	add	r0, sp, #244	; 0xf4
    pageStringExt(outValue, outValueLen, inValue, (uint16_t) strlen(inValue), pageIdx, pageCount);
c0d02ed4:	f004 fbbe 	bl	c0d07654 <strlen>
c0d02ed8:	4607      	mov	r7, r0
    MEMZERO(outValue, outValueLen);
c0d02eda:	4630      	mov	r0, r6
c0d02edc:	9c03      	ldr	r4, [sp, #12]
c0d02ede:	4621      	mov	r1, r4
c0d02ee0:	f004 fa28 	bl	c0d07334 <explicit_bzero>
c0d02ee4:	2600      	movs	r6, #0
    *pageCount = 0;
c0d02ee6:	9804      	ldr	r0, [sp, #16]
c0d02ee8:	7006      	strb	r6, [r0, #0]
    outValueLen--;  // leave space for NULL termination
c0d02eea:	1e65      	subs	r5, r4, #1
c0d02eec:	b2ac      	uxth	r4, r5
    if (outValueLen == 0) {
c0d02eee:	2c00      	cmp	r4, #0
c0d02ef0:	d025      	beq.n	c0d02f3e <_toStringCompactInt+0x1d6>
c0d02ef2:	0438      	lsls	r0, r7, #16
c0d02ef4:	d023      	beq.n	c0d02f3e <_toStringCompactInt+0x1d6>
c0d02ef6:	9876      	ldr	r0, [sp, #472]	; 0x1d8
    *pageCount = (uint8_t) (inValueLen / outValueLen);
c0d02ef8:	9009      	str	r0, [sp, #36]	; 0x24
c0d02efa:	b2b8      	uxth	r0, r7
c0d02efc:	4621      	mov	r1, r4
c0d02efe:	f004 f871 	bl	c0d06fe4 <__udivsi3>
c0d02f02:	4345      	muls	r5, r0
c0d02f04:	1b7b      	subs	r3, r7, r5
c0d02f06:	9f09      	ldr	r7, [sp, #36]	; 0x24
c0d02f08:	b29a      	uxth	r2, r3
    if (lastChunkLen > 0) {
c0d02f0a:	1e51      	subs	r1, r2, #1
c0d02f0c:	4615      	mov	r5, r2
c0d02f0e:	418d      	sbcs	r5, r1
c0d02f10:	1828      	adds	r0, r5, r0
c0d02f12:	9904      	ldr	r1, [sp, #16]
c0d02f14:	7008      	strb	r0, [r1, #0]
c0d02f16:	b2c0      	uxtb	r0, r0
    if (pageIdx < *pageCount) {
c0d02f18:	42b8      	cmp	r0, r7
c0d02f1a:	d910      	bls.n	c0d02f3e <_toStringCompactInt+0x1d6>
c0d02f1c:	4621      	mov	r1, r4
c0d02f1e:	4379      	muls	r1, r7
c0d02f20:	ad3d      	add	r5, sp, #244	; 0xf4
c0d02f22:	1869      	adds	r1, r5, r1
        if (lastChunkLen > 0 && pageIdx == *pageCount - 1) {
c0d02f24:	041b      	lsls	r3, r3, #16
c0d02f26:	d006      	beq.n	c0d02f36 <_toStringCompactInt+0x1ce>
c0d02f28:	1e40      	subs	r0, r0, #1
c0d02f2a:	42b8      	cmp	r0, r7
c0d02f2c:	d103      	bne.n	c0d02f36 <_toStringCompactInt+0x1ce>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), lastChunkLen);
c0d02f2e:	9806      	ldr	r0, [sp, #24]
c0d02f30:	e003      	b.n	c0d02f3a <_toStringCompactInt+0x1d2>
c0d02f32:	260c      	movs	r6, #12
c0d02f34:	e003      	b.n	c0d02f3e <_toStringCompactInt+0x1d6>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), outValueLen);
c0d02f36:	9806      	ldr	r0, [sp, #24]
c0d02f38:	4622      	mov	r2, r4
c0d02f3a:	f004 f9eb 	bl	c0d07314 <__aeabi_memcpy>
    }

    pageString(outValue, outValueLen, bufferUI, pageIdx, pageCount);

    return parser_ok;
}
c0d02f3e:	4630      	mov	r0, r6
c0d02f40:	b06f      	add	sp, #444	; 0x1bc
c0d02f42:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02f44:	000054e0 	.word	0x000054e0
c0d02f48:	000049d8 	.word	0x000049d8

c0d02f4c <_readCallIndex>:
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

parser_error_t _readCallIndex(parser_context_t *c, pd_CallIndex_t *v) {
c0d02f4c:	b5b0      	push	{r4, r5, r7, lr}
    CHECK_INPUT();
c0d02f4e:	2900      	cmp	r1, #0
c0d02f50:	d020      	beq.n	c0d02f94 <_readCallIndex+0x48>
c0d02f52:	4602      	mov	r2, r0
c0d02f54:	200b      	movs	r0, #11
c0d02f56:	2a00      	cmp	r2, #0
c0d02f58:	d01b      	beq.n	c0d02f92 <_readCallIndex+0x46>
c0d02f5a:	8893      	ldrh	r3, [r2, #4]
c0d02f5c:	88d4      	ldrh	r4, [r2, #6]
c0d02f5e:	429c      	cmp	r4, r3
c0d02f60:	d217      	bcs.n	c0d02f92 <_readCallIndex+0x46>
c0d02f62:	2300      	movs	r3, #0
GEN_DEF_READFIX_UNSIGNED(8)
c0d02f64:	700b      	strb	r3, [r1, #0]
c0d02f66:	88d4      	ldrh	r4, [r2, #6]
c0d02f68:	8895      	ldrh	r5, [r2, #4]
c0d02f6a:	42ac      	cmp	r4, r5
c0d02f6c:	d211      	bcs.n	c0d02f92 <_readCallIndex+0x46>
c0d02f6e:	6815      	ldr	r5, [r2, #0]
c0d02f70:	5d2c      	ldrb	r4, [r5, r4]
c0d02f72:	700c      	strb	r4, [r1, #0]
c0d02f74:	88d4      	ldrh	r4, [r2, #6]
c0d02f76:	1c64      	adds	r4, r4, #1
c0d02f78:	80d4      	strh	r4, [r2, #6]
c0d02f7a:	704b      	strb	r3, [r1, #1]
c0d02f7c:	88d4      	ldrh	r4, [r2, #6]
c0d02f7e:	8895      	ldrh	r5, [r2, #4]
c0d02f80:	42ac      	cmp	r4, r5
c0d02f82:	d206      	bcs.n	c0d02f92 <_readCallIndex+0x46>
c0d02f84:	6810      	ldr	r0, [r2, #0]
c0d02f86:	5d00      	ldrb	r0, [r0, r4]
c0d02f88:	7048      	strb	r0, [r1, #1]
c0d02f8a:	88d0      	ldrh	r0, [r2, #6]
c0d02f8c:	1c40      	adds	r0, r0, #1
c0d02f8e:	80d0      	strh	r0, [r2, #6]
c0d02f90:	4618      	mov	r0, r3
c0d02f92:	bdb0      	pop	{r4, r5, r7, pc}
c0d02f94:	2001      	movs	r0, #1
c0d02f96:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f98 <_readEra>:
    CHECK_ERROR(_readUInt8(c, &v->moduleIdx));
    CHECK_ERROR(_readUInt8(c, &v->idx));
    return parser_ok;
}

parser_error_t _readEra(parser_context_t *c, pd_ExtrinsicEra_t *v) {
c0d02f98:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02f9a:	b083      	sub	sp, #12
    CHECK_INPUT();
c0d02f9c:	2900      	cmp	r1, #0
c0d02f9e:	d03e      	beq.n	c0d0301e <_readEra+0x86>
c0d02fa0:	230b      	movs	r3, #11
c0d02fa2:	2800      	cmp	r0, #0
c0d02fa4:	d039      	beq.n	c0d0301a <_readEra+0x82>
c0d02fa6:	8887      	ldrh	r7, [r0, #4]
c0d02fa8:	88c6      	ldrh	r6, [r0, #6]
c0d02faa:	42be      	cmp	r6, r7
c0d02fac:	d235      	bcs.n	c0d0301a <_readEra+0x82>
c0d02fae:	460d      	mov	r5, r1
c0d02fb0:	2400      	movs	r4, #0
    //  https://github.com/paritytech/substrate/blob/fc3adc87dc806237eb7371c1d21055eea1702be0/core/sr-primitives/src/generic/era.rs#L117

    v->type = eEraImmortal;
c0d02fb2:	700c      	strb	r4, [r1, #0]
GEN_DEF_READFIX_UNSIGNED(8)
c0d02fb4:	6801      	ldr	r1, [r0, #0]
c0d02fb6:	9100      	str	r1, [sp, #0]
c0d02fb8:	5d89      	ldrb	r1, [r1, r6]
c0d02fba:	1c72      	adds	r2, r6, #1
c0d02fbc:	9202      	str	r2, [sp, #8]
c0d02fbe:	80c2      	strh	r2, [r0, #6]
c0d02fc0:	9101      	str	r1, [sp, #4]

    uint8_t first;
    CHECK_ERROR(_readUInt8(c, &first));
    if (first == 0) { return parser_ok; }
c0d02fc2:	2900      	cmp	r1, #0
c0d02fc4:	d02c      	beq.n	c0d03020 <_readEra+0x88>
c0d02fc6:	2101      	movs	r1, #1

    v->type = eEraMortal;
c0d02fc8:	7029      	strb	r1, [r5, #0]
GEN_DEF_READFIX_UNSIGNED(8)
c0d02fca:	9a02      	ldr	r2, [sp, #8]
c0d02fcc:	42ba      	cmp	r2, r7
c0d02fce:	461c      	mov	r4, r3
c0d02fd0:	d226      	bcs.n	c0d03020 <_readEra+0x88>
c0d02fd2:	460f      	mov	r7, r1
c0d02fd4:	9900      	ldr	r1, [sp, #0]
c0d02fd6:	9a02      	ldr	r2, [sp, #8]
c0d02fd8:	5c8b      	ldrb	r3, [r1, r2]
c0d02fda:	2400      	movs	r4, #0
    uint64_t encoded = first;
    CHECK_ERROR(_readUInt8(c, &first));
    encoded += (uint64_t) first << 8u;

    v->period = 2U << (encoded % (1u << 4u));
c0d02fdc:	60ec      	str	r4, [r5, #12]
GEN_DEF_READFIX_UNSIGNED(8)
c0d02fde:	1cb1      	adds	r1, r6, #2
c0d02fe0:	80c1      	strh	r1, [r0, #6]
c0d02fe2:	200f      	movs	r0, #15
c0d02fe4:	9901      	ldr	r1, [sp, #4]
    v->period = 2U << (encoded % (1u << 4u));
c0d02fe6:	4008      	ands	r0, r1
c0d02fe8:	2602      	movs	r6, #2
c0d02fea:	4086      	lsls	r6, r0
c0d02fec:	60ae      	str	r6, [r5, #8]
    uint64_t quantize_factor = (v->period >> 12u);
c0d02fee:	0b30      	lsrs	r0, r6, #12
    quantize_factor = (quantize_factor == 0 ? 1 : quantize_factor);
c0d02ff0:	d000      	beq.n	c0d02ff4 <_readEra+0x5c>
c0d02ff2:	4607      	mov	r7, r0
    encoded += (uint64_t) first << 8u;
c0d02ff4:	0218      	lsls	r0, r3, #8
c0d02ff6:	1840      	adds	r0, r0, r1

    v->phase = (encoded >> 4u) * quantize_factor;
c0d02ff8:	0900      	lsrs	r0, r0, #4
c0d02ffa:	4621      	mov	r1, r4
c0d02ffc:	463a      	mov	r2, r7
c0d02ffe:	4623      	mov	r3, r4
c0d03000:	f004 f8b8 	bl	c0d07174 <__aeabi_lmul>
c0d03004:	6128      	str	r0, [r5, #16]
c0d03006:	6169      	str	r1, [r5, #20]
c0d03008:	220c      	movs	r2, #12

    if (v->period >= 4 && v->phase < v->period) {
c0d0300a:	1b80      	subs	r0, r0, r6
c0d0300c:	41a1      	sbcs	r1, r4
c0d0300e:	d300      	bcc.n	c0d03012 <_readEra+0x7a>
c0d03010:	4614      	mov	r4, r2
c0d03012:	2e03      	cmp	r6, #3
c0d03014:	d804      	bhi.n	c0d03020 <_readEra+0x88>
c0d03016:	4614      	mov	r4, r2
c0d03018:	e002      	b.n	c0d03020 <_readEra+0x88>
c0d0301a:	461c      	mov	r4, r3
c0d0301c:	e000      	b.n	c0d03020 <_readEra+0x88>
c0d0301e:	2401      	movs	r4, #1
        return parser_ok;
    }

    return parser_unexpected_value;
}
c0d03020:	4620      	mov	r0, r4
c0d03022:	b003      	add	sp, #12
c0d03024:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03026 <_readCompactBalance>:
    CHECK_INPUT();
    CHECK_ERROR(_readCompactInt(c, &v->index));
    return parser_ok;
}

parser_error_t _readCompactBalance(parser_context_t *c, pd_CompactBalance_t *v) {
c0d03026:	b510      	push	{r4, lr}
    CHECK_INPUT();
c0d03028:	2900      	cmp	r1, #0
c0d0302a:	d00b      	beq.n	c0d03044 <_readCompactBalance+0x1e>
c0d0302c:	4602      	mov	r2, r0
c0d0302e:	200b      	movs	r0, #11
c0d03030:	2a00      	cmp	r2, #0
c0d03032:	d006      	beq.n	c0d03042 <_readCompactBalance+0x1c>
c0d03034:	8893      	ldrh	r3, [r2, #4]
c0d03036:	88d4      	ldrh	r4, [r2, #6]
c0d03038:	429c      	cmp	r4, r3
c0d0303a:	d202      	bcs.n	c0d03042 <_readCompactBalance+0x1c>
    CHECK_ERROR(_readCompactInt(c, &v->value));
c0d0303c:	4610      	mov	r0, r2
c0d0303e:	f7ff fe1a 	bl	c0d02c76 <_readCompactInt>
c0d03042:	bd10      	pop	{r4, pc}
c0d03044:	2001      	movs	r0, #1
c0d03046:	bd10      	pop	{r4, pc}

c0d03048 <_toStringCompactIndex>:
    return parser_ok;
}

parser_error_t _toStringCompactIndex(const pd_CompactIndex_t *v,
                                     char *outValue, uint16_t outValueLen,
                                     uint8_t pageIdx, uint8_t *pageCount) {
c0d03048:	b510      	push	{r4, lr}
c0d0304a:	b084      	sub	sp, #16
c0d0304c:	9c06      	ldr	r4, [sp, #24]
    return _toStringCompactInt(&v->index, 0, 0, "", outValue, outValueLen, pageIdx, pageCount);
c0d0304e:	9100      	str	r1, [sp, #0]
c0d03050:	9201      	str	r2, [sp, #4]
c0d03052:	9302      	str	r3, [sp, #8]
c0d03054:	9403      	str	r4, [sp, #12]
c0d03056:	2100      	movs	r1, #0
c0d03058:	4b03      	ldr	r3, [pc, #12]	; (c0d03068 <_toStringCompactIndex+0x20>)
c0d0305a:	447b      	add	r3, pc
c0d0305c:	460a      	mov	r2, r1
c0d0305e:	f7ff fe83 	bl	c0d02d68 <_toStringCompactInt>
c0d03062:	b004      	add	sp, #16
c0d03064:	bd10      	pop	{r4, pc}
c0d03066:	46c0      	nop			; (mov r8, r8)
c0d03068:	00005363 	.word	0x00005363

c0d0306c <_toStringCompactBalance>:
}

parser_error_t _toStringCompactBalance(const pd_CompactBalance_t *v,
                                       char *outValue, uint16_t outValueLen,
                                       uint8_t pageIdx, uint8_t *pageCount) {
c0d0306c:	b5b0      	push	{r4, r5, r7, lr}
c0d0306e:	b084      	sub	sp, #16
c0d03070:	460c      	mov	r4, r1
c0d03072:	9908      	ldr	r1, [sp, #32]
    CHECK_ERROR(_toStringCompactInt(&v->value, COIN_AMOUNT_DECIMAL_PLACES, 0, COIN_TICKER, outValue, outValueLen, pageIdx, pageCount))
c0d03074:	9400      	str	r4, [sp, #0]
c0d03076:	9201      	str	r2, [sp, #4]
c0d03078:	9302      	str	r3, [sp, #8]
c0d0307a:	9103      	str	r1, [sp, #12]
c0d0307c:	2106      	movs	r1, #6
c0d0307e:	2500      	movs	r5, #0
c0d03080:	4b1b      	ldr	r3, [pc, #108]	; (c0d030f0 <_toStringCompactBalance+0x84>)
c0d03082:	447b      	add	r3, pc
c0d03084:	462a      	mov	r2, r5
c0d03086:	f7ff fe6f 	bl	c0d02d68 <_toStringCompactInt>
c0d0308a:	4601      	mov	r1, r0
c0d0308c:	2800      	cmp	r0, #0
c0d0308e:	d127      	bne.n	c0d030e0 <_toStringCompactBalance+0x74>
    const size_t len = strlen(s);
c0d03090:	4620      	mov	r0, r4
c0d03092:	f004 fadf 	bl	c0d07654 <strlen>
    if (len == 0 || len == 1 || len > 1024) {
c0d03096:	1e81      	subs	r1, r0, #2
c0d03098:	4a13      	ldr	r2, [pc, #76]	; (c0d030e8 <_toStringCompactBalance+0x7c>)
c0d0309a:	4291      	cmp	r1, r2
c0d0309c:	4629      	mov	r1, r5
c0d0309e:	d81f      	bhi.n	c0d030e0 <_toStringCompactBalance+0x74>
c0d030a0:	4912      	ldr	r1, [pc, #72]	; (c0d030ec <_toStringCompactBalance+0x80>)
c0d030a2:	2300      	movs	r3, #0
c0d030a4:	461a      	mov	r2, r3
        if (s[i] == '.') {
c0d030a6:	5ce3      	ldrb	r3, [r4, r3]
c0d030a8:	2b2e      	cmp	r3, #46	; 0x2e
c0d030aa:	4613      	mov	r3, r2
c0d030ac:	d000      	beq.n	c0d030b0 <_toStringCompactBalance+0x44>
c0d030ae:	460b      	mov	r3, r1
c0d030b0:	b219      	sxth	r1, r3
    for (int16_t i = 0; i < (int16_t) len && dec_point < 0; i++) {
c0d030b2:	1c52      	adds	r2, r2, #1
c0d030b4:	b213      	sxth	r3, r2
c0d030b6:	4298      	cmp	r0, r3
c0d030b8:	dd01      	ble.n	c0d030be <_toStringCompactBalance+0x52>
c0d030ba:	2900      	cmp	r1, #0
c0d030bc:	d4f3      	bmi.n	c0d030a6 <_toStringCompactBalance+0x3a>
c0d030be:	2200      	movs	r2, #0
    if (dec_point < 0) {
c0d030c0:	2900      	cmp	r1, #0
c0d030c2:	d40c      	bmi.n	c0d030de <_toStringCompactBalance+0x72>
c0d030c4:	1e40      	subs	r0, r0, #1
c0d030c6:	1c4b      	adds	r3, r1, #1
c0d030c8:	4298      	cmp	r0, r3
c0d030ca:	d908      	bls.n	c0d030de <_toStringCompactBalance+0x72>
    for (size_t i = (len - 1); i > limit && s[i] == '0'; i--) {
c0d030cc:	5c21      	ldrb	r1, [r4, r0]
c0d030ce:	2930      	cmp	r1, #48	; 0x30
c0d030d0:	d105      	bne.n	c0d030de <_toStringCompactBalance+0x72>
c0d030d2:	2100      	movs	r1, #0
        s[i] = 0;
c0d030d4:	5421      	strb	r1, [r4, r0]
c0d030d6:	1e40      	subs	r0, r0, #1
    for (size_t i = (len - 1); i > limit && s[i] == '0'; i--) {
c0d030d8:	4298      	cmp	r0, r3
c0d030da:	d8f7      	bhi.n	c0d030cc <_toStringCompactBalance+0x60>
c0d030dc:	e000      	b.n	c0d030e0 <_toStringCompactBalance+0x74>
c0d030de:	4611      	mov	r1, r2
    number_inplace_trimming(outValue, 1);
    return parser_ok;
}
c0d030e0:	4608      	mov	r0, r1
c0d030e2:	b004      	add	sp, #16
c0d030e4:	bdb0      	pop	{r4, r5, r7, pc}
c0d030e6:	46c0      	nop			; (mov r8, r8)
c0d030e8:	000003fe 	.word	0x000003fe
c0d030ec:	0000ffff 	.word	0x0000ffff
c0d030f0:	00004a09 	.word	0x00004a09

c0d030f4 <_checkVersions>:
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

parser_error_t _checkVersions(parser_context_t *c) {
c0d030f4:	b510      	push	{r4, lr}
    // [4 bytes] specVersion
    // [4 bytes] transactionVersion
    // [32 bytes] genesisHash
    // [32 bytes] blockHash
    const uint16_t specOffsetFromBack = 4 + 4 + 32 + 32;
    if (c->bufferLen < specOffsetFromBack) {
c0d030f6:	8881      	ldrh	r1, [r0, #4]
c0d030f8:	2948      	cmp	r1, #72	; 0x48
c0d030fa:	d201      	bcs.n	c0d03100 <_checkVersions+0xc>
c0d030fc:	200b      	movs	r0, #11

    c->tx_obj->specVersion = specVersion;
    c->tx_obj->transactionVersion = transactionVersion;

    return parser_ok;
}
c0d030fe:	bd10      	pop	{r4, pc}
    uint8_t *p = (uint8_t *) (c->buffer + c->bufferLen - specOffsetFromBack);
c0d03100:	6802      	ldr	r2, [r0, #0]
c0d03102:	1851      	adds	r1, r2, r1
c0d03104:	3948      	subs	r1, #72	; 0x48
    transactionVersion += (uint32_t) p[0] << 0u;
c0d03106:	790a      	ldrb	r2, [r1, #4]
    transactionVersion += (uint32_t) p[1] << 8u;
c0d03108:	794b      	ldrb	r3, [r1, #5]
c0d0310a:	021b      	lsls	r3, r3, #8
c0d0310c:	189a      	adds	r2, r3, r2
    transactionVersion += (uint32_t) p[2] << 16u;
c0d0310e:	798b      	ldrb	r3, [r1, #6]
c0d03110:	041b      	lsls	r3, r3, #16
c0d03112:	18d2      	adds	r2, r2, r3
    transactionVersion += (uint32_t) p[3] << 24u;
c0d03114:	79cb      	ldrb	r3, [r1, #7]
c0d03116:	061b      	lsls	r3, r3, #24
c0d03118:	18d2      	adds	r2, r2, r3
    if (transactionVersion != (SUPPORTED_TX_VERSION_CURRENT) &&
c0d0311a:	1e53      	subs	r3, r2, #1
c0d0311c:	2b01      	cmp	r3, #1
c0d0311e:	d901      	bls.n	c0d03124 <_checkVersions+0x30>
c0d03120:	2008      	movs	r0, #8
}
c0d03122:	bd10      	pop	{r4, pc}
c0d03124:	780b      	ldrb	r3, [r1, #0]
c0d03126:	784c      	ldrb	r4, [r1, #1]
c0d03128:	0224      	lsls	r4, r4, #8
c0d0312a:	18e3      	adds	r3, r4, r3
c0d0312c:	788c      	ldrb	r4, [r1, #2]
c0d0312e:	0424      	lsls	r4, r4, #16
c0d03130:	191b      	adds	r3, r3, r4
c0d03132:	78c9      	ldrb	r1, [r1, #3]
c0d03134:	0609      	lsls	r1, r1, #24
c0d03136:	1859      	adds	r1, r3, r1
    if (specVersion < SUPPORTED_MINIMUM_SPEC_VERSION) {
c0d03138:	2924      	cmp	r1, #36	; 0x24
c0d0313a:	d201      	bcs.n	c0d03140 <_checkVersions+0x4c>
c0d0313c:	2007      	movs	r0, #7
}
c0d0313e:	bd10      	pop	{r4, pc}
    c->tx_obj->specVersion = specVersion;
c0d03140:	6880      	ldr	r0, [r0, #8]
c0d03142:	6581      	str	r1, [r0, #88]	; 0x58
    c->tx_obj->transactionVersion = transactionVersion;
c0d03144:	65c2      	str	r2, [r0, #92]	; 0x5c
c0d03146:	2000      	movs	r0, #0
}
c0d03148:	bd10      	pop	{r4, pc}
	...

c0d0314c <_getAddressType>:

uint8_t __address_type;

uint8_t _getAddressType() {
    return __address_type;
c0d0314c:	4801      	ldr	r0, [pc, #4]	; (c0d03154 <_getAddressType+0x8>)
c0d0314e:	7800      	ldrb	r0, [r0, #0]
c0d03150:	4770      	bx	lr
c0d03152:	46c0      	nop			; (mov r8, r8)
c0d03154:	20000434 	.word	0x20000434

c0d03158 <_detectAddressType>:
}

uint8_t _detectAddressType(const parser_context_t *c) {
c0d03158:	b5b0      	push	{r4, r5, r7, lr}
c0d0315a:	b094      	sub	sp, #80	; 0x50
    char hashstr[65];
    uint8_t pc;

    if (c->tx_obj->genesisHash._ptr != NULL) {
c0d0315c:	6880      	ldr	r0, [r0, #8]
c0d0315e:	6e01      	ldr	r1, [r0, #96]	; 0x60
c0d03160:	2900      	cmp	r1, #0
c0d03162:	d011      	beq.n	c0d03188 <_detectAddressType+0x30>
c0d03164:	3060      	adds	r0, #96	; 0x60
c0d03166:	a902      	add	r1, sp, #8
        _toStringHash(&c->tx_obj->genesisHash, hashstr, 65, 0, &pc);
c0d03168:	9100      	str	r1, [sp, #0]
c0d0316a:	ac03      	add	r4, sp, #12
c0d0316c:	2541      	movs	r5, #65	; 0x41
c0d0316e:	2300      	movs	r3, #0
c0d03170:	4621      	mov	r1, r4
c0d03172:	462a      	mov	r2, r5
c0d03174:	f001 fa36 	bl	c0d045e4 <_toStringHash>

        // Compare with known genesis hashes
        if (strcmp(hashstr, COIN_GENESIS_HASH) == 0) {
c0d03178:	4906      	ldr	r1, [pc, #24]	; (c0d03194 <_detectAddressType+0x3c>)
c0d0317a:	4479      	add	r1, pc
c0d0317c:	4620      	mov	r0, r4
c0d0317e:	462a      	mov	r2, r5
c0d03180:	f004 f8dc 	bl	c0d0733c <memcmp>
c0d03184:	2800      	cmp	r0, #0
c0d03186:	d001      	beq.n	c0d0318c <_detectAddressType+0x34>
c0d03188:	202a      	movs	r0, #42	; 0x2a
c0d0318a:	e000      	b.n	c0d0318e <_detectAddressType+0x36>
c0d0318c:	2016      	movs	r0, #22
            return PK_ADDRESS_TYPE;
        }
    }

    return 42;
}
c0d0318e:	b014      	add	sp, #80	; 0x50
c0d03190:	bdb0      	pop	{r4, r5, r7, pc}
c0d03192:	46c0      	nop			; (mov r8, r8)
c0d03194:	00004916 	.word	0x00004916

c0d03198 <_readTx>:

parser_error_t _readTx(parser_context_t *c, parser_tx_t *v) {
c0d03198:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0319a:	b083      	sub	sp, #12
    CHECK_INPUT();
c0d0319c:	2900      	cmp	r1, #0
c0d0319e:	d100      	bne.n	c0d031a2 <_readTx+0xa>
c0d031a0:	e089      	b.n	c0d032b6 <_readTx+0x11e>
c0d031a2:	4604      	mov	r4, r0
c0d031a4:	260b      	movs	r6, #11
c0d031a6:	2800      	cmp	r0, #0
c0d031a8:	d100      	bne.n	c0d031ac <_readTx+0x14>
c0d031aa:	e082      	b.n	c0d032b2 <_readTx+0x11a>
c0d031ac:	460d      	mov	r5, r1
c0d031ae:	88a0      	ldrh	r0, [r4, #4]
c0d031b0:	88e1      	ldrh	r1, [r4, #6]
c0d031b2:	4281      	cmp	r1, r0
c0d031b4:	d27d      	bcs.n	c0d032b2 <_readTx+0x11a>

    // Reverse parse to retrieve spec before forward parsing
    CHECK_ERROR(_checkVersions(c));
c0d031b6:	4620      	mov	r0, r4
c0d031b8:	f7ff ff9c 	bl	c0d030f4 <_checkVersions>
c0d031bc:	2800      	cmp	r0, #0
c0d031be:	d17b      	bne.n	c0d032b8 <_readTx+0x120>

    // Now forward parse
    CHECK_ERROR(_readCallIndex(c, &v->callIndex));
c0d031c0:	4620      	mov	r0, r4
c0d031c2:	4629      	mov	r1, r5
c0d031c4:	f7ff fec2 	bl	c0d02f4c <_readCallIndex>
c0d031c8:	2800      	cmp	r0, #0
c0d031ca:	d175      	bne.n	c0d032b8 <_readTx+0x120>
    CHECK_ERROR(_readMethod(c, v->callIndex.moduleIdx, v->callIndex.idx, &v->method));
c0d031cc:	786a      	ldrb	r2, [r5, #1]
c0d031ce:	7829      	ldrb	r1, [r5, #0]
c0d031d0:	462b      	mov	r3, r5
c0d031d2:	3308      	adds	r3, #8
c0d031d4:	4620      	mov	r0, r4
c0d031d6:	f000 f95b 	bl	c0d03490 <_readMethod>
c0d031da:	2800      	cmp	r0, #0
c0d031dc:	d16c      	bne.n	c0d032b8 <_readTx+0x120>
    CHECK_ERROR(_readEra(c, &v->era));
c0d031de:	4629      	mov	r1, r5
c0d031e0:	3130      	adds	r1, #48	; 0x30
c0d031e2:	4620      	mov	r0, r4
c0d031e4:	f7ff fed8 	bl	c0d02f98 <_readEra>
c0d031e8:	2800      	cmp	r0, #0
c0d031ea:	d165      	bne.n	c0d032b8 <_readTx+0x120>
    CHECK_INPUT();
c0d031ec:	88a0      	ldrh	r0, [r4, #4]
c0d031ee:	88e1      	ldrh	r1, [r4, #6]
c0d031f0:	4281      	cmp	r1, r0
c0d031f2:	d25e      	bcs.n	c0d032b2 <_readTx+0x11a>
    CHECK_ERROR(_readCompactInt(c, &v->index));
c0d031f4:	4629      	mov	r1, r5
c0d031f6:	3148      	adds	r1, #72	; 0x48
c0d031f8:	4620      	mov	r0, r4
c0d031fa:	f7ff fd3c 	bl	c0d02c76 <_readCompactInt>
c0d031fe:	2800      	cmp	r0, #0
c0d03200:	d15a      	bne.n	c0d032b8 <_readTx+0x120>
    CHECK_INPUT();
c0d03202:	88a0      	ldrh	r0, [r4, #4]
c0d03204:	88e1      	ldrh	r1, [r4, #6]
c0d03206:	4281      	cmp	r1, r0
c0d03208:	d253      	bcs.n	c0d032b2 <_readTx+0x11a>
    CHECK_ERROR(_readCompactInt(c, &v->value));
c0d0320a:	4629      	mov	r1, r5
c0d0320c:	3150      	adds	r1, #80	; 0x50
c0d0320e:	4620      	mov	r0, r4
c0d03210:	f7ff fd31 	bl	c0d02c76 <_readCompactInt>
c0d03214:	2800      	cmp	r0, #0
c0d03216:	d14f      	bne.n	c0d032b8 <_readTx+0x120>
c0d03218:	2700      	movs	r7, #0
GEN_DEF_READFIX_UNSIGNED(32)
c0d0321a:	65af      	str	r7, [r5, #88]	; 0x58
c0d0321c:	88a0      	ldrh	r0, [r4, #4]
c0d0321e:	88e1      	ldrh	r1, [r4, #6]
c0d03220:	4288      	cmp	r0, r1
c0d03222:	9000      	str	r0, [sp, #0]
c0d03224:	d800      	bhi.n	c0d03228 <_readTx+0x90>
c0d03226:	4608      	mov	r0, r1
c0d03228:	1a40      	subs	r0, r0, r1
c0d0322a:	b280      	uxth	r0, r0
c0d0322c:	00c0      	lsls	r0, r0, #3
c0d0322e:	9001      	str	r0, [sp, #4]
c0d03230:	1c4a      	adds	r2, r1, #1
c0d03232:	463b      	mov	r3, r7
c0d03234:	9202      	str	r2, [sp, #8]
c0d03236:	9801      	ldr	r0, [sp, #4]
c0d03238:	42b8      	cmp	r0, r7
c0d0323a:	d03a      	beq.n	c0d032b2 <_readTx+0x11a>
c0d0323c:	6820      	ldr	r0, [r4, #0]
c0d0323e:	5c42      	ldrb	r2, [r0, r1]
c0d03240:	1c49      	adds	r1, r1, #1
c0d03242:	80e1      	strh	r1, [r4, #6]
c0d03244:	40ba      	lsls	r2, r7
c0d03246:	18d3      	adds	r3, r2, r3
c0d03248:	65ab      	str	r3, [r5, #88]	; 0x58
c0d0324a:	3708      	adds	r7, #8
c0d0324c:	9a02      	ldr	r2, [sp, #8]
c0d0324e:	1c52      	adds	r2, r2, #1
c0d03250:	2f20      	cmp	r7, #32
c0d03252:	d1ef      	bne.n	c0d03234 <_readTx+0x9c>
c0d03254:	9001      	str	r0, [sp, #4]
c0d03256:	2300      	movs	r3, #0
c0d03258:	65eb      	str	r3, [r5, #92]	; 0x5c
c0d0325a:	9802      	ldr	r0, [sp, #8]
c0d0325c:	b282      	uxth	r2, r0
c0d0325e:	9800      	ldr	r0, [sp, #0]
c0d03260:	4290      	cmp	r0, r2
c0d03262:	4602      	mov	r2, r0
c0d03264:	d300      	bcc.n	c0d03268 <_readTx+0xd0>
c0d03266:	9a02      	ldr	r2, [sp, #8]
c0d03268:	1a80      	subs	r0, r0, r2
c0d0326a:	b280      	uxth	r0, r0
c0d0326c:	00c2      	lsls	r2, r0, #3
c0d0326e:	b289      	uxth	r1, r1
c0d03270:	461f      	mov	r7, r3
c0d03272:	429a      	cmp	r2, r3
c0d03274:	9801      	ldr	r0, [sp, #4]
c0d03276:	d01c      	beq.n	c0d032b2 <_readTx+0x11a>
c0d03278:	5c40      	ldrb	r0, [r0, r1]
c0d0327a:	1c49      	adds	r1, r1, #1
c0d0327c:	80e1      	strh	r1, [r4, #6]
c0d0327e:	4098      	lsls	r0, r3
c0d03280:	19c7      	adds	r7, r0, r7
c0d03282:	65ef      	str	r7, [r5, #92]	; 0x5c
c0d03284:	3308      	adds	r3, #8
c0d03286:	2b20      	cmp	r3, #32
c0d03288:	d1f3      	bne.n	c0d03272 <_readTx+0xda>
    CHECK_ERROR(_readCompactIndex(c, &v->nonce));
    CHECK_ERROR(_readCompactBalance(c, &v->tip));
    CHECK_ERROR(_readUInt32(c, &v->specVersion));
    CHECK_ERROR(_readUInt32(c, &v->transactionVersion));
    CHECK_ERROR(_readHash(c, &v->genesisHash));
c0d0328a:	4629      	mov	r1, r5
c0d0328c:	3160      	adds	r1, #96	; 0x60
c0d0328e:	4620      	mov	r0, r4
c0d03290:	f000 fedb 	bl	c0d0404a <_readHash>
c0d03294:	2800      	cmp	r0, #0
c0d03296:	d10f      	bne.n	c0d032b8 <_readTx+0x120>
    CHECK_ERROR(_readHash(c, &v->blockHash));
c0d03298:	3564      	adds	r5, #100	; 0x64
c0d0329a:	4620      	mov	r0, r4
c0d0329c:	4629      	mov	r1, r5
c0d0329e:	f000 fed4 	bl	c0d0404a <_readHash>
c0d032a2:	2800      	cmp	r0, #0
c0d032a4:	d108      	bne.n	c0d032b8 <_readTx+0x120>

    if (c->offset < c->bufferLen) {
c0d032a6:	88a0      	ldrh	r0, [r4, #4]
c0d032a8:	88e1      	ldrh	r1, [r4, #6]
c0d032aa:	4281      	cmp	r1, r0
c0d032ac:	d206      	bcs.n	c0d032bc <_readTx+0x124>
c0d032ae:	2012      	movs	r0, #18
c0d032b0:	e002      	b.n	c0d032b8 <_readTx+0x120>
c0d032b2:	4630      	mov	r0, r6
c0d032b4:	e000      	b.n	c0d032b8 <_readTx+0x120>
c0d032b6:	2001      	movs	r0, #1
    }

    __address_type = _detectAddressType(c);

    return parser_ok;
}
c0d032b8:	b003      	add	sp, #12
c0d032ba:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d032bc:	4630      	mov	r0, r6
    if (c->offset > c->bufferLen) {
c0d032be:	d8fb      	bhi.n	c0d032b8 <_readTx+0x120>
    __address_type = _detectAddressType(c);
c0d032c0:	4620      	mov	r0, r4
c0d032c2:	f7ff ff49 	bl	c0d03158 <_detectAddressType>
c0d032c6:	4902      	ldr	r1, [pc, #8]	; (c0d032d0 <_readTx+0x138>)
c0d032c8:	7008      	strb	r0, [r1, #0]
c0d032ca:	2000      	movs	r0, #0
c0d032cc:	e7f4      	b.n	c0d032b8 <_readTx+0x120>
c0d032ce:	46c0      	nop			; (mov r8, r8)
c0d032d0:	20000434 	.word	0x20000434

c0d032d4 <_toStringPubkeyAsAddress>:
    return parser_ok;
}

parser_error_t _toStringPubkeyAsAddress(const uint8_t *pubkey,
                                        char *outValue, uint16_t outValueLen,
                                        uint8_t pageIdx, uint8_t *pageCount) {
c0d032d4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d032d6:	b0b5      	sub	sp, #212	; 0xd4
c0d032d8:	461c      	mov	r4, r3
c0d032da:	4617      	mov	r7, r2
c0d032dc:	460e      	mov	r6, r1
c0d032de:	4603      	mov	r3, r0
    char bufferUI[200];

    if (crypto_SS58EncodePubkey((uint8_t *) bufferUI, sizeof(bufferUI), __address_type, pubkey) == 0) {
c0d032e0:	4822      	ldr	r0, [pc, #136]	; (c0d0336c <_toStringPubkeyAsAddress+0x98>)
c0d032e2:	7802      	ldrb	r2, [r0, #0]
c0d032e4:	a803      	add	r0, sp, #12
c0d032e6:	21c8      	movs	r1, #200	; 0xc8
c0d032e8:	f7fe f92e 	bl	c0d01548 <crypto_SS58EncodePubkey>
c0d032ec:	2800      	cmp	r0, #0
c0d032ee:	d039      	beq.n	c0d03364 <_toStringPubkeyAsAddress+0x90>
c0d032f0:	9402      	str	r4, [sp, #8]
c0d032f2:	9c3a      	ldr	r4, [sp, #232]	; 0xe8
c0d032f4:	a803      	add	r0, sp, #12
    pageStringExt(outValue, outValueLen, inValue, (uint16_t) strlen(inValue), pageIdx, pageCount);
c0d032f6:	f004 f9ad 	bl	c0d07654 <strlen>
c0d032fa:	4605      	mov	r5, r0
c0d032fc:	9600      	str	r6, [sp, #0]
    MEMZERO(outValue, outValueLen);
c0d032fe:	4630      	mov	r0, r6
c0d03300:	4639      	mov	r1, r7
c0d03302:	f004 f817 	bl	c0d07334 <explicit_bzero>
c0d03306:	2600      	movs	r6, #0
c0d03308:	9401      	str	r4, [sp, #4]
    *pageCount = 0;
c0d0330a:	7026      	strb	r6, [r4, #0]
    outValueLen--;  // leave space for NULL termination
c0d0330c:	1e7c      	subs	r4, r7, #1
c0d0330e:	b2a7      	uxth	r7, r4
    if (outValueLen == 0) {
c0d03310:	2f00      	cmp	r7, #0
c0d03312:	d022      	beq.n	c0d0335a <_toStringPubkeyAsAddress+0x86>
c0d03314:	0428      	lsls	r0, r5, #16
c0d03316:	d020      	beq.n	c0d0335a <_toStringPubkeyAsAddress+0x86>
c0d03318:	b2a8      	uxth	r0, r5
    *pageCount = (uint8_t) (inValueLen / outValueLen);
c0d0331a:	4639      	mov	r1, r7
c0d0331c:	f003 fe62 	bl	c0d06fe4 <__udivsi3>
c0d03320:	4344      	muls	r4, r0
c0d03322:	1b2b      	subs	r3, r5, r4
c0d03324:	b29a      	uxth	r2, r3
    if (lastChunkLen > 0) {
c0d03326:	1e51      	subs	r1, r2, #1
c0d03328:	4614      	mov	r4, r2
c0d0332a:	418c      	sbcs	r4, r1
c0d0332c:	1820      	adds	r0, r4, r0
c0d0332e:	9901      	ldr	r1, [sp, #4]
c0d03330:	7008      	strb	r0, [r1, #0]
c0d03332:	b2c0      	uxtb	r0, r0
    if (pageIdx < *pageCount) {
c0d03334:	9902      	ldr	r1, [sp, #8]
c0d03336:	4288      	cmp	r0, r1
c0d03338:	d90f      	bls.n	c0d0335a <_toStringPubkeyAsAddress+0x86>
c0d0333a:	4639      	mov	r1, r7
c0d0333c:	9d02      	ldr	r5, [sp, #8]
c0d0333e:	4369      	muls	r1, r5
c0d03340:	ac03      	add	r4, sp, #12
c0d03342:	1861      	adds	r1, r4, r1
        if (lastChunkLen > 0 && pageIdx == *pageCount - 1) {
c0d03344:	041b      	lsls	r3, r3, #16
c0d03346:	d004      	beq.n	c0d03352 <_toStringPubkeyAsAddress+0x7e>
c0d03348:	1e40      	subs	r0, r0, #1
c0d0334a:	42a8      	cmp	r0, r5
c0d0334c:	d101      	bne.n	c0d03352 <_toStringPubkeyAsAddress+0x7e>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), lastChunkLen);
c0d0334e:	9800      	ldr	r0, [sp, #0]
c0d03350:	e001      	b.n	c0d03356 <_toStringPubkeyAsAddress+0x82>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), outValueLen);
c0d03352:	9800      	ldr	r0, [sp, #0]
c0d03354:	463a      	mov	r2, r7
c0d03356:	f003 ffdd 	bl	c0d07314 <__aeabi_memcpy>
        return parser_no_data;
    }

    pageString(outValue, outValueLen, bufferUI, pageIdx, pageCount);
    if (pageIdx >= *pageCount) {
c0d0335a:	9801      	ldr	r0, [sp, #4]
c0d0335c:	7800      	ldrb	r0, [r0, #0]
c0d0335e:	9902      	ldr	r1, [sp, #8]
c0d03360:	4288      	cmp	r0, r1
c0d03362:	d800      	bhi.n	c0d03366 <_toStringPubkeyAsAddress+0x92>
c0d03364:	2601      	movs	r6, #1
        return parser_no_data;
    }
    return parser_ok;
}
c0d03366:	4630      	mov	r0, r6
c0d03368:	b035      	add	sp, #212	; 0xd4
c0d0336a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0336c:	20000434 	.word	0x20000434

c0d03370 <pic_internal>:
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
__attribute__((naked)) void *pic_internal(void *link_address)
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");
c0d03370:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");
c0d03372:	4902      	ldr	r1, [pc, #8]	; (c0d0337c <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");
c0d03374:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");
c0d03376:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");
c0d03378:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d0337a:	4770      	bx	lr
c0d0337c:	c0d03371 	.word	0xc0d03371

c0d03380 <pic>:
extern void _nvram;
extern void _envram;

#if defined(ST31)

void *pic(void *link_address) {
c0d03380:	b580      	push	{r7, lr}
  // check if in the LINKED TEXT zone
  if (link_address >= &_nvram && link_address < &_envram) {
c0d03382:	4904      	ldr	r1, [pc, #16]	; (c0d03394 <pic+0x14>)
c0d03384:	4288      	cmp	r0, r1
c0d03386:	d304      	bcc.n	c0d03392 <pic+0x12>
c0d03388:	4903      	ldr	r1, [pc, #12]	; (c0d03398 <pic+0x18>)
c0d0338a:	4288      	cmp	r0, r1
c0d0338c:	d201      	bcs.n	c0d03392 <pic+0x12>
    link_address = pic_internal(link_address);
c0d0338e:	f7ff ffef 	bl	c0d03370 <pic_internal>
  }

  return link_address;
c0d03392:	bd80      	pop	{r7, pc}
c0d03394:	c0d00000 	.word	0xc0d00000
c0d03398:	c0d0a680 	.word	0xc0d0a680

c0d0339c <secret_accept>:
#include "app_main.h"
#include "tx.h"
#include "view.h"
#include "app_mode.h"

void secret_accept() {
c0d0339c:	b580      	push	{r7, lr}
c0d0339e:	2001      	movs	r0, #1
#ifdef APP_SECRET_MODE_ENABLED
    app_mode_set_secret(true);
c0d033a0:	f7fd fcda 	bl	c0d00d58 <app_mode_set_secret>
c0d033a4:	2000      	movs	r0, #0
    view_idle_show(0, NULL);
c0d033a6:	4601      	mov	r1, r0
c0d033a8:	f003 f832 	bl	c0d06410 <view_idle_show>
#endif
}
c0d033ac:	bd80      	pop	{r7, pc}
	...

c0d033b0 <secret_getNumItems>:
        "USE AT YOUR OWN RISK!! "
        "You are about to enable the DOT recovery mode."
        "If you are not sure why you are here, reject or unplug your device immediately."
        "Activating this mode will temporarily allow you to sign transactions using Kusama keys";

zxerr_t secret_getNumItems(uint8_t *num_items) {
c0d033b0:	b510      	push	{r4, lr}
c0d033b2:	4604      	mov	r4, r0
    zemu_log_stack("secret_getNumItems");
c0d033b4:	4803      	ldr	r0, [pc, #12]	; (c0d033c4 <secret_getNumItems+0x14>)
c0d033b6:	4478      	add	r0, pc
c0d033b8:	f003 fe12 	bl	c0d06fe0 <zemu_log_stack>
c0d033bc:	2001      	movs	r0, #1
    *num_items = 1;
c0d033be:	7020      	strb	r0, [r4, #0]
c0d033c0:	2003      	movs	r0, #3
    return zxerr_ok;
c0d033c2:	bd10      	pop	{r4, pc}
c0d033c4:	0000471b 	.word	0x0000471b

c0d033c8 <secret_getItem>:
}

zxerr_t secret_getItem(int8_t displayIdx,
                       char *outKey, uint16_t outKeyLen,
                       char *outVal, uint16_t outValLen,
                       uint8_t pageIdx, uint8_t *pageCount) {
c0d033c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d033ca:	b085      	sub	sp, #20
    if (displayIdx != 0) {
c0d033cc:	2800      	cmp	r0, #0
c0d033ce:	d003      	beq.n	c0d033d8 <secret_getItem+0x10>
c0d033d0:	2505      	movs	r5, #5
    }

    snprintf(outKey, outKeyLen, "WARNING!");
    pageString(outVal, outValLen, (char *) PIC(secret_message), pageIdx, pageCount);
    return zxerr_ok;
}
c0d033d2:	4628      	mov	r0, r5
c0d033d4:	b005      	add	sp, #20
c0d033d6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d033d8:	461c      	mov	r4, r3
c0d033da:	9f0c      	ldr	r7, [sp, #48]	; 0x30
c0d033dc:	9d0a      	ldr	r5, [sp, #40]	; 0x28
    snprintf(outKey, outKeyLen, "WARNING!");
c0d033de:	4b20      	ldr	r3, [pc, #128]	; (c0d03460 <secret_getItem+0x98>)
c0d033e0:	447b      	add	r3, pc
c0d033e2:	4608      	mov	r0, r1
c0d033e4:	4611      	mov	r1, r2
c0d033e6:	461a      	mov	r2, r3
c0d033e8:	f7fe fec2 	bl	c0d02170 <snprintf>
    pageString(outVal, outValLen, (char *) PIC(secret_message), pageIdx, pageCount);
c0d033ec:	481d      	ldr	r0, [pc, #116]	; (c0d03464 <secret_getItem+0x9c>)
c0d033ee:	4478      	add	r0, pc
c0d033f0:	f7ff ffc6 	bl	c0d03380 <pic>
c0d033f4:	9003      	str	r0, [sp, #12]
    pageStringExt(outValue, outValueLen, inValue, (uint16_t) strlen(inValue), pageIdx, pageCount);
c0d033f6:	f004 f92d 	bl	c0d07654 <strlen>
c0d033fa:	4606      	mov	r6, r0
c0d033fc:	9402      	str	r4, [sp, #8]
    MEMZERO(outValue, outValueLen);
c0d033fe:	4620      	mov	r0, r4
c0d03400:	4629      	mov	r1, r5
c0d03402:	f003 ff97 	bl	c0d07334 <explicit_bzero>
c0d03406:	2000      	movs	r0, #0
c0d03408:	9704      	str	r7, [sp, #16]
    *pageCount = 0;
c0d0340a:	7038      	strb	r0, [r7, #0]
    outValueLen--;  // leave space for NULL termination
c0d0340c:	1e6c      	subs	r4, r5, #1
c0d0340e:	b2a7      	uxth	r7, r4
c0d03410:	2503      	movs	r5, #3
    if (outValueLen == 0) {
c0d03412:	2f00      	cmp	r7, #0
c0d03414:	d0dd      	beq.n	c0d033d2 <secret_getItem+0xa>
c0d03416:	0430      	lsls	r0, r6, #16
c0d03418:	d0db      	beq.n	c0d033d2 <secret_getItem+0xa>
c0d0341a:	980b      	ldr	r0, [sp, #44]	; 0x2c
    *pageCount = (uint8_t) (inValueLen / outValueLen);
c0d0341c:	9001      	str	r0, [sp, #4]
c0d0341e:	b2b0      	uxth	r0, r6
c0d03420:	4639      	mov	r1, r7
c0d03422:	f003 fddf 	bl	c0d06fe4 <__udivsi3>
c0d03426:	4344      	muls	r4, r0
c0d03428:	1b33      	subs	r3, r6, r4
c0d0342a:	9e01      	ldr	r6, [sp, #4]
c0d0342c:	b29a      	uxth	r2, r3
    if (lastChunkLen > 0) {
c0d0342e:	1e51      	subs	r1, r2, #1
c0d03430:	4614      	mov	r4, r2
c0d03432:	418c      	sbcs	r4, r1
c0d03434:	1820      	adds	r0, r4, r0
c0d03436:	9904      	ldr	r1, [sp, #16]
c0d03438:	7008      	strb	r0, [r1, #0]
c0d0343a:	b2c0      	uxtb	r0, r0
    if (pageIdx < *pageCount) {
c0d0343c:	42b0      	cmp	r0, r6
c0d0343e:	d9c8      	bls.n	c0d033d2 <secret_getItem+0xa>
c0d03440:	4639      	mov	r1, r7
c0d03442:	4371      	muls	r1, r6
c0d03444:	9c03      	ldr	r4, [sp, #12]
c0d03446:	1861      	adds	r1, r4, r1
        if (lastChunkLen > 0 && pageIdx == *pageCount - 1) {
c0d03448:	041b      	lsls	r3, r3, #16
c0d0344a:	d004      	beq.n	c0d03456 <secret_getItem+0x8e>
c0d0344c:	1e40      	subs	r0, r0, #1
c0d0344e:	42b0      	cmp	r0, r6
c0d03450:	d101      	bne.n	c0d03456 <secret_getItem+0x8e>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), lastChunkLen);
c0d03452:	9802      	ldr	r0, [sp, #8]
c0d03454:	e001      	b.n	c0d0345a <secret_getItem+0x92>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), outValueLen);
c0d03456:	9802      	ldr	r0, [sp, #8]
c0d03458:	463a      	mov	r2, r7
c0d0345a:	f003 ff5b 	bl	c0d07314 <__aeabi_memcpy>
c0d0345e:	e7b8      	b.n	c0d033d2 <secret_getItem+0xa>
c0d03460:	00004704 	.word	0x00004704
c0d03464:	000046ff 	.word	0x000046ff

c0d03468 <secret_enabled>:

zxerr_t secret_enabled() {
c0d03468:	b580      	push	{r7, lr}
#ifdef APP_SECRET_MODE_ENABLED
    zemu_log("RECOVERY TRIGGERED");
    view_review_init(secret_getItem, secret_getNumItems, secret_accept);
c0d0346a:	4806      	ldr	r0, [pc, #24]	; (c0d03484 <secret_enabled+0x1c>)
c0d0346c:	4478      	add	r0, pc
c0d0346e:	4906      	ldr	r1, [pc, #24]	; (c0d03488 <secret_enabled+0x20>)
c0d03470:	4479      	add	r1, pc
c0d03472:	4a06      	ldr	r2, [pc, #24]	; (c0d0348c <secret_enabled+0x24>)
c0d03474:	447a      	add	r2, pc
c0d03476:	f003 fa3d 	bl	c0d068f4 <view_review_init>
    view_review_show();
c0d0347a:	f003 fa41 	bl	c0d06900 <view_review_show>
c0d0347e:	2003      	movs	r0, #3
#endif
    return zxerr_ok;
c0d03480:	bd80      	pop	{r7, pc}
c0d03482:	46c0      	nop			; (mov r8, r8)
c0d03484:	ffffff59 	.word	0xffffff59
c0d03488:	ffffff3d 	.word	0xffffff3d
c0d0348c:	ffffff25 	.word	0xffffff25

c0d03490 <_readMethod>:
parser_error_t _readMethod(
    parser_context_t* c,
    uint8_t moduleIdx,
    uint8_t callIdx,
    pd_Method_t* method)
{
c0d03490:	b510      	push	{r4, lr}
    switch (c->tx_obj->transactionVersion) {
c0d03492:	6884      	ldr	r4, [r0, #8]
c0d03494:	6de4      	ldr	r4, [r4, #92]	; 0x5c
c0d03496:	2c01      	cmp	r4, #1
c0d03498:	d102      	bne.n	c0d034a0 <_readMethod+0x10>
    case 1:
        return _readMethod_V1(c, moduleIdx, callIdx, &method->V1);
c0d0349a:	f000 f859 	bl	c0d03550 <_readMethod_V1>
    default:
        return parser_tx_version_not_supported;
    }
}
c0d0349e:	bd10      	pop	{r4, pc}
c0d034a0:	2008      	movs	r0, #8
c0d034a2:	bd10      	pop	{r4, pc}

c0d034a4 <_getMethod_NumItems>:

parser_error_t _getMethod_NumItems(uint32_t transactionVersion, uint8_t moduleIdx, uint8_t callIdx, uint8_t* numItems)
{
c0d034a4:	b580      	push	{r7, lr}
    switch (transactionVersion) {
c0d034a6:	2801      	cmp	r0, #1
c0d034a8:	d105      	bne.n	c0d034b6 <_getMethod_NumItems+0x12>
    case 1:
        return _getMethod_NumItems_V1(moduleIdx, callIdx, numItems);
c0d034aa:	4608      	mov	r0, r1
c0d034ac:	4611      	mov	r1, r2
c0d034ae:	461a      	mov	r2, r3
c0d034b0:	f000 f9e8 	bl	c0d03884 <_getMethod_NumItems_V1>
    default:
        // TODO: This isn't correct. A mutable argument should be expected and error value should be checked of this function
        return parser_tx_version_not_supported;
    }
}
c0d034b4:	bd80      	pop	{r7, pc}
c0d034b6:	2008      	movs	r0, #8
c0d034b8:	bd80      	pop	{r7, pc}

c0d034ba <_getMethod_ModuleName>:

const char* _getMethod_ModuleName(uint32_t transactionVersion, uint8_t moduleIdx)
{
c0d034ba:	b580      	push	{r7, lr}
    switch (transactionVersion) {
c0d034bc:	2801      	cmp	r0, #1
c0d034be:	d103      	bne.n	c0d034c8 <_getMethod_ModuleName+0xe>
    case 1:
        return _getMethod_ModuleName_V1(moduleIdx);
c0d034c0:	4608      	mov	r0, r1
c0d034c2:	f000 f905 	bl	c0d036d0 <_getMethod_ModuleName_V1>
    default:
        return NULL;
    }
}
c0d034c6:	bd80      	pop	{r7, pc}
c0d034c8:	2000      	movs	r0, #0
c0d034ca:	bd80      	pop	{r7, pc}

c0d034cc <_getMethod_Name>:

const char* _getMethod_Name(uint32_t transactionVersion, uint8_t moduleIdx, uint8_t callIdx)
{
c0d034cc:	b580      	push	{r7, lr}
    switch (transactionVersion) {
c0d034ce:	2801      	cmp	r0, #1
c0d034d0:	d104      	bne.n	c0d034dc <_getMethod_Name+0x10>
    case 1:
        return _getMethod_Name_V1(moduleIdx, callIdx);
c0d034d2:	4608      	mov	r0, r1
c0d034d4:	4611      	mov	r1, r2
c0d034d6:	f000 f91b 	bl	c0d03710 <_getMethod_Name_V1>
    default:
        return 0;
    }
}
c0d034da:	bd80      	pop	{r7, pc}
c0d034dc:	2000      	movs	r0, #0
c0d034de:	bd80      	pop	{r7, pc}

c0d034e0 <_getMethod_ItemName>:

const char* _getMethod_ItemName(uint32_t transactionVersion, uint8_t moduleIdx, uint8_t callIdx, uint8_t itemIdx)
{
c0d034e0:	b580      	push	{r7, lr}
    switch (transactionVersion) {
c0d034e2:	2801      	cmp	r0, #1
c0d034e4:	d105      	bne.n	c0d034f2 <_getMethod_ItemName+0x12>
    case 1:
        return _getMethod_ItemName_V1(moduleIdx, callIdx, itemIdx);
c0d034e6:	4608      	mov	r0, r1
c0d034e8:	4611      	mov	r1, r2
c0d034ea:	461a      	mov	r2, r3
c0d034ec:	f000 fa3c 	bl	c0d03968 <_getMethod_ItemName_V1>
    default:
        return NULL;
    }
}
c0d034f0:	bd80      	pop	{r7, pc}
c0d034f2:	2000      	movs	r0, #0
c0d034f4:	bd80      	pop	{r7, pc}

c0d034f6 <_getMethod_ItemValue>:

parser_error_t _getMethod_ItemValue(uint32_t transactionVersion, pd_Method_t* m, uint8_t moduleIdx, uint8_t callIdx,
    uint8_t itemIdx, char* outValue, uint16_t outValueLen,
    uint8_t pageIdx, uint8_t* pageCount)
{
c0d034f6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d034f8:	b085      	sub	sp, #20
    switch (transactionVersion) {
c0d034fa:	2801      	cmp	r0, #1
c0d034fc:	d10f      	bne.n	c0d0351e <_getMethod_ItemValue+0x28>
c0d034fe:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d03500:	9d0d      	ldr	r5, [sp, #52]	; 0x34
c0d03502:	9e0c      	ldr	r6, [sp, #48]	; 0x30
c0d03504:	9f0b      	ldr	r7, [sp, #44]	; 0x2c
c0d03506:	9c0a      	ldr	r4, [sp, #40]	; 0x28
    case 1:
        return _getMethod_ItemValue_V1(&m->V1, moduleIdx, callIdx, itemIdx, outValue,
c0d03508:	9700      	str	r7, [sp, #0]
c0d0350a:	9601      	str	r6, [sp, #4]
c0d0350c:	9502      	str	r5, [sp, #8]
c0d0350e:	9003      	str	r0, [sp, #12]
c0d03510:	4608      	mov	r0, r1
c0d03512:	4611      	mov	r1, r2
c0d03514:	461a      	mov	r2, r3
c0d03516:	4623      	mov	r3, r4
c0d03518:	f000 fae2 	bl	c0d03ae0 <_getMethod_ItemValue_V1>
c0d0351c:	e000      	b.n	c0d03520 <_getMethod_ItemValue+0x2a>
c0d0351e:	2008      	movs	r0, #8
            outValueLen, pageIdx, pageCount);
    default:
        return parser_tx_version_not_supported;
    }
}
c0d03520:	b005      	add	sp, #20
c0d03522:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03524 <_getMethod_ItemIsExpert>:

bool _getMethod_ItemIsExpert(uint32_t transactionVersion, uint8_t moduleIdx, uint8_t callIdx, uint8_t itemIdx)
{
c0d03524:	b580      	push	{r7, lr}
    switch (transactionVersion) {
c0d03526:	2801      	cmp	r0, #1
c0d03528:	d105      	bne.n	c0d03536 <_getMethod_ItemIsExpert+0x12>
    case 1:
        return _getMethod_ItemIsExpert_V1(moduleIdx, callIdx, itemIdx);
c0d0352a:	4608      	mov	r0, r1
c0d0352c:	4611      	mov	r1, r2
c0d0352e:	461a      	mov	r2, r3
c0d03530:	f000 fbc8 	bl	c0d03cc4 <_getMethod_ItemIsExpert_V1>
    default:
        return false;
    }
}
c0d03534:	bd80      	pop	{r7, pc}
c0d03536:	2000      	movs	r0, #0
c0d03538:	bd80      	pop	{r7, pc}

c0d0353a <_getMethod_IsNestingSupported>:

bool _getMethod_IsNestingSupported(uint32_t transactionVersion, uint8_t moduleIdx, uint8_t callIdx)
{
c0d0353a:	b580      	push	{r7, lr}
    switch (transactionVersion) {
c0d0353c:	2801      	cmp	r0, #1
c0d0353e:	d104      	bne.n	c0d0354a <_getMethod_IsNestingSupported+0x10>
    case 1:
        return _getMethod_IsNestingSupported_V1(moduleIdx, callIdx);
c0d03540:	4608      	mov	r0, r1
c0d03542:	4611      	mov	r1, r2
c0d03544:	f000 fbd8 	bl	c0d03cf8 <_getMethod_IsNestingSupported_V1>
    default:
        return false;
    }
}
c0d03548:	bd80      	pop	{r7, pc}
c0d0354a:	2000      	movs	r0, #0
c0d0354c:	bd80      	pop	{r7, pc}
	...

c0d03550 <_readMethod_V1>:
parser_error_t _readMethod_V1(
    parser_context_t* c,
    uint8_t moduleIdx,
    uint8_t callIdx,
    pd_Method_V1_t* method)
{
c0d03550:	b5b0      	push	{r4, r5, r7, lr}
c0d03552:	461c      	mov	r4, r3
c0d03554:	4605      	mov	r5, r0
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;
c0d03556:	0208      	lsls	r0, r1, #8
c0d03558:	1881      	adds	r1, r0, r2
c0d0355a:	2010      	movs	r0, #16
c0d0355c:	4a4c      	ldr	r2, [pc, #304]	; (c0d03690 <_readMethod_V1+0x140>)

    switch (callPrivIdx) {
c0d0355e:	4291      	cmp	r1, r2
c0d03560:	dc13      	bgt.n	c0d0358a <_readMethod_V1+0x3a>
c0d03562:	4b55      	ldr	r3, [pc, #340]	; (c0d036b8 <_readMethod_V1+0x168>)
c0d03564:	4299      	cmp	r1, r3
c0d03566:	dc20      	bgt.n	c0d035aa <_readMethod_V1+0x5a>
c0d03568:	4a56      	ldr	r2, [pc, #344]	; (c0d036c4 <_readMethod_V1+0x174>)
c0d0356a:	4291      	cmp	r1, r2
c0d0356c:	dc3a      	bgt.n	c0d035e4 <_readMethod_V1+0x94>
c0d0356e:	2201      	movs	r2, #1
c0d03570:	0252      	lsls	r2, r2, #9
c0d03572:	4291      	cmp	r1, r2
c0d03574:	d002      	beq.n	c0d0357c <_readMethod_V1+0x2c>
c0d03576:	4a55      	ldr	r2, [pc, #340]	; (c0d036cc <_readMethod_V1+0x17c>)
c0d03578:	4291      	cmp	r1, r2
c0d0357a:	d105      	bne.n	c0d03588 <_readMethod_V1+0x38>
c0d0357c:	4628      	mov	r0, r5
c0d0357e:	4621      	mov	r1, r4
c0d03580:	f001 f8a6 	bl	c0d046d0 <_readLookupSource_V1>
c0d03584:	2800      	cmp	r0, #0
c0d03586:	d079      	beq.n	c0d0367c <_readMethod_V1+0x12c>
    default:
        return parser_unexpected_callIndex;
    }

    return parser_ok;
}
c0d03588:	bdb0      	pop	{r4, r5, r7, pc}
c0d0358a:	4a42      	ldr	r2, [pc, #264]	; (c0d03694 <_readMethod_V1+0x144>)
    switch (callPrivIdx) {
c0d0358c:	4291      	cmp	r1, r2
c0d0358e:	dc1b      	bgt.n	c0d035c8 <_readMethod_V1+0x78>
c0d03590:	4b46      	ldr	r3, [pc, #280]	; (c0d036ac <_readMethod_V1+0x15c>)
c0d03592:	4299      	cmp	r1, r3
c0d03594:	dc2e      	bgt.n	c0d035f4 <_readMethod_V1+0xa4>
c0d03596:	4a47      	ldr	r2, [pc, #284]	; (c0d036b4 <_readMethod_V1+0x164>)
c0d03598:	4291      	cmp	r1, r2
c0d0359a:	d04e      	beq.n	c0d0363a <_readMethod_V1+0xea>
c0d0359c:	4299      	cmp	r1, r3
c0d0359e:	d1f3      	bne.n	c0d03588 <_readMethod_V1+0x38>
    CHECK_ERROR(_readu32(c, &m->num_slashing_spans))
c0d035a0:	4628      	mov	r0, r5
c0d035a2:	4621      	mov	r1, r4
c0d035a4:	f000 fc52 	bl	c0d03e4c <_readu32>
c0d035a8:	e06d      	b.n	c0d03686 <_readMethod_V1+0x136>
c0d035aa:	4b44      	ldr	r3, [pc, #272]	; (c0d036bc <_readMethod_V1+0x16c>)
    switch (callPrivIdx) {
c0d035ac:	4299      	cmp	r1, r3
c0d035ae:	dc2b      	bgt.n	c0d03608 <_readMethod_V1+0xb8>
c0d035b0:	2201      	movs	r2, #1
c0d035b2:	02d2      	lsls	r2, r2, #11
c0d035b4:	4291      	cmp	r1, r2
c0d035b6:	d002      	beq.n	c0d035be <_readMethod_V1+0x6e>
c0d035b8:	4a41      	ldr	r2, [pc, #260]	; (c0d036c0 <_readMethod_V1+0x170>)
c0d035ba:	4291      	cmp	r1, r2
c0d035bc:	d1e4      	bne.n	c0d03588 <_readMethod_V1+0x38>
c0d035be:	4628      	mov	r0, r5
c0d035c0:	4621      	mov	r1, r4
c0d035c2:	f000 fcde 	bl	c0d03f82 <_readVecCall>
c0d035c6:	e05e      	b.n	c0d03686 <_readMethod_V1+0x136>
c0d035c8:	4a33      	ldr	r2, [pc, #204]	; (c0d03698 <_readMethod_V1+0x148>)
c0d035ca:	4291      	cmp	r1, r2
c0d035cc:	dc2f      	bgt.n	c0d0362e <_readMethod_V1+0xde>
c0d035ce:	4a35      	ldr	r2, [pc, #212]	; (c0d036a4 <_readMethod_V1+0x154>)
c0d035d0:	4291      	cmp	r1, r2
c0d035d2:	d05b      	beq.n	c0d0368c <_readMethod_V1+0x13c>
c0d035d4:	4a34      	ldr	r2, [pc, #208]	; (c0d036a8 <_readMethod_V1+0x158>)
c0d035d6:	4291      	cmp	r1, r2
c0d035d8:	d1d6      	bne.n	c0d03588 <_readMethod_V1+0x38>
c0d035da:	4628      	mov	r0, r5
c0d035dc:	4621      	mov	r1, r4
c0d035de:	f001 f8c3 	bl	c0d04768 <_readRewardDestination_V1>
c0d035e2:	e050      	b.n	c0d03686 <_readMethod_V1+0x136>
c0d035e4:	2203      	movs	r2, #3
c0d035e6:	0212      	lsls	r2, r2, #8
c0d035e8:	4291      	cmp	r1, r2
c0d035ea:	d02b      	beq.n	c0d03644 <_readMethod_V1+0xf4>
c0d035ec:	4a36      	ldr	r2, [pc, #216]	; (c0d036c8 <_readMethod_V1+0x178>)
c0d035ee:	4291      	cmp	r1, r2
c0d035f0:	d04c      	beq.n	c0d0368c <_readMethod_V1+0x13c>
c0d035f2:	e7c9      	b.n	c0d03588 <_readMethod_V1+0x38>
c0d035f4:	4b2e      	ldr	r3, [pc, #184]	; (c0d036b0 <_readMethod_V1+0x160>)
c0d035f6:	4299      	cmp	r1, r3
c0d035f8:	d030      	beq.n	c0d0365c <_readMethod_V1+0x10c>
c0d035fa:	4291      	cmp	r1, r2
c0d035fc:	d1c4      	bne.n	c0d03588 <_readMethod_V1+0x38>
    CHECK_ERROR(_readVecLookupSource_V1(c, &m->targets))
c0d035fe:	4628      	mov	r0, r5
c0d03600:	4621      	mov	r1, r4
c0d03602:	f001 f8e8 	bl	c0d047d6 <_readVecLookupSource_V1>
c0d03606:	e03e      	b.n	c0d03686 <_readMethod_V1+0x136>
c0d03608:	231f      	movs	r3, #31
c0d0360a:	021b      	lsls	r3, r3, #8
    switch (callPrivIdx) {
c0d0360c:	4299      	cmp	r1, r3
c0d0360e:	d112      	bne.n	c0d03636 <_readMethod_V1+0xe6>
    CHECK_ERROR(_readLookupSource_V1(c, &m->controller))
c0d03610:	4628      	mov	r0, r5
c0d03612:	4621      	mov	r1, r4
c0d03614:	f001 f85c 	bl	c0d046d0 <_readLookupSource_V1>
c0d03618:	2800      	cmp	r0, #0
c0d0361a:	d1b5      	bne.n	c0d03588 <_readMethod_V1+0x38>
    CHECK_ERROR(_readCompactBalanceOf(c, &m->value))
c0d0361c:	4621      	mov	r1, r4
c0d0361e:	3118      	adds	r1, #24
c0d03620:	4628      	mov	r0, r5
c0d03622:	f000 fd01 	bl	c0d04028 <_readCompactBalanceOf>
c0d03626:	2800      	cmp	r0, #0
c0d03628:	d1ae      	bne.n	c0d03588 <_readMethod_V1+0x38>
    CHECK_ERROR(_readRewardDestination_V1(c, &m->payee))
c0d0362a:	3420      	adds	r4, #32
c0d0362c:	e7d5      	b.n	c0d035da <_readMethod_V1+0x8a>
c0d0362e:	4a1b      	ldr	r2, [pc, #108]	; (c0d0369c <_readMethod_V1+0x14c>)
    switch (callPrivIdx) {
c0d03630:	4291      	cmp	r1, r2
c0d03632:	d018      	beq.n	c0d03666 <_readMethod_V1+0x116>
c0d03634:	4a1a      	ldr	r2, [pc, #104]	; (c0d036a0 <_readMethod_V1+0x150>)
c0d03636:	4291      	cmp	r1, r2
c0d03638:	d1a6      	bne.n	c0d03588 <_readMethod_V1+0x38>
c0d0363a:	4628      	mov	r0, r5
c0d0363c:	4621      	mov	r1, r4
c0d0363e:	f000 fcf3 	bl	c0d04028 <_readCompactBalanceOf>
c0d03642:	e020      	b.n	c0d03686 <_readMethod_V1+0x136>
    CHECK_ERROR(_readKeys_V1(c, &m->keys))
c0d03644:	4628      	mov	r0, r5
c0d03646:	4621      	mov	r1, r4
c0d03648:	f001 f835 	bl	c0d046b6 <_readKeys_V1>
c0d0364c:	2800      	cmp	r0, #0
c0d0364e:	d19b      	bne.n	c0d03588 <_readMethod_V1+0x38>
    CHECK_ERROR(_readBytes(c, &m->proof))
c0d03650:	3408      	adds	r4, #8
c0d03652:	4628      	mov	r0, r5
c0d03654:	4621      	mov	r1, r4
c0d03656:	f000 fc42 	bl	c0d03ede <_readBytes>
c0d0365a:	e014      	b.n	c0d03686 <_readMethod_V1+0x136>
    CHECK_ERROR(_readValidatorPrefs_V1(c, &m->prefs))
c0d0365c:	4628      	mov	r0, r5
c0d0365e:	4621      	mov	r1, r4
c0d03660:	f001 f89e 	bl	c0d047a0 <_readValidatorPrefs_V1>
c0d03664:	e00f      	b.n	c0d03686 <_readMethod_V1+0x136>
    CHECK_ERROR(_readAccountId_V1(c, &m->validator_stash))
c0d03666:	4628      	mov	r0, r5
c0d03668:	4621      	mov	r1, r4
c0d0366a:	f001 f813 	bl	c0d04694 <_readAccountId_V1>
c0d0366e:	2800      	cmp	r0, #0
c0d03670:	d18a      	bne.n	c0d03588 <_readMethod_V1+0x38>
    CHECK_ERROR(_readEraIndex_V1(c, &m->era))
c0d03672:	1d21      	adds	r1, r4, #4
c0d03674:	4628      	mov	r0, r5
c0d03676:	f001 f81a 	bl	c0d046ae <_readEraIndex_V1>
c0d0367a:	e004      	b.n	c0d03686 <_readMethod_V1+0x136>
c0d0367c:	3418      	adds	r4, #24
c0d0367e:	4628      	mov	r0, r5
c0d03680:	4621      	mov	r1, r4
c0d03682:	f7ff fcd0 	bl	c0d03026 <_readCompactBalance>
c0d03686:	2800      	cmp	r0, #0
c0d03688:	d000      	beq.n	c0d0368c <_readMethod_V1+0x13c>
c0d0368a:	e77d      	b.n	c0d03588 <_readMethod_V1+0x38>
c0d0368c:	2000      	movs	r0, #0
}
c0d0368e:	bdb0      	pop	{r4, r5, r7, pc}
c0d03690:	00001f01 	.word	0x00001f01
c0d03694:	00001f05 	.word	0x00001f05
c0d03698:	00001f11 	.word	0x00001f11
c0d0369c:	00001f12 	.word	0x00001f12
c0d036a0:	00001f13 	.word	0x00001f13
c0d036a4:	00001f06 	.word	0x00001f06
c0d036a8:	00001f07 	.word	0x00001f07
c0d036ac:	00001f03 	.word	0x00001f03
c0d036b0:	00001f04 	.word	0x00001f04
c0d036b4:	00001f02 	.word	0x00001f02
c0d036b8:	000007ff 	.word	0x000007ff
c0d036bc:	00001eff 	.word	0x00001eff
c0d036c0:	00000802 	.word	0x00000802
c0d036c4:	000002ff 	.word	0x000002ff
c0d036c8:	00000301 	.word	0x00000301
c0d036cc:	00000203 	.word	0x00000203

c0d036d0 <_getMethod_ModuleName_V1>:
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

const char* _getMethod_ModuleName_V1(uint8_t moduleIdx)
{
    switch (moduleIdx) {
c0d036d0:	2807      	cmp	r0, #7
c0d036d2:	dc06      	bgt.n	c0d036e2 <_getMethod_ModuleName_V1+0x12>
c0d036d4:	2802      	cmp	r0, #2
c0d036d6:	d00d      	beq.n	c0d036f4 <_getMethod_ModuleName_V1+0x24>
c0d036d8:	2803      	cmp	r0, #3
c0d036da:	d109      	bne.n	c0d036f0 <_getMethod_ModuleName_V1+0x20>
c0d036dc:	480a      	ldr	r0, [pc, #40]	; (c0d03708 <_getMethod_ModuleName_V1+0x38>)
c0d036de:	4478      	add	r0, pc
    default:
        return NULL;
    }

    return NULL;
}
c0d036e0:	4770      	bx	lr
    switch (moduleIdx) {
c0d036e2:	2808      	cmp	r0, #8
c0d036e4:	d009      	beq.n	c0d036fa <_getMethod_ModuleName_V1+0x2a>
c0d036e6:	281f      	cmp	r0, #31
c0d036e8:	d102      	bne.n	c0d036f0 <_getMethod_ModuleName_V1+0x20>
c0d036ea:	4806      	ldr	r0, [pc, #24]	; (c0d03704 <_getMethod_ModuleName_V1+0x34>)
c0d036ec:	4478      	add	r0, pc
}
c0d036ee:	4770      	bx	lr
c0d036f0:	2000      	movs	r0, #0
c0d036f2:	4770      	bx	lr
c0d036f4:	4802      	ldr	r0, [pc, #8]	; (c0d03700 <_getMethod_ModuleName_V1+0x30>)
c0d036f6:	4478      	add	r0, pc
c0d036f8:	4770      	bx	lr
c0d036fa:	4804      	ldr	r0, [pc, #16]	; (c0d0370c <_getMethod_ModuleName_V1+0x3c>)
c0d036fc:	4478      	add	r0, pc
c0d036fe:	4770      	bx	lr
c0d03700:	000044e2 	.word	0x000044e2
c0d03704:	000044f5 	.word	0x000044f5
c0d03708:	0000450b 	.word	0x0000450b
c0d0370c:	000044f5 	.word	0x000044f5

c0d03710 <_getMethod_Name_V1>:

const char* _getMethod_Name_V1(uint8_t moduleIdx, uint8_t callIdx)
{
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;
c0d03710:	0200      	lsls	r0, r0, #8
c0d03712:	1840      	adds	r0, r0, r1
c0d03714:	493b      	ldr	r1, [pc, #236]	; (c0d03804 <_getMethod_Name_V1+0xf4>)

    switch (callPrivIdx) {
c0d03716:	4288      	cmp	r0, r1
c0d03718:	dc0f      	bgt.n	c0d0373a <_getMethod_Name_V1+0x2a>
c0d0371a:	4a44      	ldr	r2, [pc, #272]	; (c0d0382c <_getMethod_Name_V1+0x11c>)
c0d0371c:	4290      	cmp	r0, r2
c0d0371e:	dc1a      	bgt.n	c0d03756 <_getMethod_Name_V1+0x46>
c0d03720:	4945      	ldr	r1, [pc, #276]	; (c0d03838 <_getMethod_Name_V1+0x128>)
c0d03722:	4288      	cmp	r0, r1
c0d03724:	dc30      	bgt.n	c0d03788 <_getMethod_Name_V1+0x78>
c0d03726:	2101      	movs	r1, #1
c0d03728:	0249      	lsls	r1, r1, #9
c0d0372a:	4288      	cmp	r0, r1
c0d0372c:	d050      	beq.n	c0d037d0 <_getMethod_Name_V1+0xc0>
c0d0372e:	4944      	ldr	r1, [pc, #272]	; (c0d03840 <_getMethod_Name_V1+0x130>)
c0d03730:	4288      	cmp	r0, r1
c0d03732:	d165      	bne.n	c0d03800 <_getMethod_Name_V1+0xf0>
c0d03734:	484b      	ldr	r0, [pc, #300]	; (c0d03864 <_getMethod_Name_V1+0x154>)
c0d03736:	4478      	add	r0, pc
    default:
        return NULL;
    }

    return NULL;
}
c0d03738:	4770      	bx	lr
c0d0373a:	4933      	ldr	r1, [pc, #204]	; (c0d03808 <_getMethod_Name_V1+0xf8>)
    switch (callPrivIdx) {
c0d0373c:	4288      	cmp	r0, r1
c0d0373e:	dc17      	bgt.n	c0d03770 <_getMethod_Name_V1+0x60>
c0d03740:	4a37      	ldr	r2, [pc, #220]	; (c0d03820 <_getMethod_Name_V1+0x110>)
c0d03742:	4290      	cmp	r0, r2
c0d03744:	dc2a      	bgt.n	c0d0379c <_getMethod_Name_V1+0x8c>
c0d03746:	4938      	ldr	r1, [pc, #224]	; (c0d03828 <_getMethod_Name_V1+0x118>)
c0d03748:	4288      	cmp	r0, r1
c0d0374a:	d044      	beq.n	c0d037d6 <_getMethod_Name_V1+0xc6>
c0d0374c:	4290      	cmp	r0, r2
c0d0374e:	d157      	bne.n	c0d03800 <_getMethod_Name_V1+0xf0>
c0d03750:	4840      	ldr	r0, [pc, #256]	; (c0d03854 <_getMethod_Name_V1+0x144>)
c0d03752:	4478      	add	r0, pc
}
c0d03754:	4770      	bx	lr
c0d03756:	4a36      	ldr	r2, [pc, #216]	; (c0d03830 <_getMethod_Name_V1+0x120>)
    switch (callPrivIdx) {
c0d03758:	4290      	cmp	r0, r2
c0d0375a:	dc27      	bgt.n	c0d037ac <_getMethod_Name_V1+0x9c>
c0d0375c:	2101      	movs	r1, #1
c0d0375e:	02c9      	lsls	r1, r1, #11
c0d03760:	4288      	cmp	r0, r1
c0d03762:	d03b      	beq.n	c0d037dc <_getMethod_Name_V1+0xcc>
c0d03764:	4933      	ldr	r1, [pc, #204]	; (c0d03834 <_getMethod_Name_V1+0x124>)
c0d03766:	4288      	cmp	r0, r1
c0d03768:	d14a      	bne.n	c0d03800 <_getMethod_Name_V1+0xf0>
c0d0376a:	4838      	ldr	r0, [pc, #224]	; (c0d0384c <_getMethod_Name_V1+0x13c>)
c0d0376c:	4478      	add	r0, pc
}
c0d0376e:	4770      	bx	lr
c0d03770:	4926      	ldr	r1, [pc, #152]	; (c0d0380c <_getMethod_Name_V1+0xfc>)
    switch (callPrivIdx) {
c0d03772:	4288      	cmp	r0, r1
c0d03774:	dc23      	bgt.n	c0d037be <_getMethod_Name_V1+0xae>
c0d03776:	4928      	ldr	r1, [pc, #160]	; (c0d03818 <_getMethod_Name_V1+0x108>)
c0d03778:	4288      	cmp	r0, r1
c0d0377a:	d032      	beq.n	c0d037e2 <_getMethod_Name_V1+0xd2>
c0d0377c:	4927      	ldr	r1, [pc, #156]	; (c0d0381c <_getMethod_Name_V1+0x10c>)
c0d0377e:	4288      	cmp	r0, r1
c0d03780:	d13e      	bne.n	c0d03800 <_getMethod_Name_V1+0xf0>
c0d03782:	4836      	ldr	r0, [pc, #216]	; (c0d0385c <_getMethod_Name_V1+0x14c>)
c0d03784:	4478      	add	r0, pc
}
c0d03786:	4770      	bx	lr
c0d03788:	2103      	movs	r1, #3
c0d0378a:	0209      	lsls	r1, r1, #8
    switch (callPrivIdx) {
c0d0378c:	4288      	cmp	r0, r1
c0d0378e:	d02b      	beq.n	c0d037e8 <_getMethod_Name_V1+0xd8>
c0d03790:	492a      	ldr	r1, [pc, #168]	; (c0d0383c <_getMethod_Name_V1+0x12c>)
c0d03792:	4288      	cmp	r0, r1
c0d03794:	d134      	bne.n	c0d03800 <_getMethod_Name_V1+0xf0>
c0d03796:	482c      	ldr	r0, [pc, #176]	; (c0d03848 <_getMethod_Name_V1+0x138>)
c0d03798:	4478      	add	r0, pc
}
c0d0379a:	4770      	bx	lr
c0d0379c:	4a21      	ldr	r2, [pc, #132]	; (c0d03824 <_getMethod_Name_V1+0x114>)
    switch (callPrivIdx) {
c0d0379e:	4290      	cmp	r0, r2
c0d037a0:	d025      	beq.n	c0d037ee <_getMethod_Name_V1+0xde>
c0d037a2:	4288      	cmp	r0, r1
c0d037a4:	d12c      	bne.n	c0d03800 <_getMethod_Name_V1+0xf0>
c0d037a6:	482c      	ldr	r0, [pc, #176]	; (c0d03858 <_getMethod_Name_V1+0x148>)
c0d037a8:	4478      	add	r0, pc
}
c0d037aa:	4770      	bx	lr
c0d037ac:	221f      	movs	r2, #31
c0d037ae:	0212      	lsls	r2, r2, #8
    switch (callPrivIdx) {
c0d037b0:	4290      	cmp	r0, r2
c0d037b2:	d01f      	beq.n	c0d037f4 <_getMethod_Name_V1+0xe4>
c0d037b4:	4288      	cmp	r0, r1
c0d037b6:	d123      	bne.n	c0d03800 <_getMethod_Name_V1+0xf0>
c0d037b8:	4825      	ldr	r0, [pc, #148]	; (c0d03850 <_getMethod_Name_V1+0x140>)
c0d037ba:	4478      	add	r0, pc
}
c0d037bc:	4770      	bx	lr
c0d037be:	4914      	ldr	r1, [pc, #80]	; (c0d03810 <_getMethod_Name_V1+0x100>)
    switch (callPrivIdx) {
c0d037c0:	4288      	cmp	r0, r1
c0d037c2:	d01a      	beq.n	c0d037fa <_getMethod_Name_V1+0xea>
c0d037c4:	4913      	ldr	r1, [pc, #76]	; (c0d03814 <_getMethod_Name_V1+0x104>)
c0d037c6:	4288      	cmp	r0, r1
c0d037c8:	d11a      	bne.n	c0d03800 <_getMethod_Name_V1+0xf0>
c0d037ca:	4825      	ldr	r0, [pc, #148]	; (c0d03860 <_getMethod_Name_V1+0x150>)
c0d037cc:	4478      	add	r0, pc
}
c0d037ce:	4770      	bx	lr
c0d037d0:	481c      	ldr	r0, [pc, #112]	; (c0d03844 <_getMethod_Name_V1+0x134>)
c0d037d2:	4478      	add	r0, pc
c0d037d4:	4770      	bx	lr
c0d037d6:	4825      	ldr	r0, [pc, #148]	; (c0d0386c <_getMethod_Name_V1+0x15c>)
c0d037d8:	4478      	add	r0, pc
c0d037da:	4770      	bx	lr
c0d037dc:	4828      	ldr	r0, [pc, #160]	; (c0d03880 <_getMethod_Name_V1+0x170>)
c0d037de:	4478      	add	r0, pc
c0d037e0:	4770      	bx	lr
c0d037e2:	4824      	ldr	r0, [pc, #144]	; (c0d03874 <_getMethod_Name_V1+0x164>)
c0d037e4:	4478      	add	r0, pc
c0d037e6:	4770      	bx	lr
c0d037e8:	4824      	ldr	r0, [pc, #144]	; (c0d0387c <_getMethod_Name_V1+0x16c>)
c0d037ea:	4478      	add	r0, pc
c0d037ec:	4770      	bx	lr
c0d037ee:	4820      	ldr	r0, [pc, #128]	; (c0d03870 <_getMethod_Name_V1+0x160>)
c0d037f0:	4478      	add	r0, pc
c0d037f2:	4770      	bx	lr
c0d037f4:	481c      	ldr	r0, [pc, #112]	; (c0d03868 <_getMethod_Name_V1+0x158>)
c0d037f6:	4478      	add	r0, pc
c0d037f8:	4770      	bx	lr
c0d037fa:	481f      	ldr	r0, [pc, #124]	; (c0d03878 <_getMethod_Name_V1+0x168>)
c0d037fc:	4478      	add	r0, pc
c0d037fe:	4770      	bx	lr
c0d03800:	2000      	movs	r0, #0
c0d03802:	4770      	bx	lr
c0d03804:	00001f01 	.word	0x00001f01
c0d03808:	00001f05 	.word	0x00001f05
c0d0380c:	00001f11 	.word	0x00001f11
c0d03810:	00001f12 	.word	0x00001f12
c0d03814:	00001f13 	.word	0x00001f13
c0d03818:	00001f06 	.word	0x00001f06
c0d0381c:	00001f07 	.word	0x00001f07
c0d03820:	00001f03 	.word	0x00001f03
c0d03824:	00001f04 	.word	0x00001f04
c0d03828:	00001f02 	.word	0x00001f02
c0d0382c:	000007ff 	.word	0x000007ff
c0d03830:	00001eff 	.word	0x00001eff
c0d03834:	00000802 	.word	0x00000802
c0d03838:	000002ff 	.word	0x000002ff
c0d0383c:	00000301 	.word	0x00000301
c0d03840:	00000203 	.word	0x00000203
c0d03844:	00004588 	.word	0x00004588
c0d03848:	000044df 	.word	0x000044df
c0d0384c:	0000451c 	.word	0x0000451c
c0d03850:	00004458 	.word	0x00004458
c0d03854:	000044d2 	.word	0x000044d2
c0d03858:	00004497 	.word	0x00004497
c0d0385c:	000044ca 	.word	0x000044ca
c0d03860:	0000449b 	.word	0x0000449b
c0d03864:	000044c3 	.word	0x000044c3
c0d03868:	00004417 	.word	0x00004417
c0d0386c:	00004445 	.word	0x00004445
c0d03870:	00004446 	.word	0x00004446
c0d03874:	00004464 	.word	0x00004464
c0d03878:	0000445c 	.word	0x0000445c
c0d0387c:	00004484 	.word	0x00004484
c0d03880:	000044a4 	.word	0x000044a4

c0d03884 <_getMethod_NumItems_V1>:

// For number of arguments of extrinsic (exclude `origin`).
parser_error_t _getMethod_NumItems_V1(uint8_t moduleIdx, uint8_t callIdx, uint8_t* numItems)
{
c0d03884:	b5b0      	push	{r4, r5, r7, lr}
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;
c0d03886:	0200      	lsls	r0, r0, #8
c0d03888:	1843      	adds	r3, r0, r1
c0d0388a:	2102      	movs	r1, #2
c0d0388c:	2010      	movs	r0, #16
c0d0388e:	4c26      	ldr	r4, [pc, #152]	; (c0d03928 <_getMethod_NumItems_V1+0xa4>)

    switch (callPrivIdx) {
c0d03890:	42a3      	cmp	r3, r4
c0d03892:	dc0b      	bgt.n	c0d038ac <_getMethod_NumItems_V1+0x28>
c0d03894:	4d2e      	ldr	r5, [pc, #184]	; (c0d03950 <_getMethod_NumItems_V1+0xcc>)
c0d03896:	42ab      	cmp	r3, r5
c0d03898:	dc12      	bgt.n	c0d038c0 <_getMethod_NumItems_V1+0x3c>
c0d0389a:	4c30      	ldr	r4, [pc, #192]	; (c0d0395c <_getMethod_NumItems_V1+0xd8>)
c0d0389c:	42a3      	cmp	r3, r4
c0d0389e:	dc22      	bgt.n	c0d038e6 <_getMethod_NumItems_V1+0x62>
c0d038a0:	2401      	movs	r4, #1
c0d038a2:	0264      	lsls	r4, r4, #9
c0d038a4:	42a3      	cmp	r3, r4
c0d038a6:	d039      	beq.n	c0d0391c <_getMethod_NumItems_V1+0x98>
c0d038a8:	4c2e      	ldr	r4, [pc, #184]	; (c0d03964 <_getMethod_NumItems_V1+0xe0>)
c0d038aa:	e011      	b.n	c0d038d0 <_getMethod_NumItems_V1+0x4c>
c0d038ac:	4c1f      	ldr	r4, [pc, #124]	; (c0d0392c <_getMethod_NumItems_V1+0xa8>)
c0d038ae:	42a3      	cmp	r3, r4
c0d038b0:	dc11      	bgt.n	c0d038d6 <_getMethod_NumItems_V1+0x52>
c0d038b2:	4924      	ldr	r1, [pc, #144]	; (c0d03944 <_getMethod_NumItems_V1+0xc0>)
c0d038b4:	428b      	cmp	r3, r1
c0d038b6:	dc1f      	bgt.n	c0d038f8 <_getMethod_NumItems_V1+0x74>
c0d038b8:	4c24      	ldr	r4, [pc, #144]	; (c0d0394c <_getMethod_NumItems_V1+0xc8>)
c0d038ba:	42a3      	cmp	r3, r4
c0d038bc:	d12b      	bne.n	c0d03916 <_getMethod_NumItems_V1+0x92>
c0d038be:	e02c      	b.n	c0d0391a <_getMethod_NumItems_V1+0x96>
c0d038c0:	4924      	ldr	r1, [pc, #144]	; (c0d03954 <_getMethod_NumItems_V1+0xd0>)
c0d038c2:	428b      	cmp	r3, r1
c0d038c4:	dc1c      	bgt.n	c0d03900 <_getMethod_NumItems_V1+0x7c>
c0d038c6:	2101      	movs	r1, #1
c0d038c8:	02cc      	lsls	r4, r1, #11
c0d038ca:	42a3      	cmp	r3, r4
c0d038cc:	d026      	beq.n	c0d0391c <_getMethod_NumItems_V1+0x98>
c0d038ce:	4c22      	ldr	r4, [pc, #136]	; (c0d03958 <_getMethod_NumItems_V1+0xd4>)
c0d038d0:	42a3      	cmp	r3, r4
c0d038d2:	d023      	beq.n	c0d0391c <_getMethod_NumItems_V1+0x98>
c0d038d4:	e024      	b.n	c0d03920 <_getMethod_NumItems_V1+0x9c>
c0d038d6:	4c16      	ldr	r4, [pc, #88]	; (c0d03930 <_getMethod_NumItems_V1+0xac>)
c0d038d8:	42a3      	cmp	r3, r4
c0d038da:	dc18      	bgt.n	c0d0390e <_getMethod_NumItems_V1+0x8a>
c0d038dc:	4917      	ldr	r1, [pc, #92]	; (c0d0393c <_getMethod_NumItems_V1+0xb8>)
c0d038de:	428b      	cmp	r3, r1
c0d038e0:	d008      	beq.n	c0d038f4 <_getMethod_NumItems_V1+0x70>
c0d038e2:	4917      	ldr	r1, [pc, #92]	; (c0d03940 <_getMethod_NumItems_V1+0xbc>)
c0d038e4:	e017      	b.n	c0d03916 <_getMethod_NumItems_V1+0x92>
c0d038e6:	2403      	movs	r4, #3
c0d038e8:	0224      	lsls	r4, r4, #8
c0d038ea:	42a3      	cmp	r3, r4
c0d038ec:	d016      	beq.n	c0d0391c <_getMethod_NumItems_V1+0x98>
c0d038ee:	491c      	ldr	r1, [pc, #112]	; (c0d03960 <_getMethod_NumItems_V1+0xdc>)
c0d038f0:	428b      	cmp	r3, r1
c0d038f2:	d115      	bne.n	c0d03920 <_getMethod_NumItems_V1+0x9c>
c0d038f4:	2100      	movs	r1, #0
c0d038f6:	e011      	b.n	c0d0391c <_getMethod_NumItems_V1+0x98>
c0d038f8:	4913      	ldr	r1, [pc, #76]	; (c0d03948 <_getMethod_NumItems_V1+0xc4>)
c0d038fa:	428b      	cmp	r3, r1
c0d038fc:	d104      	bne.n	c0d03908 <_getMethod_NumItems_V1+0x84>
c0d038fe:	e00c      	b.n	c0d0391a <_getMethod_NumItems_V1+0x96>
c0d03900:	211f      	movs	r1, #31
c0d03902:	0209      	lsls	r1, r1, #8
c0d03904:	428b      	cmp	r3, r1
c0d03906:	d00c      	beq.n	c0d03922 <_getMethod_NumItems_V1+0x9e>
c0d03908:	42a3      	cmp	r3, r4
c0d0390a:	d006      	beq.n	c0d0391a <_getMethod_NumItems_V1+0x96>
c0d0390c:	e008      	b.n	c0d03920 <_getMethod_NumItems_V1+0x9c>
c0d0390e:	4c09      	ldr	r4, [pc, #36]	; (c0d03934 <_getMethod_NumItems_V1+0xb0>)
c0d03910:	42a3      	cmp	r3, r4
c0d03912:	d003      	beq.n	c0d0391c <_getMethod_NumItems_V1+0x98>
c0d03914:	4908      	ldr	r1, [pc, #32]	; (c0d03938 <_getMethod_NumItems_V1+0xb4>)
c0d03916:	428b      	cmp	r3, r1
c0d03918:	d102      	bne.n	c0d03920 <_getMethod_NumItems_V1+0x9c>
c0d0391a:	2101      	movs	r1, #1
c0d0391c:	7011      	strb	r1, [r2, #0]
c0d0391e:	2000      	movs	r0, #0
    default:
        return parser_unexpected_callIndex;
    }

    return parser_ok;
}
c0d03920:	bdb0      	pop	{r4, r5, r7, pc}
c0d03922:	2103      	movs	r1, #3
c0d03924:	e7fa      	b.n	c0d0391c <_getMethod_NumItems_V1+0x98>
c0d03926:	46c0      	nop			; (mov r8, r8)
c0d03928:	00001f01 	.word	0x00001f01
c0d0392c:	00001f05 	.word	0x00001f05
c0d03930:	00001f11 	.word	0x00001f11
c0d03934:	00001f12 	.word	0x00001f12
c0d03938:	00001f13 	.word	0x00001f13
c0d0393c:	00001f06 	.word	0x00001f06
c0d03940:	00001f07 	.word	0x00001f07
c0d03944:	00001f03 	.word	0x00001f03
c0d03948:	00001f04 	.word	0x00001f04
c0d0394c:	00001f02 	.word	0x00001f02
c0d03950:	000007ff 	.word	0x000007ff
c0d03954:	00001eff 	.word	0x00001eff
c0d03958:	00000802 	.word	0x00000802
c0d0395c:	000002ff 	.word	0x000002ff
c0d03960:	00000301 	.word	0x00000301
c0d03964:	00000203 	.word	0x00000203

c0d03968 <_getMethod_ItemName_V1>:

// Return argument names of extrinsics given module index, extrinsic index and argument index
const char* _getMethod_ItemName_V1(uint8_t moduleIdx, uint8_t callIdx, uint8_t itemIdx)
{
c0d03968:	b510      	push	{r4, lr}
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;
c0d0396a:	0200      	lsls	r0, r0, #8
c0d0396c:	1841      	adds	r1, r0, r1
c0d0396e:	2000      	movs	r0, #0
c0d03970:	4b41      	ldr	r3, [pc, #260]	; (c0d03a78 <_getMethod_ItemName_V1+0x110>)

    switch (callPrivIdx) {
c0d03972:	4299      	cmp	r1, r3
c0d03974:	dc11      	bgt.n	c0d0399a <_getMethod_ItemName_V1+0x32>
c0d03976:	4c49      	ldr	r4, [pc, #292]	; (c0d03a9c <_getMethod_ItemName_V1+0x134>)
c0d03978:	42a1      	cmp	r1, r4
c0d0397a:	dd1d      	ble.n	c0d039b8 <_getMethod_ItemName_V1+0x50>
c0d0397c:	4c48      	ldr	r4, [pc, #288]	; (c0d03aa0 <_getMethod_ItemName_V1+0x138>)
c0d0397e:	42a1      	cmp	r1, r4
c0d03980:	dc39      	bgt.n	c0d039f6 <_getMethod_ItemName_V1+0x8e>
c0d03982:	2301      	movs	r3, #1
c0d03984:	02db      	lsls	r3, r3, #11
c0d03986:	4299      	cmp	r1, r3
c0d03988:	d002      	beq.n	c0d03990 <_getMethod_ItemName_V1+0x28>
c0d0398a:	4b46      	ldr	r3, [pc, #280]	; (c0d03aa4 <_getMethod_ItemName_V1+0x13c>)
c0d0398c:	4299      	cmp	r1, r3
c0d0398e:	d103      	bne.n	c0d03998 <_getMethod_ItemName_V1+0x30>
c0d03990:	2a00      	cmp	r2, #0
c0d03992:	d150      	bne.n	c0d03a36 <_getMethod_ItemName_V1+0xce>
c0d03994:	4851      	ldr	r0, [pc, #324]	; (c0d03adc <_getMethod_ItemName_V1+0x174>)
c0d03996:	4478      	add	r0, pc
    default:
        return NULL;
    }

    return NULL;
}
c0d03998:	bd10      	pop	{r4, pc}
c0d0399a:	4b38      	ldr	r3, [pc, #224]	; (c0d03a7c <_getMethod_ItemName_V1+0x114>)
    switch (callPrivIdx) {
c0d0399c:	4299      	cmp	r1, r3
c0d0399e:	dd1d      	ble.n	c0d039dc <_getMethod_ItemName_V1+0x74>
c0d039a0:	4b37      	ldr	r3, [pc, #220]	; (c0d03a80 <_getMethod_ItemName_V1+0x118>)
c0d039a2:	4299      	cmp	r1, r3
c0d039a4:	dc32      	bgt.n	c0d03a0c <_getMethod_ItemName_V1+0xa4>
c0d039a6:	4b39      	ldr	r3, [pc, #228]	; (c0d03a8c <_getMethod_ItemName_V1+0x124>)
c0d039a8:	4299      	cmp	r1, r3
c0d039aa:	d03d      	beq.n	c0d03a28 <_getMethod_ItemName_V1+0xc0>
c0d039ac:	4b38      	ldr	r3, [pc, #224]	; (c0d03a90 <_getMethod_ItemName_V1+0x128>)
c0d039ae:	4299      	cmp	r1, r3
c0d039b0:	d1f2      	bne.n	c0d03998 <_getMethod_ItemName_V1+0x30>
        switch (itemIdx) {
c0d039b2:	2a00      	cmp	r2, #0
c0d039b4:	d13f      	bne.n	c0d03a36 <_getMethod_ItemName_V1+0xce>
c0d039b6:	e050      	b.n	c0d03a5a <_getMethod_ItemName_V1+0xf2>
c0d039b8:	2301      	movs	r3, #1
c0d039ba:	025b      	lsls	r3, r3, #9
    switch (callPrivIdx) {
c0d039bc:	4299      	cmp	r1, r3
c0d039be:	d02e      	beq.n	c0d03a1e <_getMethod_ItemName_V1+0xb6>
c0d039c0:	4b39      	ldr	r3, [pc, #228]	; (c0d03aa8 <_getMethod_ItemName_V1+0x140>)
c0d039c2:	4299      	cmp	r1, r3
c0d039c4:	d02b      	beq.n	c0d03a1e <_getMethod_ItemName_V1+0xb6>
c0d039c6:	2303      	movs	r3, #3
c0d039c8:	021b      	lsls	r3, r3, #8
c0d039ca:	4299      	cmp	r1, r3
c0d039cc:	d1e4      	bne.n	c0d03998 <_getMethod_ItemName_V1+0x30>
        switch (itemIdx) {
c0d039ce:	2a00      	cmp	r2, #0
c0d039d0:	d049      	beq.n	c0d03a66 <_getMethod_ItemName_V1+0xfe>
c0d039d2:	2a01      	cmp	r2, #1
c0d039d4:	d1e0      	bne.n	c0d03998 <_getMethod_ItemName_V1+0x30>
c0d039d6:	4840      	ldr	r0, [pc, #256]	; (c0d03ad8 <_getMethod_ItemName_V1+0x170>)
c0d039d8:	4478      	add	r0, pc
}
c0d039da:	bd10      	pop	{r4, pc}
c0d039dc:	4c2d      	ldr	r4, [pc, #180]	; (c0d03a94 <_getMethod_ItemName_V1+0x12c>)
    switch (callPrivIdx) {
c0d039de:	42a1      	cmp	r1, r4
c0d039e0:	d01a      	beq.n	c0d03a18 <_getMethod_ItemName_V1+0xb0>
c0d039e2:	4c2d      	ldr	r4, [pc, #180]	; (c0d03a98 <_getMethod_ItemName_V1+0x130>)
c0d039e4:	42a1      	cmp	r1, r4
c0d039e6:	d024      	beq.n	c0d03a32 <_getMethod_ItemName_V1+0xca>
c0d039e8:	4299      	cmp	r1, r3
c0d039ea:	d1d5      	bne.n	c0d03998 <_getMethod_ItemName_V1+0x30>
        switch (itemIdx) {
c0d039ec:	2a00      	cmp	r2, #0
c0d039ee:	d122      	bne.n	c0d03a36 <_getMethod_ItemName_V1+0xce>
c0d039f0:	4830      	ldr	r0, [pc, #192]	; (c0d03ab4 <_getMethod_ItemName_V1+0x14c>)
c0d039f2:	4478      	add	r0, pc
}
c0d039f4:	bd10      	pop	{r4, pc}
c0d039f6:	241f      	movs	r4, #31
c0d039f8:	0224      	lsls	r4, r4, #8
    switch (callPrivIdx) {
c0d039fa:	42a1      	cmp	r1, r4
c0d039fc:	d01d      	beq.n	c0d03a3a <_getMethod_ItemName_V1+0xd2>
c0d039fe:	4299      	cmp	r1, r3
c0d03a00:	d1ca      	bne.n	c0d03998 <_getMethod_ItemName_V1+0x30>
        switch (itemIdx) {
c0d03a02:	2a00      	cmp	r2, #0
c0d03a04:	d117      	bne.n	c0d03a36 <_getMethod_ItemName_V1+0xce>
c0d03a06:	482a      	ldr	r0, [pc, #168]	; (c0d03ab0 <_getMethod_ItemName_V1+0x148>)
c0d03a08:	4478      	add	r0, pc
c0d03a0a:	bd10      	pop	{r4, pc}
c0d03a0c:	4b1d      	ldr	r3, [pc, #116]	; (c0d03a84 <_getMethod_ItemName_V1+0x11c>)
    switch (callPrivIdx) {
c0d03a0e:	4299      	cmp	r1, r3
c0d03a10:	d01c      	beq.n	c0d03a4c <_getMethod_ItemName_V1+0xe4>
c0d03a12:	4b1d      	ldr	r3, [pc, #116]	; (c0d03a88 <_getMethod_ItemName_V1+0x120>)
c0d03a14:	4299      	cmp	r1, r3
c0d03a16:	d1bf      	bne.n	c0d03998 <_getMethod_ItemName_V1+0x30>
c0d03a18:	2a00      	cmp	r2, #0
c0d03a1a:	d10c      	bne.n	c0d03a36 <_getMethod_ItemName_V1+0xce>
c0d03a1c:	e013      	b.n	c0d03a46 <_getMethod_ItemName_V1+0xde>
c0d03a1e:	2a00      	cmp	r2, #0
c0d03a20:	d10f      	bne.n	c0d03a42 <_getMethod_ItemName_V1+0xda>
c0d03a22:	4825      	ldr	r0, [pc, #148]	; (c0d03ab8 <_getMethod_ItemName_V1+0x150>)
c0d03a24:	4478      	add	r0, pc
}
c0d03a26:	bd10      	pop	{r4, pc}
        switch (itemIdx) {
c0d03a28:	2a00      	cmp	r2, #0
c0d03a2a:	d104      	bne.n	c0d03a36 <_getMethod_ItemName_V1+0xce>
c0d03a2c:	4827      	ldr	r0, [pc, #156]	; (c0d03acc <_getMethod_ItemName_V1+0x164>)
c0d03a2e:	4478      	add	r0, pc
}
c0d03a30:	bd10      	pop	{r4, pc}
        switch (itemIdx) {
c0d03a32:	2a00      	cmp	r2, #0
c0d03a34:	d014      	beq.n	c0d03a60 <_getMethod_ItemName_V1+0xf8>
c0d03a36:	2000      	movs	r0, #0
c0d03a38:	bd10      	pop	{r4, pc}
        switch (itemIdx) {
c0d03a3a:	2a00      	cmp	r2, #0
c0d03a3c:	d019      	beq.n	c0d03a72 <_getMethod_ItemName_V1+0x10a>
c0d03a3e:	2a02      	cmp	r2, #2
c0d03a40:	d00b      	beq.n	c0d03a5a <_getMethod_ItemName_V1+0xf2>
c0d03a42:	2a01      	cmp	r2, #1
c0d03a44:	d1a8      	bne.n	c0d03998 <_getMethod_ItemName_V1+0x30>
c0d03a46:	481d      	ldr	r0, [pc, #116]	; (c0d03abc <_getMethod_ItemName_V1+0x154>)
c0d03a48:	4478      	add	r0, pc
}
c0d03a4a:	bd10      	pop	{r4, pc}
        switch (itemIdx) {
c0d03a4c:	2a00      	cmp	r2, #0
c0d03a4e:	d00d      	beq.n	c0d03a6c <_getMethod_ItemName_V1+0x104>
c0d03a50:	2a01      	cmp	r2, #1
c0d03a52:	d1a1      	bne.n	c0d03998 <_getMethod_ItemName_V1+0x30>
c0d03a54:	481f      	ldr	r0, [pc, #124]	; (c0d03ad4 <_getMethod_ItemName_V1+0x16c>)
c0d03a56:	4478      	add	r0, pc
}
c0d03a58:	bd10      	pop	{r4, pc}
c0d03a5a:	481a      	ldr	r0, [pc, #104]	; (c0d03ac4 <_getMethod_ItemName_V1+0x15c>)
c0d03a5c:	4478      	add	r0, pc
c0d03a5e:	bd10      	pop	{r4, pc}
c0d03a60:	4819      	ldr	r0, [pc, #100]	; (c0d03ac8 <_getMethod_ItemName_V1+0x160>)
c0d03a62:	4478      	add	r0, pc
c0d03a64:	bd10      	pop	{r4, pc}
c0d03a66:	4811      	ldr	r0, [pc, #68]	; (c0d03aac <_getMethod_ItemName_V1+0x144>)
c0d03a68:	4478      	add	r0, pc
c0d03a6a:	bd10      	pop	{r4, pc}
c0d03a6c:	4818      	ldr	r0, [pc, #96]	; (c0d03ad0 <_getMethod_ItemName_V1+0x168>)
c0d03a6e:	4478      	add	r0, pc
c0d03a70:	bd10      	pop	{r4, pc}
c0d03a72:	4813      	ldr	r0, [pc, #76]	; (c0d03ac0 <_getMethod_ItemName_V1+0x158>)
c0d03a74:	4478      	add	r0, pc
c0d03a76:	bd10      	pop	{r4, pc}
c0d03a78:	00001f01 	.word	0x00001f01
c0d03a7c:	00001f04 	.word	0x00001f04
c0d03a80:	00001f11 	.word	0x00001f11
c0d03a84:	00001f12 	.word	0x00001f12
c0d03a88:	00001f13 	.word	0x00001f13
c0d03a8c:	00001f05 	.word	0x00001f05
c0d03a90:	00001f07 	.word	0x00001f07
c0d03a94:	00001f02 	.word	0x00001f02
c0d03a98:	00001f03 	.word	0x00001f03
c0d03a9c:	000007ff 	.word	0x000007ff
c0d03aa0:	00001eff 	.word	0x00001eff
c0d03aa4:	00000802 	.word	0x00000802
c0d03aa8:	00000203 	.word	0x00000203
c0d03aac:	0000427c 	.word	0x0000427c
c0d03ab0:	0000428f 	.word	0x0000428f
c0d03ab4:	000042d0 	.word	0x000042d0
c0d03ab8:	0000426e 	.word	0x0000426e
c0d03abc:	0000424f 	.word	0x0000424f
c0d03ac0:	0000422a 	.word	0x0000422a
c0d03ac4:	0000424d 	.word	0x0000424d
c0d03ac8:	0000424d 	.word	0x0000424d
c0d03acc:	0000429a 	.word	0x0000429a
c0d03ad0:	00004262 	.word	0x00004262
c0d03ad4:	0000428a 	.word	0x0000428a
c0d03ad8:	00004311 	.word	0x00004311
c0d03adc:	00004359 	.word	0x00004359

c0d03ae0 <_getMethod_ItemValue_V1>:
parser_error_t _getMethod_ItemValue_V1(
    pd_Method_V1_t* m,
    uint8_t moduleIdx, uint8_t callIdx, uint8_t itemIdx,
    char* outValue, uint16_t outValueLen,
    uint8_t pageIdx, uint8_t* pageCount)
{
c0d03ae0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03ae2:	b083      	sub	sp, #12
c0d03ae4:	461d      	mov	r5, r3
c0d03ae6:	4604      	mov	r4, r0
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;
c0d03ae8:	0208      	lsls	r0, r1, #8
c0d03aea:	1887      	adds	r7, r0, r2
c0d03aec:	2001      	movs	r0, #1
c0d03aee:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d03af0:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d03af2:	9102      	str	r1, [sp, #8]
c0d03af4:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d03af6:	9101      	str	r1, [sp, #4]
c0d03af8:	9908      	ldr	r1, [sp, #32]
c0d03afa:	4e62      	ldr	r6, [pc, #392]	; (c0d03c84 <_getMethod_ItemValue_V1+0x1a4>)

    switch (callPrivIdx) {
c0d03afc:	42b7      	cmp	r7, r6
c0d03afe:	dc17      	bgt.n	c0d03b30 <_getMethod_ItemValue_V1+0x50>
c0d03b00:	4b6a      	ldr	r3, [pc, #424]	; (c0d03cac <_getMethod_ItemValue_V1+0x1cc>)
c0d03b02:	429f      	cmp	r7, r3
c0d03b04:	dc29      	bgt.n	c0d03b5a <_getMethod_ItemValue_V1+0x7a>
c0d03b06:	4b6c      	ldr	r3, [pc, #432]	; (c0d03cb8 <_getMethod_ItemValue_V1+0x1d8>)
c0d03b08:	429f      	cmp	r7, r3
c0d03b0a:	dc47      	bgt.n	c0d03b9c <_getMethod_ItemValue_V1+0xbc>
c0d03b0c:	2001      	movs	r0, #1
c0d03b0e:	0243      	lsls	r3, r0, #9
c0d03b10:	429f      	cmp	r7, r3
c0d03b12:	d002      	beq.n	c0d03b1a <_getMethod_ItemValue_V1+0x3a>
c0d03b14:	4b6a      	ldr	r3, [pc, #424]	; (c0d03cc0 <_getMethod_ItemValue_V1+0x1e0>)
c0d03b16:	429f      	cmp	r7, r3
c0d03b18:	d16b      	bne.n	c0d03bf2 <_getMethod_ItemValue_V1+0x112>
c0d03b1a:	2d01      	cmp	r5, #1
c0d03b1c:	d000      	beq.n	c0d03b20 <_getMethod_ItemValue_V1+0x40>
c0d03b1e:	e082      	b.n	c0d03c26 <_getMethod_ItemValue_V1+0x146>
c0d03b20:	9200      	str	r2, [sp, #0]
c0d03b22:	3418      	adds	r4, #24
c0d03b24:	4620      	mov	r0, r4
c0d03b26:	9a01      	ldr	r2, [sp, #4]
c0d03b28:	9b02      	ldr	r3, [sp, #8]
c0d03b2a:	f7ff fa9f 	bl	c0d0306c <_toStringCompactBalance>
c0d03b2e:	e0a7      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
c0d03b30:	4e55      	ldr	r6, [pc, #340]	; (c0d03c88 <_getMethod_ItemValue_V1+0x1a8>)
c0d03b32:	42b7      	cmp	r7, r6
c0d03b34:	dc25      	bgt.n	c0d03b82 <_getMethod_ItemValue_V1+0xa2>
c0d03b36:	4b5a      	ldr	r3, [pc, #360]	; (c0d03ca0 <_getMethod_ItemValue_V1+0x1c0>)
c0d03b38:	429f      	cmp	r7, r3
c0d03b3a:	dc37      	bgt.n	c0d03bac <_getMethod_ItemValue_V1+0xcc>
c0d03b3c:	4e5a      	ldr	r6, [pc, #360]	; (c0d03ca8 <_getMethod_ItemValue_V1+0x1c8>)
c0d03b3e:	42b7      	cmp	r7, r6
c0d03b40:	d048      	beq.n	c0d03bd4 <_getMethod_ItemValue_V1+0xf4>
c0d03b42:	429f      	cmp	r7, r3
c0d03b44:	d155      	bne.n	c0d03bf2 <_getMethod_ItemValue_V1+0x112>
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 7939: /* module 31 call 3 */
        switch (itemIdx) {
c0d03b46:	2d00      	cmp	r5, #0
c0d03b48:	d000      	beq.n	c0d03b4c <_getMethod_ItemValue_V1+0x6c>
c0d03b4a:	e099      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
        case 0: /* staking_withdraw_unbonded_V1 - num_slashing_spans */;
            return _toStringu32(
c0d03b4c:	9200      	str	r2, [sp, #0]
c0d03b4e:	4620      	mov	r0, r4
c0d03b50:	9a01      	ldr	r2, [sp, #4]
c0d03b52:	9b02      	ldr	r3, [sp, #8]
c0d03b54:	f000 faae 	bl	c0d040b4 <_toStringu32>
c0d03b58:	e092      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
c0d03b5a:	4b55      	ldr	r3, [pc, #340]	; (c0d03cb0 <_getMethod_ItemValue_V1+0x1d0>)
    switch (callPrivIdx) {
c0d03b5c:	429f      	cmp	r7, r3
c0d03b5e:	dc33      	bgt.n	c0d03bc8 <_getMethod_ItemValue_V1+0xe8>
c0d03b60:	2001      	movs	r0, #1
c0d03b62:	02c3      	lsls	r3, r0, #11
c0d03b64:	429f      	cmp	r7, r3
c0d03b66:	d002      	beq.n	c0d03b6e <_getMethod_ItemValue_V1+0x8e>
c0d03b68:	4b52      	ldr	r3, [pc, #328]	; (c0d03cb4 <_getMethod_ItemValue_V1+0x1d4>)
c0d03b6a:	429f      	cmp	r7, r3
c0d03b6c:	d141      	bne.n	c0d03bf2 <_getMethod_ItemValue_V1+0x112>
c0d03b6e:	2d00      	cmp	r5, #0
c0d03b70:	d000      	beq.n	c0d03b74 <_getMethod_ItemValue_V1+0x94>
c0d03b72:	e085      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
c0d03b74:	9200      	str	r2, [sp, #0]
c0d03b76:	4620      	mov	r0, r4
c0d03b78:	9a01      	ldr	r2, [sp, #4]
c0d03b7a:	9b02      	ldr	r3, [sp, #8]
c0d03b7c:	f000 fc4c 	bl	c0d04418 <_toStringVecCall>
c0d03b80:	e07e      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
c0d03b82:	4b42      	ldr	r3, [pc, #264]	; (c0d03c8c <_getMethod_ItemValue_V1+0x1ac>)
c0d03b84:	429f      	cmp	r7, r3
c0d03b86:	dc2e      	bgt.n	c0d03be6 <_getMethod_ItemValue_V1+0x106>
c0d03b88:	4b43      	ldr	r3, [pc, #268]	; (c0d03c98 <_getMethod_ItemValue_V1+0x1b8>)
c0d03b8a:	429f      	cmp	r7, r3
c0d03b8c:	d078      	beq.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
c0d03b8e:	4b43      	ldr	r3, [pc, #268]	; (c0d03c9c <_getMethod_ItemValue_V1+0x1bc>)
c0d03b90:	429f      	cmp	r7, r3
c0d03b92:	d12e      	bne.n	c0d03bf2 <_getMethod_ItemValue_V1+0x112>
        switch (itemIdx) {
        default:
            return parser_no_data;
        }
    case 7943: /* module 31 call 7 */
        switch (itemIdx) {
c0d03b94:	2d00      	cmp	r5, #0
c0d03b96:	d173      	bne.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
        case 0: /* staking_set_payee_V1 - payee */;
            return _toStringRewardDestination_V1(
c0d03b98:	9200      	str	r2, [sp, #0]
c0d03b9a:	e06c      	b.n	c0d03c76 <_getMethod_ItemValue_V1+0x196>
c0d03b9c:	2303      	movs	r3, #3
c0d03b9e:	021b      	lsls	r3, r3, #8
    switch (callPrivIdx) {
c0d03ba0:	429f      	cmp	r7, r3
c0d03ba2:	d028      	beq.n	c0d03bf6 <_getMethod_ItemValue_V1+0x116>
c0d03ba4:	4945      	ldr	r1, [pc, #276]	; (c0d03cbc <_getMethod_ItemValue_V1+0x1dc>)
c0d03ba6:	428f      	cmp	r7, r1
c0d03ba8:	d06a      	beq.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
c0d03baa:	e022      	b.n	c0d03bf2 <_getMethod_ItemValue_V1+0x112>
c0d03bac:	4b3d      	ldr	r3, [pc, #244]	; (c0d03ca4 <_getMethod_ItemValue_V1+0x1c4>)
c0d03bae:	429f      	cmp	r7, r3
c0d03bb0:	d02c      	beq.n	c0d03c0c <_getMethod_ItemValue_V1+0x12c>
c0d03bb2:	42b7      	cmp	r7, r6
c0d03bb4:	d11d      	bne.n	c0d03bf2 <_getMethod_ItemValue_V1+0x112>
        switch (itemIdx) {
c0d03bb6:	2d00      	cmp	r5, #0
c0d03bb8:	d162      	bne.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
            return _toStringVecLookupSource_V1(
c0d03bba:	9200      	str	r2, [sp, #0]
c0d03bbc:	4620      	mov	r0, r4
c0d03bbe:	9a01      	ldr	r2, [sp, #4]
c0d03bc0:	9b02      	ldr	r3, [sp, #8]
c0d03bc2:	f001 f815 	bl	c0d04bf0 <_toStringVecLookupSource_V1>
c0d03bc6:	e05b      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
c0d03bc8:	231f      	movs	r3, #31
c0d03bca:	021b      	lsls	r3, r3, #8
    switch (callPrivIdx) {
c0d03bcc:	429f      	cmp	r7, r3
c0d03bce:	d026      	beq.n	c0d03c1e <_getMethod_ItemValue_V1+0x13e>
c0d03bd0:	42b7      	cmp	r7, r6
c0d03bd2:	d10e      	bne.n	c0d03bf2 <_getMethod_ItemValue_V1+0x112>
c0d03bd4:	2d00      	cmp	r5, #0
c0d03bd6:	d153      	bne.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
c0d03bd8:	9200      	str	r2, [sp, #0]
c0d03bda:	4620      	mov	r0, r4
c0d03bdc:	9a01      	ldr	r2, [sp, #4]
c0d03bde:	9b02      	ldr	r3, [sp, #8]
c0d03be0:	f000 fcbc 	bl	c0d0455c <_toStringCompactBalanceOf>
c0d03be4:	e04c      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
c0d03be6:	4b2a      	ldr	r3, [pc, #168]	; (c0d03c90 <_getMethod_ItemValue_V1+0x1b0>)
c0d03be8:	429f      	cmp	r7, r3
c0d03bea:	d025      	beq.n	c0d03c38 <_getMethod_ItemValue_V1+0x158>
c0d03bec:	4b29      	ldr	r3, [pc, #164]	; (c0d03c94 <_getMethod_ItemValue_V1+0x1b4>)
c0d03bee:	429f      	cmp	r7, r3
c0d03bf0:	d0f0      	beq.n	c0d03bd4 <_getMethod_ItemValue_V1+0xf4>
c0d03bf2:	2000      	movs	r0, #0
c0d03bf4:	e044      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
                pageIdx, pageCount);
        default:
            return parser_no_data;
        }
    case 768: /* module 3 call 0 */
        switch (itemIdx) {
c0d03bf6:	2d01      	cmp	r5, #1
c0d03bf8:	d029      	beq.n	c0d03c4e <_getMethod_ItemValue_V1+0x16e>
c0d03bfa:	2d00      	cmp	r5, #0
c0d03bfc:	d140      	bne.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
        case 0: /* session_set_keys_V1 - keys */;
            return _toStringKeys_V1(
c0d03bfe:	9200      	str	r2, [sp, #0]
c0d03c00:	4620      	mov	r0, r4
c0d03c02:	9a01      	ldr	r2, [sp, #4]
c0d03c04:	9b02      	ldr	r3, [sp, #8]
c0d03c06:	f000 fe3b 	bl	c0d04880 <_toStringKeys_V1>
c0d03c0a:	e039      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
        switch (itemIdx) {
c0d03c0c:	2d00      	cmp	r5, #0
c0d03c0e:	d137      	bne.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
            return _toStringValidatorPrefs_V1(
c0d03c10:	9200      	str	r2, [sp, #0]
c0d03c12:	4620      	mov	r0, r4
c0d03c14:	9a01      	ldr	r2, [sp, #4]
c0d03c16:	9b02      	ldr	r3, [sp, #8]
c0d03c18:	f000 ff8c 	bl	c0d04b34 <_toStringValidatorPrefs_V1>
c0d03c1c:	e030      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
        switch (itemIdx) {
c0d03c1e:	2d02      	cmp	r5, #2
c0d03c20:	d027      	beq.n	c0d03c72 <_getMethod_ItemValue_V1+0x192>
c0d03c22:	2d01      	cmp	r5, #1
c0d03c24:	d022      	beq.n	c0d03c6c <_getMethod_ItemValue_V1+0x18c>
c0d03c26:	2d00      	cmp	r5, #0
c0d03c28:	d12a      	bne.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
c0d03c2a:	9200      	str	r2, [sp, #0]
c0d03c2c:	4620      	mov	r0, r4
c0d03c2e:	9a01      	ldr	r2, [sp, #4]
c0d03c30:	9b02      	ldr	r3, [sp, #8]
c0d03c32:	f000 fe7d 	bl	c0d04930 <_toStringLookupSource_V1>
c0d03c36:	e023      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
        switch (itemIdx) {
c0d03c38:	2d01      	cmp	r5, #1
c0d03c3a:	d010      	beq.n	c0d03c5e <_getMethod_ItemValue_V1+0x17e>
c0d03c3c:	2d00      	cmp	r5, #0
c0d03c3e:	d11f      	bne.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
            return _toStringAccountId_V1(
c0d03c40:	9200      	str	r2, [sp, #0]
c0d03c42:	4620      	mov	r0, r4
c0d03c44:	9a01      	ldr	r2, [sp, #4]
c0d03c46:	9b02      	ldr	r3, [sp, #8]
c0d03c48:	f000 fe09 	bl	c0d0485e <_toStringAccountId_V1>
c0d03c4c:	e018      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
                &m->basic.session_set_keys_V1.keys,
                outValue, outValueLen,
                pageIdx, pageCount);
        case 1: /* session_set_keys_V1 - proof */;
            return _toStringBytes(
c0d03c4e:	9200      	str	r2, [sp, #0]
                &m->basic.session_set_keys_V1.proof,
c0d03c50:	3408      	adds	r4, #8
            return _toStringBytes(
c0d03c52:	4620      	mov	r0, r4
c0d03c54:	9a01      	ldr	r2, [sp, #4]
c0d03c56:	9b02      	ldr	r3, [sp, #8]
c0d03c58:	f000 faae 	bl	c0d041b8 <_toStringBytes>
c0d03c5c:	e010      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
            return _toStringEraIndex_V1(
c0d03c5e:	9200      	str	r2, [sp, #0]
                &m->nested.staking_payout_stakers_V1.era,
c0d03c60:	1d20      	adds	r0, r4, #4
            return _toStringEraIndex_V1(
c0d03c62:	9a01      	ldr	r2, [sp, #4]
c0d03c64:	9b02      	ldr	r3, [sp, #8]
c0d03c66:	f000 fe03 	bl	c0d04870 <_toStringEraIndex_V1>
c0d03c6a:	e009      	b.n	c0d03c80 <_getMethod_ItemValue_V1+0x1a0>
            return _toStringCompactBalanceOf(
c0d03c6c:	9200      	str	r2, [sp, #0]
                &m->nested.staking_bond_V1.value,
c0d03c6e:	3418      	adds	r4, #24
c0d03c70:	e7b3      	b.n	c0d03bda <_getMethod_ItemValue_V1+0xfa>
            return _toStringRewardDestination_V1(
c0d03c72:	9200      	str	r2, [sp, #0]
                &m->nested.staking_bond_V1.payee,
c0d03c74:	3420      	adds	r4, #32
c0d03c76:	4620      	mov	r0, r4
c0d03c78:	9a01      	ldr	r2, [sp, #4]
c0d03c7a:	9b02      	ldr	r3, [sp, #8]
c0d03c7c:	f000 ff2c 	bl	c0d04ad8 <_toStringRewardDestination_V1>
    default:
        return parser_ok;
    }

    return parser_ok;
}
c0d03c80:	b003      	add	sp, #12
c0d03c82:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03c84:	00001f01 	.word	0x00001f01
c0d03c88:	00001f05 	.word	0x00001f05
c0d03c8c:	00001f11 	.word	0x00001f11
c0d03c90:	00001f12 	.word	0x00001f12
c0d03c94:	00001f13 	.word	0x00001f13
c0d03c98:	00001f06 	.word	0x00001f06
c0d03c9c:	00001f07 	.word	0x00001f07
c0d03ca0:	00001f03 	.word	0x00001f03
c0d03ca4:	00001f04 	.word	0x00001f04
c0d03ca8:	00001f02 	.word	0x00001f02
c0d03cac:	000007ff 	.word	0x000007ff
c0d03cb0:	00001eff 	.word	0x00001eff
c0d03cb4:	00000802 	.word	0x00000802
c0d03cb8:	000002ff 	.word	0x000002ff
c0d03cbc:	00000301 	.word	0x00000301
c0d03cc0:	00000203 	.word	0x00000203

c0d03cc4 <_getMethod_ItemIsExpert_V1>:

bool _getMethod_ItemIsExpert_V1(uint8_t moduleIdx, uint8_t callIdx, uint8_t itemIdx)
{
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;
c0d03cc4:	0200      	lsls	r0, r0, #8
c0d03cc6:	1840      	adds	r0, r0, r1
c0d03cc8:	4908      	ldr	r1, [pc, #32]	; (c0d03cec <_getMethod_ItemIsExpert_V1+0x28>)

    switch (callPrivIdx) {
c0d03cca:	4288      	cmp	r0, r1
c0d03ccc:	d008      	beq.n	c0d03ce0 <_getMethod_ItemIsExpert_V1+0x1c>
c0d03cce:	4908      	ldr	r1, [pc, #32]	; (c0d03cf0 <_getMethod_ItemIsExpert_V1+0x2c>)
c0d03cd0:	4288      	cmp	r0, r1
c0d03cd2:	d005      	beq.n	c0d03ce0 <_getMethod_ItemIsExpert_V1+0x1c>
c0d03cd4:	4907      	ldr	r1, [pc, #28]	; (c0d03cf4 <_getMethod_ItemIsExpert_V1+0x30>)
c0d03cd6:	4288      	cmp	r0, r1
c0d03cd8:	d106      	bne.n	c0d03ce8 <_getMethod_ItemIsExpert_V1+0x24>
    case 7939: // Staking:Withdraw Unbonded
        switch (itemIdx) {
c0d03cda:	4250      	negs	r0, r2
c0d03cdc:	4150      	adcs	r0, r2
c0d03cde:	4770      	bx	lr
c0d03ce0:	1e51      	subs	r1, r2, #1
c0d03ce2:	4248      	negs	r0, r1
c0d03ce4:	4148      	adcs	r0, r1
        }

    default:
        return false;
    }
}
c0d03ce6:	4770      	bx	lr
c0d03ce8:	2000      	movs	r0, #0
c0d03cea:	4770      	bx	lr
c0d03cec:	00001f15 	.word	0x00001f15
c0d03cf0:	00001f0f 	.word	0x00001f0f
c0d03cf4:	00001f03 	.word	0x00001f03

c0d03cf8 <_getMethod_IsNestingSupported_V1>:

// Remove any methods that can be passed in to a dispatchable like utility.batch, utility.batchAll or in proposals or in sudo
bool _getMethod_IsNestingSupported_V1(uint8_t moduleIdx, uint8_t callIdx)
{
    uint16_t callPrivIdx = ((uint16_t)moduleIdx << 8u) + callIdx;
c0d03cf8:	0200      	lsls	r0, r0, #8
c0d03cfa:	1841      	adds	r1, r0, r1
c0d03cfc:	2000      	movs	r0, #0
c0d03cfe:	4a38      	ldr	r2, [pc, #224]	; (c0d03de0 <_getMethod_IsNestingSupported_V1+0xe8>)

    switch (callPrivIdx) {
c0d03d00:	4291      	cmp	r1, r2
c0d03d02:	dd0d      	ble.n	c0d03d20 <_getMethod_IsNestingSupported_V1+0x28>
c0d03d04:	4a37      	ldr	r2, [pc, #220]	; (c0d03de4 <_getMethod_IsNestingSupported_V1+0xec>)
c0d03d06:	4291      	cmp	r1, r2
c0d03d08:	dc1b      	bgt.n	c0d03d42 <_getMethod_IsNestingSupported_V1+0x4a>
c0d03d0a:	4a3a      	ldr	r2, [pc, #232]	; (c0d03df4 <_getMethod_IsNestingSupported_V1+0xfc>)
c0d03d0c:	4291      	cmp	r1, r2
c0d03d0e:	dc2e      	bgt.n	c0d03d6e <_getMethod_IsNestingSupported_V1+0x76>
c0d03d10:	4a3c      	ldr	r2, [pc, #240]	; (c0d03e04 <_getMethod_IsNestingSupported_V1+0x10c>)
c0d03d12:	4291      	cmp	r1, r2
c0d03d14:	dd47      	ble.n	c0d03da6 <_getMethod_IsNestingSupported_V1+0xae>
c0d03d16:	4a3c      	ldr	r2, [pc, #240]	; (c0d03e08 <_getMethod_IsNestingSupported_V1+0x110>)
c0d03d18:	1889      	adds	r1, r1, r2
c0d03d1a:	290f      	cmp	r1, #15
c0d03d1c:	d25e      	bcs.n	c0d03ddc <_getMethod_IsNestingSupported_V1+0xe4>
    case 8192: // ElectionProviderMultiPhase:Submit unsigned
        return false;
    default:
        return true;
    }
}
c0d03d1e:	4770      	bx	lr
c0d03d20:	4a3c      	ldr	r2, [pc, #240]	; (c0d03e14 <_getMethod_IsNestingSupported_V1+0x11c>)
    switch (callPrivIdx) {
c0d03d22:	4291      	cmp	r1, r2
c0d03d24:	dc17      	bgt.n	c0d03d56 <_getMethod_IsNestingSupported_V1+0x5e>
c0d03d26:	4a41      	ldr	r2, [pc, #260]	; (c0d03e2c <_getMethod_IsNestingSupported_V1+0x134>)
c0d03d28:	4291      	cmp	r1, r2
c0d03d2a:	dd28      	ble.n	c0d03d7e <_getMethod_IsNestingSupported_V1+0x86>
c0d03d2c:	4a40      	ldr	r2, [pc, #256]	; (c0d03e30 <_getMethod_IsNestingSupported_V1+0x138>)
c0d03d2e:	188a      	adds	r2, r1, r2
c0d03d30:	2a19      	cmp	r2, #25
c0d03d32:	d3f4      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03d34:	4a3f      	ldr	r2, [pc, #252]	; (c0d03e34 <_getMethod_IsNestingSupported_V1+0x13c>)
c0d03d36:	188a      	adds	r2, r1, r2
c0d03d38:	2a03      	cmp	r2, #3
c0d03d3a:	d3f0      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03d3c:	2203      	movs	r2, #3
c0d03d3e:	0252      	lsls	r2, r2, #9
c0d03d40:	e04a      	b.n	c0d03dd8 <_getMethod_IsNestingSupported_V1+0xe0>
c0d03d42:	4a29      	ldr	r2, [pc, #164]	; (c0d03de8 <_getMethod_IsNestingSupported_V1+0xf0>)
c0d03d44:	188a      	adds	r2, r1, r2
c0d03d46:	2a0f      	cmp	r2, #15
c0d03d48:	d3e9      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03d4a:	4a28      	ldr	r2, [pc, #160]	; (c0d03dec <_getMethod_IsNestingSupported_V1+0xf4>)
c0d03d4c:	188a      	adds	r2, r1, r2
c0d03d4e:	2a06      	cmp	r2, #6
c0d03d50:	d3e5      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03d52:	4a27      	ldr	r2, [pc, #156]	; (c0d03df0 <_getMethod_IsNestingSupported_V1+0xf8>)
c0d03d54:	e007      	b.n	c0d03d66 <_getMethod_IsNestingSupported_V1+0x6e>
c0d03d56:	4a30      	ldr	r2, [pc, #192]	; (c0d03e18 <_getMethod_IsNestingSupported_V1+0x120>)
c0d03d58:	4291      	cmp	r1, r2
c0d03d5a:	dc1b      	bgt.n	c0d03d94 <_getMethod_IsNestingSupported_V1+0x9c>
c0d03d5c:	4a31      	ldr	r2, [pc, #196]	; (c0d03e24 <_getMethod_IsNestingSupported_V1+0x12c>)
c0d03d5e:	188a      	adds	r2, r1, r2
c0d03d60:	2a06      	cmp	r2, #6
c0d03d62:	d3dc      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03d64:	4a30      	ldr	r2, [pc, #192]	; (c0d03e28 <_getMethod_IsNestingSupported_V1+0x130>)
c0d03d66:	1889      	adds	r1, r1, r2
c0d03d68:	2906      	cmp	r1, #6
c0d03d6a:	d3d8      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03d6c:	e036      	b.n	c0d03ddc <_getMethod_IsNestingSupported_V1+0xe4>
c0d03d6e:	4a22      	ldr	r2, [pc, #136]	; (c0d03df8 <_getMethod_IsNestingSupported_V1+0x100>)
c0d03d70:	4291      	cmp	r1, r2
c0d03d72:	dd27      	ble.n	c0d03dc4 <_getMethod_IsNestingSupported_V1+0xcc>
c0d03d74:	4a21      	ldr	r2, [pc, #132]	; (c0d03dfc <_getMethod_IsNestingSupported_V1+0x104>)
c0d03d76:	1889      	adds	r1, r1, r2
c0d03d78:	2909      	cmp	r1, #9
c0d03d7a:	d3d0      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03d7c:	e02e      	b.n	c0d03ddc <_getMethod_IsNestingSupported_V1+0xe4>
c0d03d7e:	4a2e      	ldr	r2, [pc, #184]	; (c0d03e38 <_getMethod_IsNestingSupported_V1+0x140>)
c0d03d80:	4291      	cmp	r1, r2
c0d03d82:	dc1a      	bgt.n	c0d03dba <_getMethod_IsNestingSupported_V1+0xc2>
c0d03d84:	4a2e      	ldr	r2, [pc, #184]	; (c0d03e40 <_getMethod_IsNestingSupported_V1+0x148>)
c0d03d86:	188a      	adds	r2, r1, r2
c0d03d88:	2a02      	cmp	r2, #2
c0d03d8a:	d3c8      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03d8c:	2909      	cmp	r1, #9
c0d03d8e:	d0c6      	beq.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03d90:	2201      	movs	r2, #1
c0d03d92:	e020      	b.n	c0d03dd6 <_getMethod_IsNestingSupported_V1+0xde>
c0d03d94:	4a21      	ldr	r2, [pc, #132]	; (c0d03e1c <_getMethod_IsNestingSupported_V1+0x124>)
c0d03d96:	188a      	adds	r2, r1, r2
c0d03d98:	2a07      	cmp	r2, #7
c0d03d9a:	d3c0      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03d9c:	4a20      	ldr	r2, [pc, #128]	; (c0d03e20 <_getMethod_IsNestingSupported_V1+0x128>)
c0d03d9e:	1889      	adds	r1, r1, r2
c0d03da0:	2904      	cmp	r1, #4
c0d03da2:	d3bc      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03da4:	e01a      	b.n	c0d03ddc <_getMethod_IsNestingSupported_V1+0xe4>
c0d03da6:	4a19      	ldr	r2, [pc, #100]	; (c0d03e0c <_getMethod_IsNestingSupported_V1+0x114>)
c0d03da8:	188a      	adds	r2, r1, r2
c0d03daa:	2a02      	cmp	r2, #2
c0d03dac:	d3b7      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03dae:	4a18      	ldr	r2, [pc, #96]	; (c0d03e10 <_getMethod_IsNestingSupported_V1+0x118>)
c0d03db0:	188a      	adds	r2, r1, r2
c0d03db2:	2a02      	cmp	r2, #2
c0d03db4:	d3b3      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03db6:	221d      	movs	r2, #29
c0d03db8:	e00d      	b.n	c0d03dd6 <_getMethod_IsNestingSupported_V1+0xde>
c0d03dba:	4a20      	ldr	r2, [pc, #128]	; (c0d03e3c <_getMethod_IsNestingSupported_V1+0x144>)
c0d03dbc:	1889      	adds	r1, r1, r2
c0d03dbe:	2903      	cmp	r1, #3
c0d03dc0:	d3ad      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03dc2:	e00b      	b.n	c0d03ddc <_getMethod_IsNestingSupported_V1+0xe4>
c0d03dc4:	4a0e      	ldr	r2, [pc, #56]	; (c0d03e00 <_getMethod_IsNestingSupported_V1+0x108>)
c0d03dc6:	188a      	adds	r2, r1, r2
c0d03dc8:	2a02      	cmp	r2, #2
c0d03dca:	d3a8      	bcc.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03dcc:	2201      	movs	r2, #1
c0d03dce:	0352      	lsls	r2, r2, #13
c0d03dd0:	4291      	cmp	r1, r2
c0d03dd2:	d0a4      	beq.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03dd4:	2221      	movs	r2, #33	; 0x21
c0d03dd6:	0212      	lsls	r2, r2, #8
c0d03dd8:	4291      	cmp	r1, r2
c0d03dda:	d0a0      	beq.n	c0d03d1e <_getMethod_IsNestingSupported_V1+0x26>
c0d03ddc:	2001      	movs	r0, #1
}
c0d03dde:	4770      	bx	lr
c0d03de0:	000015ff 	.word	0x000015ff
c0d03de4:	000024ff 	.word	0x000024ff
c0d03de8:	ffffd900 	.word	0xffffd900
c0d03dec:	ffffdb00 	.word	0xffffdb00
c0d03df0:	ffffda00 	.word	0xffffda00
c0d03df4:	00001fff 	.word	0x00001fff
c0d03df8:	000022ff 	.word	0x000022ff
c0d03dfc:	ffffdd00 	.word	0xffffdd00
c0d03e00:	ffffde00 	.word	0xffffde00
c0d03e04:	00001f07 	.word	0x00001f07
c0d03e08:	ffffe0f8 	.word	0xffffe0f8
c0d03e0c:	ffffea00 	.word	0xffffea00
c0d03e10:	ffffe200 	.word	0xffffe200
c0d03e14:	000012ff 	.word	0x000012ff
c0d03e18:	000014d5 	.word	0x000014d5
c0d03e1c:	ffffeb00 	.word	0xffffeb00
c0d03e20:	ffffeb2a 	.word	0xffffeb2a
c0d03e24:	ffffed00 	.word	0xffffed00
c0d03e28:	ffffec00 	.word	0xffffec00
c0d03e2c:	000005ff 	.word	0x000005ff
c0d03e30:	ffffee00 	.word	0xffffee00
c0d03e34:	fffff800 	.word	0xfffff800
c0d03e38:	000004ff 	.word	0x000004ff
c0d03e3c:	fffffb00 	.word	0xfffffb00
c0d03e40:	fffffd00 	.word	0xfffffd00

c0d03e44 <_readbool>:
#include <stdint.h>
#include <zbuffer.h>
#include <zxmacros.h>

parser_error_t _readbool(parser_context_t* c, pd_bool_t* v)
{
c0d03e44:	b580      	push	{r7, lr}
    return _readUInt8(c, v);
c0d03e46:	f7fe fee7 	bl	c0d02c18 <_readUInt8>
c0d03e4a:	bd80      	pop	{r7, pc}

c0d03e4c <_readu32>:
{
    return _readUInt16(c, v);
}

parser_error_t _readu32(parser_context_t* c, pd_u32_t* v)
{
c0d03e4c:	b580      	push	{r7, lr}
    return _readUInt32(c, v);
c0d03e4e:	f7fe fef8 	bl	c0d02c42 <_readUInt32>
c0d03e52:	bd80      	pop	{r7, pc}

c0d03e54 <_readCallImpl>:
{
    return _readCompactInt(c, v);
}

parser_error_t _readCallImpl(parser_context_t* c, pd_Call_t* v, pd_MethodNested_t* m)
{
c0d03e54:	b570      	push	{r4, r5, r6, lr}
c0d03e56:	4616      	mov	r6, r2
c0d03e58:	460c      	mov	r4, r1
c0d03e5a:	4605      	mov	r5, r0
    // If it's the first Call, store a pointer to it
    if (c->tx_obj->nestCallIdx._ptr == NULL) {
c0d03e5c:	6880      	ldr	r0, [r0, #8]
c0d03e5e:	6ec1      	ldr	r1, [r0, #108]	; 0x6c
c0d03e60:	2900      	cmp	r1, #0
c0d03e62:	d007      	beq.n	c0d03e74 <_readCallImpl+0x20>
        c->tx_obj->nestCallIdx._lenBuffer = c->bufferLen - c->offset;
    } else {
        // If _ptr is not null, and landed here, means we're inside a nested call.
        // We stored the pointer to the first Call and now we store
        // the pointer to the 'next' Call.
        if (c->tx_obj->nestCallIdx._nextPtr == NULL) {
c0d03e64:	6f01      	ldr	r1, [r0, #112]	; 0x70
c0d03e66:	2900      	cmp	r1, #0
c0d03e68:	d10b      	bne.n	c0d03e82 <_readCallImpl+0x2e>
            c->tx_obj->nestCallIdx._nextPtr = c->buffer + c->offset;
c0d03e6a:	88e9      	ldrh	r1, [r5, #6]
c0d03e6c:	682a      	ldr	r2, [r5, #0]
c0d03e6e:	1851      	adds	r1, r2, r1
c0d03e70:	6701      	str	r1, [r0, #112]	; 0x70
c0d03e72:	e006      	b.n	c0d03e82 <_readCallImpl+0x2e>
        c->tx_obj->nestCallIdx._ptr = c->buffer + c->offset;
c0d03e74:	88e9      	ldrh	r1, [r5, #6]
c0d03e76:	682a      	ldr	r2, [r5, #0]
c0d03e78:	1852      	adds	r2, r2, r1
c0d03e7a:	66c2      	str	r2, [r0, #108]	; 0x6c
        c->tx_obj->nestCallIdx._lenBuffer = c->bufferLen - c->offset;
c0d03e7c:	88aa      	ldrh	r2, [r5, #4]
c0d03e7e:	1a51      	subs	r1, r2, r1
c0d03e80:	6681      	str	r1, [r0, #104]	; 0x68
c0d03e82:	2174      	movs	r1, #116	; 0x74
        }
    }

    // To keep track on how many nested Calls we have
    c->tx_obj->nestCallIdx.slotIdx++;
c0d03e84:	5c42      	ldrb	r2, [r0, r1]
c0d03e86:	1c52      	adds	r2, r2, #1
c0d03e88:	5442      	strb	r2, [r0, r1]
c0d03e8a:	b2d0      	uxtb	r0, r2
    if (c->tx_obj->nestCallIdx.slotIdx > MAX_CALL_NESTING_SIZE) {
c0d03e8c:	2802      	cmp	r0, #2
c0d03e8e:	d901      	bls.n	c0d03e94 <_readCallImpl+0x40>
c0d03e90:	2015      	movs	r0, #21
    v->nestCallIdx._lenBuffer = c->tx_obj->nestCallIdx._lenBuffer;
    v->nestCallIdx._ptr = c->tx_obj->nestCallIdx._ptr;
    v->nestCallIdx._nextPtr = c->tx_obj->nestCallIdx._nextPtr;

    return parser_ok;
}
c0d03e92:	bd70      	pop	{r4, r5, r6, pc}
    CHECK_ERROR(_readCallIndex(c, &v->callIndex));
c0d03e94:	4628      	mov	r0, r5
c0d03e96:	4621      	mov	r1, r4
c0d03e98:	f7ff f858 	bl	c0d02f4c <_readCallIndex>
c0d03e9c:	2800      	cmp	r0, #0
c0d03e9e:	d000      	beq.n	c0d03ea2 <_readCallImpl+0x4e>
}
c0d03ea0:	bd70      	pop	{r4, r5, r6, pc}
    if (!_getMethod_IsNestingSupported(c->tx_obj->transactionVersion, v->callIndex.moduleIdx, v->callIndex.idx)) {
c0d03ea2:	7862      	ldrb	r2, [r4, #1]
c0d03ea4:	7821      	ldrb	r1, [r4, #0]
c0d03ea6:	68a8      	ldr	r0, [r5, #8]
c0d03ea8:	6dc0      	ldr	r0, [r0, #92]	; 0x5c
c0d03eaa:	f7ff fb46 	bl	c0d0353a <_getMethod_IsNestingSupported>
c0d03eae:	2800      	cmp	r0, #0
c0d03eb0:	d013      	beq.n	c0d03eda <_readCallImpl+0x86>
    CHECK_ERROR(_readMethod(c, v->callIndex.moduleIdx, v->callIndex.idx, (pd_Method_t*)m))
c0d03eb2:	7862      	ldrb	r2, [r4, #1]
c0d03eb4:	7821      	ldrb	r1, [r4, #0]
c0d03eb6:	4628      	mov	r0, r5
c0d03eb8:	4633      	mov	r3, r6
c0d03eba:	f7ff fae9 	bl	c0d03490 <_readMethod>
c0d03ebe:	2800      	cmp	r0, #0
c0d03ec0:	d1ee      	bne.n	c0d03ea0 <_readCallImpl+0x4c>
    v->_txVerPtr = &c->tx_obj->transactionVersion;
c0d03ec2:	68a8      	ldr	r0, [r5, #8]
c0d03ec4:	4601      	mov	r1, r0
c0d03ec6:	315c      	adds	r1, #92	; 0x5c
c0d03ec8:	6061      	str	r1, [r4, #4]
    v->nestCallIdx._lenBuffer = c->tx_obj->nestCallIdx._lenBuffer;
c0d03eca:	6e81      	ldr	r1, [r0, #104]	; 0x68
c0d03ecc:	60a1      	str	r1, [r4, #8]
    v->nestCallIdx._ptr = c->tx_obj->nestCallIdx._ptr;
c0d03ece:	6ec1      	ldr	r1, [r0, #108]	; 0x6c
c0d03ed0:	60e1      	str	r1, [r4, #12]
    v->nestCallIdx._nextPtr = c->tx_obj->nestCallIdx._nextPtr;
c0d03ed2:	6f00      	ldr	r0, [r0, #112]	; 0x70
c0d03ed4:	6120      	str	r0, [r4, #16]
c0d03ed6:	2000      	movs	r0, #0
}
c0d03ed8:	bd70      	pop	{r4, r5, r6, pc}
c0d03eda:	2014      	movs	r0, #20
c0d03edc:	bd70      	pop	{r4, r5, r6, pc}

c0d03ede <_readBytes>:
{
    return _readBalance(c, &v->value);
}

parser_error_t _readBytes(parser_context_t* c, pd_Bytes_t* v)
{
c0d03ede:	b5b0      	push	{r4, r5, r7, lr}
c0d03ee0:	b082      	sub	sp, #8
    CHECK_INPUT()
c0d03ee2:	2900      	cmp	r1, #0
c0d03ee4:	d023      	beq.n	c0d03f2e <_readBytes+0x50>
c0d03ee6:	4604      	mov	r4, r0
c0d03ee8:	200b      	movs	r0, #11
c0d03eea:	2c00      	cmp	r4, #0
c0d03eec:	d020      	beq.n	c0d03f30 <_readBytes+0x52>
c0d03eee:	460d      	mov	r5, r1
c0d03ef0:	88a1      	ldrh	r1, [r4, #4]
c0d03ef2:	88e2      	ldrh	r2, [r4, #6]
c0d03ef4:	428a      	cmp	r2, r1
c0d03ef6:	d21b      	bcs.n	c0d03f30 <_readBytes+0x52>
c0d03ef8:	4669      	mov	r1, sp

    compactInt_t clen;
    CHECK_ERROR(_readCompactInt(c, &clen))
c0d03efa:	4620      	mov	r0, r4
c0d03efc:	f7fe febb 	bl	c0d02c76 <_readCompactInt>
c0d03f00:	2800      	cmp	r0, #0
c0d03f02:	d115      	bne.n	c0d03f30 <_readBytes+0x52>
c0d03f04:	4668      	mov	r0, sp
    CHECK_ERROR(_getValue(&clen, &v->_len))
c0d03f06:	4629      	mov	r1, r5
c0d03f08:	f7fe fef0 	bl	c0d02cec <_getValue>
c0d03f0c:	2800      	cmp	r0, #0
c0d03f0e:	d10f      	bne.n	c0d03f30 <_readBytes+0x52>

    v->_ptr = c->buffer + c->offset;
c0d03f10:	88e1      	ldrh	r1, [r4, #6]
c0d03f12:	6820      	ldr	r0, [r4, #0]
c0d03f14:	1840      	adds	r0, r0, r1
c0d03f16:	60a8      	str	r0, [r5, #8]
    CTX_CHECK_AND_ADVANCE(c, v->_len);
c0d03f18:	cd0c      	ldmia	r5!, {r2, r3}
c0d03f1a:	2000      	movs	r0, #0
c0d03f1c:	1851      	adds	r1, r2, r1
c0d03f1e:	4143      	adcs	r3, r0
c0d03f20:	88a2      	ldrh	r2, [r4, #4]
c0d03f22:	1a52      	subs	r2, r2, r1
c0d03f24:	4602      	mov	r2, r0
c0d03f26:	419a      	sbcs	r2, r3
c0d03f28:	d204      	bcs.n	c0d03f34 <_readBytes+0x56>
c0d03f2a:	200b      	movs	r0, #11
c0d03f2c:	e000      	b.n	c0d03f30 <_readBytes+0x52>
c0d03f2e:	2001      	movs	r0, #1
    return parser_ok;
}
c0d03f30:	b002      	add	sp, #8
c0d03f32:	bdb0      	pop	{r4, r5, r7, pc}
    CTX_CHECK_AND_ADVANCE(c, v->_len);
c0d03f34:	80e1      	strh	r1, [r4, #6]
c0d03f36:	e7fb      	b.n	c0d03f30 <_readBytes+0x52>

c0d03f38 <_readCall>:
parser_error_t _readu8_array_20(parser_context_t* c, pd_u8_array_20_t* v) {
    GEN_DEF_READARRAY(20)
}

parser_error_t _readCall(parser_context_t* c, pd_Call_t* v)
{
c0d03f38:	b5b0      	push	{r4, r5, r7, lr}
c0d03f3a:	b08a      	sub	sp, #40	; 0x28
c0d03f3c:	460c      	mov	r4, r1
c0d03f3e:	4605      	mov	r5, r0
    pd_MethodNested_t _method;
    if (c->tx_obj->nestCallIdx.isTail) {
c0d03f40:	6880      	ldr	r0, [r0, #8]
c0d03f42:	2175      	movs	r1, #117	; 0x75
c0d03f44:	5c41      	ldrb	r1, [r0, r1]
c0d03f46:	2900      	cmp	r1, #0
c0d03f48:	d004      	beq.n	c0d03f54 <_readCall+0x1c>
c0d03f4a:	3075      	adds	r0, #117	; 0x75
c0d03f4c:	2100      	movs	r1, #0
        c->tx_obj->nestCallIdx.isTail = false;
c0d03f4e:	7001      	strb	r1, [r0, #0]
c0d03f50:	2001      	movs	r0, #1
c0d03f52:	e000      	b.n	c0d03f56 <_readCall+0x1e>
c0d03f54:	2000      	movs	r0, #0
        v->nestCallIdx.isTail = true;
    } else {
        v->nestCallIdx.isTail = false;
c0d03f56:	7560      	strb	r0, [r4, #21]
c0d03f58:	466a      	mov	r2, sp
    }

    CHECK_ERROR(_readCallImpl(c, v, &_method))
c0d03f5a:	4628      	mov	r0, r5
c0d03f5c:	4621      	mov	r1, r4
c0d03f5e:	f7ff ff79 	bl	c0d03e54 <_readCallImpl>
c0d03f62:	2800      	cmp	r0, #0
c0d03f64:	d10b      	bne.n	c0d03f7e <_readCall+0x46>
    if (c->tx_obj->nestCallIdx._ptr != NULL && c->tx_obj->nestCallIdx._nextPtr != NULL) {
c0d03f66:	68a9      	ldr	r1, [r5, #8]
c0d03f68:	6eca      	ldr	r2, [r1, #108]	; 0x6c
c0d03f6a:	2a00      	cmp	r2, #0
c0d03f6c:	d004      	beq.n	c0d03f78 <_readCall+0x40>
c0d03f6e:	6f0b      	ldr	r3, [r1, #112]	; 0x70
c0d03f70:	2b00      	cmp	r3, #0
c0d03f72:	d001      	beq.n	c0d03f78 <_readCall+0x40>
        v->nestCallIdx._ptr = c->tx_obj->nestCallIdx._ptr;
c0d03f74:	60e2      	str	r2, [r4, #12]
        v->nestCallIdx._nextPtr = c->tx_obj->nestCallIdx._nextPtr;
c0d03f76:	6123      	str	r3, [r4, #16]
c0d03f78:	2274      	movs	r2, #116	; 0x74
    }
    v->nestCallIdx.slotIdx = c->tx_obj->nestCallIdx.slotIdx;
c0d03f7a:	5c89      	ldrb	r1, [r1, r2]
c0d03f7c:	7521      	strb	r1, [r4, #20]
    return parser_ok;
}
c0d03f7e:	b00a      	add	sp, #40	; 0x28
c0d03f80:	bdb0      	pop	{r4, r5, r7, pc}

c0d03f82 <_readVecCall>:
{
    return _readCall(c, &v->call);
}

parser_error_t _readVecCall(parser_context_t* c, pd_VecCall_t* v)
{
c0d03f82:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03f84:	b08b      	sub	sp, #44	; 0x2c
c0d03f86:	460c      	mov	r4, r1
c0d03f88:	4605      	mov	r5, r0
c0d03f8a:	a909      	add	r1, sp, #36	; 0x24
    compactInt_t clen;
    pd_Call_t dummy;
    CHECK_PARSER_ERR(_readCompactInt(c, &clen));
c0d03f8c:	f7fe fe73 	bl	c0d02c76 <_readCompactInt>
c0d03f90:	4606      	mov	r6, r0
c0d03f92:	f003 f817 	bl	c0d06fc4 <check_app_canary>
c0d03f96:	2e00      	cmp	r6, #0
c0d03f98:	d143      	bne.n	c0d04022 <_readVecCall+0xa0>
c0d03f9a:	a809      	add	r0, sp, #36	; 0x24
    CHECK_PARSER_ERR(_getValue(&clen, &v->_len));
c0d03f9c:	4621      	mov	r1, r4
c0d03f9e:	f7fe fea5 	bl	c0d02cec <_getValue>
c0d03fa2:	4606      	mov	r6, r0
c0d03fa4:	f003 f80e 	bl	c0d06fc4 <check_app_canary>
c0d03fa8:	2e00      	cmp	r6, #0
c0d03faa:	d13a      	bne.n	c0d04022 <_readVecCall+0xa0>

    if (v->_len > MAX_CALL_VEC_SIZE) {
c0d03fac:	cc03      	ldmia	r4!, {r0, r1}
c0d03fae:	2600      	movs	r6, #0
c0d03fb0:	2205      	movs	r2, #5
c0d03fb2:	3c08      	subs	r4, #8
c0d03fb4:	1a12      	subs	r2, r2, r0
c0d03fb6:	4632      	mov	r2, r6
c0d03fb8:	418a      	sbcs	r2, r1
c0d03fba:	d201      	bcs.n	c0d03fc0 <_readVecCall+0x3e>
c0d03fbc:	2616      	movs	r6, #22
c0d03fbe:	e030      	b.n	c0d04022 <_readVecCall+0xa0>
        return parser_tx_call_vec_too_large;
    }

    v->_ptr = c->buffer + c->offset;
    v->_lenBuffer = c->offset;
c0d03fc0:	6166      	str	r6, [r4, #20]
    v->_ptr = c->buffer + c->offset;
c0d03fc2:	88ea      	ldrh	r2, [r5, #6]
    v->_lenBuffer = c->offset;
c0d03fc4:	6122      	str	r2, [r4, #16]
    v->_ptr = c->buffer + c->offset;
c0d03fc6:	682b      	ldr	r3, [r5, #0]
c0d03fc8:	189a      	adds	r2, r3, r2
c0d03fca:	60a2      	str	r2, [r4, #8]
    if (v->_len == 0) {
c0d03fcc:	4308      	orrs	r0, r1
c0d03fce:	d025      	beq.n	c0d0401c <_readVecCall+0x9a>
c0d03fd0:	9502      	str	r5, [sp, #8]
c0d03fd2:	9401      	str	r4, [sp, #4]
c0d03fd4:	4637      	mov	r7, r6
c0d03fd6:	4634      	mov	r4, r6
c0d03fd8:	9802      	ldr	r0, [sp, #8]
        return parser_unexpected_buffer_end;
    }

    for (uint64_t i = 0; i < v->_len; i++) {
        c->tx_obj->nestCallIdx.slotIdx = 0;
c0d03fda:	6882      	ldr	r2, [r0, #8]
c0d03fdc:	2174      	movs	r1, #116	; 0x74
c0d03fde:	5456      	strb	r6, [r2, r1]
    for (uint64_t i = 0; i < v->_len; i++) {
c0d03fe0:	1c7f      	adds	r7, r7, #1
c0d03fe2:	4635      	mov	r5, r6
c0d03fe4:	4174      	adcs	r4, r6
c0d03fe6:	a903      	add	r1, sp, #12
        CHECK_ERROR(_readCall(c, &dummy))
c0d03fe8:	f7ff ffa6 	bl	c0d03f38 <_readCall>
c0d03fec:	2800      	cmp	r0, #0
c0d03fee:	d117      	bne.n	c0d04020 <_readVecCall+0x9e>
c0d03ff0:	9901      	ldr	r1, [sp, #4]
    for (uint64_t i = 0; i < v->_len; i++) {
c0d03ff2:	c903      	ldmia	r1, {r0, r1}
c0d03ff4:	1a38      	subs	r0, r7, r0
c0d03ff6:	4620      	mov	r0, r4
c0d03ff8:	4188      	sbcs	r0, r1
c0d03ffa:	462e      	mov	r6, r5
c0d03ffc:	d3ec      	bcc.n	c0d03fd8 <_readVecCall+0x56>
c0d03ffe:	9a01      	ldr	r2, [sp, #4]
    }
    v->_lenBuffer = c->offset - v->_lenBuffer;
c0d04000:	6910      	ldr	r0, [r2, #16]
c0d04002:	9b02      	ldr	r3, [sp, #8]
c0d04004:	88d9      	ldrh	r1, [r3, #6]
c0d04006:	2600      	movs	r6, #0
c0d04008:	1a08      	subs	r0, r1, r0
c0d0400a:	6110      	str	r0, [r2, #16]
    v->callTxVersion = c->tx_obj->transactionVersion;
c0d0400c:	6898      	ldr	r0, [r3, #8]
c0d0400e:	6dc0      	ldr	r0, [r0, #92]	; 0x5c
c0d04010:	6190      	str	r0, [r2, #24]
    v->_lenBuffer = c->offset - v->_lenBuffer;
c0d04012:	6950      	ldr	r0, [r2, #20]
c0d04014:	4631      	mov	r1, r6
c0d04016:	4181      	sbcs	r1, r0
c0d04018:	6151      	str	r1, [r2, #20]
c0d0401a:	e002      	b.n	c0d04022 <_readVecCall+0xa0>
c0d0401c:	260b      	movs	r6, #11
c0d0401e:	e000      	b.n	c0d04022 <_readVecCall+0xa0>
c0d04020:	4606      	mov	r6, r0

    return parser_ok;
}
c0d04022:	4630      	mov	r0, r6
c0d04024:	b00b      	add	sp, #44	; 0x2c
c0d04026:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d04028 <_readCompactBalanceOf>:

parser_error_t _readCompactBalanceOf(parser_context_t* c, pd_CompactBalanceOf_t* v)
{
c0d04028:	b510      	push	{r4, lr}
    CHECK_INPUT();
c0d0402a:	2900      	cmp	r1, #0
c0d0402c:	d00b      	beq.n	c0d04046 <_readCompactBalanceOf+0x1e>
c0d0402e:	4602      	mov	r2, r0
c0d04030:	200b      	movs	r0, #11
c0d04032:	2a00      	cmp	r2, #0
c0d04034:	d006      	beq.n	c0d04044 <_readCompactBalanceOf+0x1c>
c0d04036:	8893      	ldrh	r3, [r2, #4]
c0d04038:	88d4      	ldrh	r4, [r2, #6]
c0d0403a:	429c      	cmp	r4, r3
c0d0403c:	d202      	bcs.n	c0d04044 <_readCompactBalanceOf+0x1c>
    CHECK_ERROR(_readCompactInt(c, &v->value));
c0d0403e:	4610      	mov	r0, r2
c0d04040:	f7fe fe19 	bl	c0d02c76 <_readCompactInt>
c0d04044:	bd10      	pop	{r4, pc}
c0d04046:	2001      	movs	r0, #1
c0d04048:	bd10      	pop	{r4, pc}

c0d0404a <_readHash>:
    return parser_ok;
}

parser_error_t _readHash(parser_context_t* c, pd_Hash_t* v) {
    GEN_DEF_READARRAY(32)
c0d0404a:	88c2      	ldrh	r2, [r0, #6]
c0d0404c:	6803      	ldr	r3, [r0, #0]
c0d0404e:	189b      	adds	r3, r3, r2
c0d04050:	600b      	str	r3, [r1, #0]
c0d04052:	3220      	adds	r2, #32
c0d04054:	8881      	ldrh	r1, [r0, #4]
c0d04056:	428a      	cmp	r2, r1
c0d04058:	d901      	bls.n	c0d0405e <_readHash+0x14>
c0d0405a:	200b      	movs	r0, #11
}
c0d0405c:	4770      	bx	lr
    GEN_DEF_READARRAY(32)
c0d0405e:	80c2      	strh	r2, [r0, #6]
c0d04060:	2000      	movs	r0, #0
}
c0d04062:	4770      	bx	lr

c0d04064 <_toStringbool>:
    const pd_bool_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d04064:	b570      	push	{r4, r5, r6, lr}
c0d04066:	4614      	mov	r4, r2
c0d04068:	460d      	mov	r5, r1
c0d0406a:	4606      	mov	r6, r0
    CLEAN_AND_CHECK()
c0d0406c:	4608      	mov	r0, r1
c0d0406e:	4611      	mov	r1, r2
c0d04070:	f003 f960 	bl	c0d07334 <explicit_bzero>
c0d04074:	9804      	ldr	r0, [sp, #16]
c0d04076:	2e00      	cmp	r6, #0
c0d04078:	d009      	beq.n	c0d0408e <_toStringbool+0x2a>
c0d0407a:	2101      	movs	r1, #1

    *pageCount = 1;
c0d0407c:	7001      	strb	r1, [r0, #0]
    switch (*v) {
c0d0407e:	7830      	ldrb	r0, [r6, #0]
c0d04080:	2801      	cmp	r0, #1
c0d04082:	d008      	beq.n	c0d04096 <_toStringbool+0x32>
c0d04084:	2800      	cmp	r0, #0
c0d04086:	d10e      	bne.n	c0d040a6 <_toStringbool+0x42>
    case 0:
        snprintf(outValue, outValueLen, "False");
c0d04088:	4a08      	ldr	r2, [pc, #32]	; (c0d040ac <_toStringbool+0x48>)
c0d0408a:	447a      	add	r2, pc
c0d0408c:	e005      	b.n	c0d0409a <_toStringbool+0x36>
c0d0408e:	2100      	movs	r1, #0
    CLEAN_AND_CHECK()
c0d04090:	7001      	strb	r1, [r0, #0]
c0d04092:	2001      	movs	r0, #1
        snprintf(outValue, outValueLen, "True");
        return parser_ok;
    }

    return parser_not_supported;
}
c0d04094:	bd70      	pop	{r4, r5, r6, pc}
        snprintf(outValue, outValueLen, "True");
c0d04096:	4a06      	ldr	r2, [pc, #24]	; (c0d040b0 <_toStringbool+0x4c>)
c0d04098:	447a      	add	r2, pc
c0d0409a:	4628      	mov	r0, r5
c0d0409c:	4621      	mov	r1, r4
c0d0409e:	f7fe f867 	bl	c0d02170 <snprintf>
c0d040a2:	2000      	movs	r0, #0
}
c0d040a4:	bd70      	pop	{r4, r5, r6, pc}
c0d040a6:	200a      	movs	r0, #10
c0d040a8:	bd70      	pop	{r4, r5, r6, pc}
c0d040aa:	46c0      	nop			; (mov r8, r8)
c0d040ac:	00003c6b 	.word	0x00003c6b
c0d040b0:	00003c63 	.word	0x00003c63

c0d040b4 <_toStringu32>:
    const pd_u32_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d040b4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d040b6:	b0a1      	sub	sp, #132	; 0x84
c0d040b8:	461d      	mov	r5, r3
c0d040ba:	4604      	mov	r4, r0
c0d040bc:	9104      	str	r1, [sp, #16]
    CLEAN_AND_CHECK()
c0d040be:	4608      	mov	r0, r1
c0d040c0:	9203      	str	r2, [sp, #12]
c0d040c2:	4611      	mov	r1, r2
c0d040c4:	f003 f936 	bl	c0d07334 <explicit_bzero>
c0d040c8:	9926      	ldr	r1, [sp, #152]	; 0x98
c0d040ca:	2c00      	cmp	r4, #0
c0d040cc:	d028      	beq.n	c0d04120 <_toStringu32+0x6c>
c0d040ce:	9102      	str	r1, [sp, #8]
c0d040d0:	9501      	str	r5, [sp, #4]
    char bufferUI[100];

    uint64_to_str(bufferUI, sizeof(bufferUI), *v);
c0d040d2:	6827      	ldr	r7, [r4, #0]
c0d040d4:	a808      	add	r0, sp, #32
c0d040d6:	2164      	movs	r1, #100	; 0x64
NUM_TO_STR(uint64)
c0d040d8:	f003 f92c 	bl	c0d07334 <explicit_bzero>
c0d040dc:	2f00      	cmp	r7, #0
c0d040de:	d023      	beq.n	c0d04128 <_toStringu32+0x74>
c0d040e0:	2400      	movs	r4, #0
c0d040e2:	4625      	mov	r5, r4
c0d040e4:	2c63      	cmp	r4, #99	; 0x63
c0d040e6:	d030      	beq.n	c0d0414a <_toStringu32+0x96>
c0d040e8:	220a      	movs	r2, #10
c0d040ea:	9205      	str	r2, [sp, #20]
c0d040ec:	2600      	movs	r6, #0
c0d040ee:	4638      	mov	r0, r7
c0d040f0:	4629      	mov	r1, r5
c0d040f2:	4633      	mov	r3, r6
c0d040f4:	f003 f81e 	bl	c0d07134 <__aeabi_uldivmod>
c0d040f8:	9007      	str	r0, [sp, #28]
c0d040fa:	9106      	str	r1, [sp, #24]
c0d040fc:	9a05      	ldr	r2, [sp, #20]
c0d040fe:	4633      	mov	r3, r6
c0d04100:	f003 f838 	bl	c0d07174 <__aeabi_lmul>
c0d04104:	1a38      	subs	r0, r7, r0
c0d04106:	2130      	movs	r1, #48	; 0x30
c0d04108:	4301      	orrs	r1, r0
c0d0410a:	a808      	add	r0, sp, #32
c0d0410c:	5501      	strb	r1, [r0, r4]
c0d0410e:	1c64      	adds	r4, r4, #1
c0d04110:	3f0a      	subs	r7, #10
c0d04112:	41b5      	sbcs	r5, r6
c0d04114:	9f07      	ldr	r7, [sp, #28]
c0d04116:	9d06      	ldr	r5, [sp, #24]
c0d04118:	d2e4      	bcs.n	c0d040e4 <_toStringu32+0x30>
c0d0411a:	a808      	add	r0, sp, #32
c0d0411c:	1900      	adds	r0, r0, r4
c0d0411e:	e007      	b.n	c0d04130 <_toStringu32+0x7c>
c0d04120:	2000      	movs	r0, #0
    CLEAN_AND_CHECK()
c0d04122:	7008      	strb	r0, [r1, #0]
c0d04124:	2701      	movs	r7, #1
c0d04126:	e043      	b.n	c0d041b0 <_toStringu32+0xfc>
c0d04128:	a808      	add	r0, sp, #32
c0d0412a:	2130      	movs	r1, #48	; 0x30
c0d0412c:	7001      	strb	r1, [r0, #0]
c0d0412e:	1c40      	adds	r0, r0, #1
c0d04130:	1e40      	subs	r0, r0, #1
c0d04132:	2100      	movs	r1, #0
c0d04134:	43c9      	mvns	r1, r1
c0d04136:	aa08      	add	r2, sp, #32
c0d04138:	7813      	ldrb	r3, [r2, #0]
c0d0413a:	7804      	ldrb	r4, [r0, #0]
c0d0413c:	7014      	strb	r4, [r2, #0]
c0d0413e:	7003      	strb	r3, [r0, #0]
c0d04140:	1843      	adds	r3, r0, r1
c0d04142:	1c52      	adds	r2, r2, #1
c0d04144:	4290      	cmp	r0, r2
c0d04146:	4618      	mov	r0, r3
c0d04148:	d8f6      	bhi.n	c0d04138 <_toStringu32+0x84>
c0d0414a:	a808      	add	r0, sp, #32
    pageStringExt(outValue, outValueLen, inValue, (uint16_t) strlen(inValue), pageIdx, pageCount);
c0d0414c:	f003 fa82 	bl	c0d07654 <strlen>
c0d04150:	4604      	mov	r4, r0
    MEMZERO(outValue, outValueLen);
c0d04152:	9804      	ldr	r0, [sp, #16]
c0d04154:	9d03      	ldr	r5, [sp, #12]
c0d04156:	4629      	mov	r1, r5
c0d04158:	f003 f8ec 	bl	c0d07334 <explicit_bzero>
c0d0415c:	2700      	movs	r7, #0
c0d0415e:	9902      	ldr	r1, [sp, #8]
    *pageCount = 0;
c0d04160:	700f      	strb	r7, [r1, #0]
    outValueLen--;  // leave space for NULL termination
c0d04162:	1e6d      	subs	r5, r5, #1
c0d04164:	b2ae      	uxth	r6, r5
    if (outValueLen == 0) {
c0d04166:	2e00      	cmp	r6, #0
c0d04168:	d022      	beq.n	c0d041b0 <_toStringu32+0xfc>
c0d0416a:	0420      	lsls	r0, r4, #16
c0d0416c:	d020      	beq.n	c0d041b0 <_toStringu32+0xfc>
c0d0416e:	b2a0      	uxth	r0, r4
    *pageCount = (uint8_t) (inValueLen / outValueLen);
c0d04170:	4631      	mov	r1, r6
c0d04172:	f002 ff37 	bl	c0d06fe4 <__udivsi3>
c0d04176:	4345      	muls	r5, r0
c0d04178:	1b63      	subs	r3, r4, r5
c0d0417a:	b29a      	uxth	r2, r3
    if (lastChunkLen > 0) {
c0d0417c:	1e51      	subs	r1, r2, #1
c0d0417e:	4614      	mov	r4, r2
c0d04180:	418c      	sbcs	r4, r1
c0d04182:	1820      	adds	r0, r4, r0
c0d04184:	9902      	ldr	r1, [sp, #8]
c0d04186:	7008      	strb	r0, [r1, #0]
c0d04188:	b2c0      	uxtb	r0, r0
    if (pageIdx < *pageCount) {
c0d0418a:	9901      	ldr	r1, [sp, #4]
c0d0418c:	4288      	cmp	r0, r1
c0d0418e:	d90f      	bls.n	c0d041b0 <_toStringu32+0xfc>
c0d04190:	4631      	mov	r1, r6
c0d04192:	9d01      	ldr	r5, [sp, #4]
c0d04194:	4369      	muls	r1, r5
c0d04196:	ac08      	add	r4, sp, #32
c0d04198:	1861      	adds	r1, r4, r1
        if (lastChunkLen > 0 && pageIdx == *pageCount - 1) {
c0d0419a:	041b      	lsls	r3, r3, #16
c0d0419c:	d004      	beq.n	c0d041a8 <_toStringu32+0xf4>
c0d0419e:	1e40      	subs	r0, r0, #1
c0d041a0:	42a8      	cmp	r0, r5
c0d041a2:	d101      	bne.n	c0d041a8 <_toStringu32+0xf4>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), lastChunkLen);
c0d041a4:	9804      	ldr	r0, [sp, #16]
c0d041a6:	e001      	b.n	c0d041ac <_toStringu32+0xf8>
            MEMCPY(outValue, inValue + (pageIdx * outValueLen), outValueLen);
c0d041a8:	9804      	ldr	r0, [sp, #16]
c0d041aa:	4632      	mov	r2, r6
c0d041ac:	f003 f8b2 	bl	c0d07314 <__aeabi_memcpy>
    pageString(outValue, outValueLen, bufferUI, pageIdx, pageCount);
    return parser_ok;
}
c0d041b0:	4638      	mov	r0, r7
c0d041b2:	b021      	add	sp, #132	; 0x84
c0d041b4:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d041b8 <_toStringBytes>:
    const pd_Bytes_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d041b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d041ba:	b087      	sub	sp, #28
c0d041bc:	461f      	mov	r7, r3
c0d041be:	4616      	mov	r6, r2
c0d041c0:	460d      	mov	r5, r1
c0d041c2:	4604      	mov	r4, r0
    GEN_DEF_TOSTRING_ARRAY(v->_len);
c0d041c4:	4608      	mov	r0, r1
c0d041c6:	4611      	mov	r1, r2
c0d041c8:	f003 f8b4 	bl	c0d07334 <explicit_bzero>
c0d041cc:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d041ce:	2c00      	cmp	r4, #0
c0d041d0:	d053      	beq.n	c0d0427a <_toStringBytes+0xc2>
c0d041d2:	200b      	movs	r0, #11
c0d041d4:	2e00      	cmp	r6, #0
c0d041d6:	d053      	beq.n	c0d04280 <_toStringBytes+0xc8>
c0d041d8:	68a1      	ldr	r1, [r4, #8]
c0d041da:	2900      	cmp	r1, #0
c0d041dc:	d050      	beq.n	c0d04280 <_toStringBytes+0xc8>
c0d041de:	9702      	str	r7, [sp, #8]
c0d041e0:	9506      	str	r5, [sp, #24]
c0d041e2:	9605      	str	r6, [sp, #20]
c0d041e4:	1e70      	subs	r0, r6, #1
c0d041e6:	0fc1      	lsrs	r1, r0, #31
c0d041e8:	1840      	adds	r0, r0, r1
c0d041ea:	1042      	asrs	r2, r0, #1
c0d041ec:	9204      	str	r2, [sp, #16]
c0d041ee:	cc03      	ldmia	r4!, {r0, r1}
c0d041f0:	2500      	movs	r5, #0
c0d041f2:	461e      	mov	r6, r3
c0d041f4:	462b      	mov	r3, r5
c0d041f6:	3c08      	subs	r4, #8
c0d041f8:	f002 ff9c 	bl	c0d07134 <__aeabi_uldivmod>
c0d041fc:	9601      	str	r6, [sp, #4]
c0d041fe:	9000      	str	r0, [sp, #0]
c0d04200:	7030      	strb	r0, [r6, #0]
c0d04202:	ccc0      	ldmia	r4!, {r6, r7}
c0d04204:	4630      	mov	r0, r6
c0d04206:	4639      	mov	r1, r7
c0d04208:	9a04      	ldr	r2, [sp, #16]
c0d0420a:	9503      	str	r5, [sp, #12]
c0d0420c:	462b      	mov	r3, r5
c0d0420e:	3c08      	subs	r4, #8
c0d04210:	f002 ff90 	bl	c0d07134 <__aeabi_uldivmod>
c0d04214:	4631      	mov	r1, r6
c0d04216:	4313      	orrs	r3, r2
c0d04218:	d005      	beq.n	c0d04226 <_toStringBytes+0x6e>
c0d0421a:	9800      	ldr	r0, [sp, #0]
c0d0421c:	1c40      	adds	r0, r0, #1
c0d0421e:	9901      	ldr	r1, [sp, #4]
c0d04220:	7008      	strb	r0, [r1, #0]
c0d04222:	cc82      	ldmia	r4!, {r1, r7}
c0d04224:	3c08      	subs	r4, #8
c0d04226:	9802      	ldr	r0, [sp, #8]
c0d04228:	9b04      	ldr	r3, [sp, #16]
c0d0422a:	4358      	muls	r0, r3
c0d0422c:	b286      	uxth	r6, r0
c0d0422e:	1b8a      	subs	r2, r1, r6
c0d04230:	9803      	ldr	r0, [sp, #12]
c0d04232:	4187      	sbcs	r7, r0
c0d04234:	1ad1      	subs	r1, r2, r3
c0d04236:	4187      	sbcs	r7, r0
c0d04238:	d300      	bcc.n	c0d0423c <_toStringBytes+0x84>
c0d0423a:	461a      	mov	r2, r3
c0d0423c:	b292      	uxth	r2, r2
c0d0423e:	2a00      	cmp	r2, #0
c0d04240:	d01e      	beq.n	c0d04280 <_toStringBytes+0xc8>
c0d04242:	2100      	movs	r1, #0
c0d04244:	480f      	ldr	r0, [pc, #60]	; (c0d04284 <_toStringBytes+0xcc>)
c0d04246:	4478      	add	r0, pc
c0d04248:	9004      	str	r0, [sp, #16]
c0d0424a:	4608      	mov	r0, r1
c0d0424c:	9103      	str	r1, [sp, #12]
c0d0424e:	4637      	mov	r7, r6
c0d04250:	460e      	mov	r6, r1
c0d04252:	68a1      	ldr	r1, [r4, #8]
c0d04254:	19c9      	adds	r1, r1, r7
c0d04256:	5c0b      	ldrb	r3, [r1, r0]
c0d04258:	0470      	lsls	r0, r6, #17
c0d0425a:	0c01      	lsrs	r1, r0, #16
c0d0425c:	9806      	ldr	r0, [sp, #24]
c0d0425e:	1840      	adds	r0, r0, r1
c0d04260:	9d05      	ldr	r5, [sp, #20]
c0d04262:	1a69      	subs	r1, r5, r1
c0d04264:	4615      	mov	r5, r2
c0d04266:	9a04      	ldr	r2, [sp, #16]
c0d04268:	f7fd ff82 	bl	c0d02170 <snprintf>
c0d0426c:	462a      	mov	r2, r5
c0d0426e:	1c76      	adds	r6, r6, #1
c0d04270:	b2b0      	uxth	r0, r6
c0d04272:	4285      	cmp	r5, r0
c0d04274:	d8ed      	bhi.n	c0d04252 <_toStringBytes+0x9a>
c0d04276:	9803      	ldr	r0, [sp, #12]
c0d04278:	e002      	b.n	c0d04280 <_toStringBytes+0xc8>
c0d0427a:	2000      	movs	r0, #0
c0d0427c:	7018      	strb	r0, [r3, #0]
c0d0427e:	2001      	movs	r0, #1
}
c0d04280:	b007      	add	sp, #28
c0d04282:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d04284:	00003aba 	.word	0x00003aba

c0d04288 <_toStringCall>:
    const pd_Call_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d04288:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0428a:	b0b7      	sub	sp, #220	; 0xdc
c0d0428c:	461f      	mov	r7, r3
c0d0428e:	4615      	mov	r5, r2
c0d04290:	460c      	mov	r4, r1
c0d04292:	4606      	mov	r6, r0
    CLEAN_AND_CHECK()
c0d04294:	4608      	mov	r0, r1
c0d04296:	4611      	mov	r1, r2
c0d04298:	f003 f84c 	bl	c0d07334 <explicit_bzero>
c0d0429c:	993c      	ldr	r1, [sp, #240]	; 0xf0
c0d0429e:	2e00      	cmp	r6, #0
c0d042a0:	d009      	beq.n	c0d042b6 <_toStringCall+0x2e>
c0d042a2:	2001      	movs	r0, #1
    *pageCount = 1;
c0d042a4:	7008      	strb	r0, [r1, #0]

    parser_context_t ctx;

    const uint8_t* buffer;
    if (v->nestCallIdx.isTail) {
c0d042a6:	7d70      	ldrb	r0, [r6, #21]
c0d042a8:	2800      	cmp	r0, #0
c0d042aa:	940b      	str	r4, [sp, #44]	; 0x2c
c0d042ac:	9708      	str	r7, [sp, #32]
c0d042ae:	9107      	str	r1, [sp, #28]
c0d042b0:	d005      	beq.n	c0d042be <_toStringCall+0x36>
c0d042b2:	200c      	movs	r0, #12
c0d042b4:	e004      	b.n	c0d042c0 <_toStringCall+0x38>
c0d042b6:	2000      	movs	r0, #0
    CLEAN_AND_CHECK()
c0d042b8:	7008      	strb	r0, [r1, #0]
c0d042ba:	2001      	movs	r0, #1
c0d042bc:	e0a8      	b.n	c0d04410 <_toStringCall+0x188>
c0d042be:	2010      	movs	r0, #16
c0d042c0:	5831      	ldr	r1, [r6, r0]
        buffer = v->nestCallIdx._ptr;
    } else {
        buffer = v->nestCallIdx._nextPtr;
    }

    parser_init(&ctx, buffer, v->nestCallIdx._lenBuffer);
c0d042c2:	8932      	ldrh	r2, [r6, #8]
c0d042c4:	ac34      	add	r4, sp, #208	; 0xd0
c0d042c6:	4620      	mov	r0, r4
c0d042c8:	f7fe fbf6 	bl	c0d02ab8 <parser_init>

    pd_Call_t _call;
    _call.nestCallIdx.isTail = false;

    ctx.tx_obj = &_txObj;
    _txObj.transactionVersion = *v->_txVerPtr;
c0d042cc:	6870      	ldr	r0, [r6, #4]
c0d042ce:	6800      	ldr	r0, [r0, #0]
c0d042d0:	2174      	movs	r1, #116	; 0x74
c0d042d2:	aa16      	add	r2, sp, #88	; 0x58
c0d042d4:	2700      	movs	r7, #0

    ctx.tx_obj->nestCallIdx._ptr = NULL;
    ctx.tx_obj->nestCallIdx._nextPtr = NULL;
    ctx.tx_obj->nestCallIdx._lenBuffer = 0;
c0d042d6:	5257      	strh	r7, [r2, r1]
c0d042d8:	a910      	add	r1, sp, #64	; 0x40
    _call.nestCallIdx.isTail = false;
c0d042da:	754f      	strb	r7, [r1, #21]
    ctx.tx_obj = &_txObj;
c0d042dc:	9236      	str	r2, [sp, #216]	; 0xd8
    _txObj.transactionVersion = *v->_txVerPtr;
c0d042de:	902d      	str	r0, [sp, #180]	; 0xb4
    ctx.tx_obj->nestCallIdx._lenBuffer = 0;
c0d042e0:	9732      	str	r7, [sp, #200]	; 0xc8
c0d042e2:	9731      	str	r7, [sp, #196]	; 0xc4
c0d042e4:	9730      	str	r7, [sp, #192]	; 0xc0
    ctx.tx_obj->nestCallIdx.slotIdx = 0;
    ctx.tx_obj->nestCallIdx.isTail = false;

    // Read the Call, so we get the contained Method
    parser_error_t err = _readCallImpl(&ctx, &_call, (pd_MethodNested_t*)&_txObj.method);
c0d042e6:	3208      	adds	r2, #8
c0d042e8:	4620      	mov	r0, r4
c0d042ea:	4614      	mov	r4, r2
c0d042ec:	f7ff fdb2 	bl	c0d03e54 <_readCallImpl>
    if (err != parser_ok) {
c0d042f0:	2800      	cmp	r0, #0
c0d042f2:	d000      	beq.n	c0d042f6 <_toStringCall+0x6e>
c0d042f4:	e08c      	b.n	c0d04410 <_toStringCall+0x188>
c0d042f6:	ab0f      	add	r3, sp, #60	; 0x3c
        return err;
    }

    // Get num items of this current Call
    uint8_t callNumItems = 0;
c0d042f8:	701f      	strb	r7, [r3, #0]
    CHECK_ERROR(_getMethod_NumItems(*v->_txVerPtr, v->callIndex.moduleIdx, v->callIndex.idx, &callNumItems));
c0d042fa:	7872      	ldrb	r2, [r6, #1]
c0d042fc:	7831      	ldrb	r1, [r6, #0]
c0d042fe:	6870      	ldr	r0, [r6, #4]
c0d04300:	6800      	ldr	r0, [r0, #0]
c0d04302:	f7ff f8cf 	bl	c0d034a4 <_getMethod_NumItems>
c0d04306:	2800      	cmp	r0, #0
c0d04308:	d000      	beq.n	c0d0430c <_toStringCall+0x84>
c0d0430a:	e081      	b.n	c0d04410 <_toStringCall+0x188>
c0d0430c:	a80f      	add	r0, sp, #60	; 0x3c

    // Count how many pages this call has (including nested ones if they exists)
    for (uint8_t i = 0; i < callNumItems; i++) {
c0d0430e:	7800      	ldrb	r0, [r0, #0]
c0d04310:	2800      	cmp	r0, #0
c0d04312:	940a      	str	r4, [sp, #40]	; 0x28
c0d04314:	4632      	mov	r2, r6
c0d04316:	9e07      	ldr	r6, [sp, #28]
c0d04318:	9209      	str	r2, [sp, #36]	; 0x24
c0d0431a:	d025      	beq.n	c0d04368 <_toStringCall+0xe0>
c0d0431c:	463c      	mov	r4, r7
c0d0431e:	a90e      	add	r1, sp, #56	; 0x38
        uint8_t itemPages = 0;
c0d04320:	700f      	strb	r7, [r1, #0]
c0d04322:	a810      	add	r0, sp, #64	; 0x40
        _getMethod_ItemValue(*v->_txVerPtr, &_txObj.method, _call.callIndex.moduleIdx, _call.callIndex.idx, i,
c0d04324:	7843      	ldrb	r3, [r0, #1]
c0d04326:	930c      	str	r3, [sp, #48]	; 0x30
c0d04328:	7803      	ldrb	r3, [r0, #0]
c0d0432a:	6850      	ldr	r0, [r2, #4]
c0d0432c:	6802      	ldr	r2, [r0, #0]
c0d0432e:	4638      	mov	r0, r7
c0d04330:	4637      	mov	r7, r6
c0d04332:	462e      	mov	r6, r5
c0d04334:	b2e5      	uxtb	r5, r4
c0d04336:	9500      	str	r5, [sp, #0]
c0d04338:	4635      	mov	r5, r6
c0d0433a:	9e0b      	ldr	r6, [sp, #44]	; 0x2c
c0d0433c:	9601      	str	r6, [sp, #4]
c0d0433e:	463e      	mov	r6, r7
c0d04340:	4607      	mov	r7, r0
c0d04342:	9502      	str	r5, [sp, #8]
c0d04344:	9003      	str	r0, [sp, #12]
c0d04346:	9104      	str	r1, [sp, #16]
c0d04348:	4610      	mov	r0, r2
c0d0434a:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d0434c:	461a      	mov	r2, r3
c0d0434e:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d04350:	f7ff f8d1 	bl	c0d034f6 <_getMethod_ItemValue>
c0d04354:	9a09      	ldr	r2, [sp, #36]	; 0x24
            outValue, outValueLen, 0, &itemPages);
        (*pageCount) += itemPages;
c0d04356:	7830      	ldrb	r0, [r6, #0]
c0d04358:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d0435a:	1840      	adds	r0, r0, r1
c0d0435c:	7030      	strb	r0, [r6, #0]
    for (uint8_t i = 0; i < callNumItems; i++) {
c0d0435e:	1c64      	adds	r4, r4, #1
c0d04360:	a80f      	add	r0, sp, #60	; 0x3c
c0d04362:	7800      	ldrb	r0, [r0, #0]
c0d04364:	4284      	cmp	r4, r0
c0d04366:	d3da      	bcc.n	c0d0431e <_toStringCall+0x96>
c0d04368:	4614      	mov	r4, r2
c0d0436a:	950c      	str	r5, [sp, #48]	; 0x30
    }

    zb_check_canary();
c0d0436c:	f002 fd96 	bl	c0d06e9c <zb_check_canary>
c0d04370:	9a08      	ldr	r2, [sp, #32]

    if (pageIdx == 0) {
c0d04372:	2a00      	cmp	r2, #0
c0d04374:	d02c      	beq.n	c0d043d0 <_toStringCall+0x148>
c0d04376:	ab0f      	add	r3, sp, #60	; 0x3c
        return parser_ok;
    }

    pageIdx--;

    if (pageIdx > *pageCount) {
c0d04378:	7831      	ldrb	r1, [r6, #0]
    pageIdx--;
c0d0437a:	1e55      	subs	r5, r2, #1
c0d0437c:	b2ea      	uxtb	r2, r5
c0d0437e:	2003      	movs	r0, #3
    if (pageIdx > *pageCount) {
c0d04380:	428a      	cmp	r2, r1
c0d04382:	d845      	bhi.n	c0d04410 <_toStringCall+0x188>
c0d04384:	7819      	ldrb	r1, [r3, #0]
c0d04386:	2900      	cmp	r1, #0
c0d04388:	d042      	beq.n	c0d04410 <_toStringCall+0x188>
c0d0438a:	9006      	str	r0, [sp, #24]
c0d0438c:	2700      	movs	r7, #0
c0d0438e:	9708      	str	r7, [sp, #32]
c0d04390:	9e08      	ldr	r6, [sp, #32]
c0d04392:	ac0e      	add	r4, sp, #56	; 0x38
        return parser_display_idx_out_of_range;
    }

    for (uint8_t i = 0; i < callNumItems; i++) {
        uint8_t itemPages = 0;
c0d04394:	7026      	strb	r6, [r4, #0]
c0d04396:	9809      	ldr	r0, [sp, #36]	; 0x24
        _getMethod_ItemValue(*v->_txVerPtr, &_txObj.method, v->callIndex.moduleIdx, v->callIndex.idx, i,
c0d04398:	7843      	ldrb	r3, [r0, #1]
c0d0439a:	7802      	ldrb	r2, [r0, #0]
c0d0439c:	6840      	ldr	r0, [r0, #4]
c0d0439e:	6800      	ldr	r0, [r0, #0]
c0d043a0:	b2f9      	uxtb	r1, r7
c0d043a2:	9107      	str	r1, [sp, #28]
c0d043a4:	9100      	str	r1, [sp, #0]
c0d043a6:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d043a8:	9101      	str	r1, [sp, #4]
c0d043aa:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d043ac:	9102      	str	r1, [sp, #8]
c0d043ae:	9603      	str	r6, [sp, #12]
c0d043b0:	9404      	str	r4, [sp, #16]
c0d043b2:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d043b4:	f7ff f89f 	bl	c0d034f6 <_getMethod_ItemValue>
            outValue, outValueLen, 0, &itemPages);

        if (pageIdx < itemPages) {
c0d043b8:	7820      	ldrb	r0, [r4, #0]
c0d043ba:	b2e9      	uxtb	r1, r5
c0d043bc:	4281      	cmp	r1, r0
c0d043be:	d315      	bcc.n	c0d043ec <_toStringCall+0x164>
            _getMethod_ItemValue(*v->_txVerPtr, &_txObj.method, v->callIndex.moduleIdx, v->callIndex.idx, i,
                outValue, outValueLen, pageIdx, &tmp);
            return parser_ok;
        }

        pageIdx -= itemPages;
c0d043c0:	1a2d      	subs	r5, r5, r0
    for (uint8_t i = 0; i < callNumItems; i++) {
c0d043c2:	1c7f      	adds	r7, r7, #1
c0d043c4:	a80f      	add	r0, sp, #60	; 0x3c
c0d043c6:	7800      	ldrb	r0, [r0, #0]
c0d043c8:	4287      	cmp	r7, r0
c0d043ca:	d3e2      	bcc.n	c0d04392 <_toStringCall+0x10a>
c0d043cc:	9806      	ldr	r0, [sp, #24]
c0d043ce:	e01f      	b.n	c0d04410 <_toStringCall+0x188>
        snprintf(outValue, outValueLen, "%s", _getMethod_Name(*v->_txVerPtr, v->callIndex.moduleIdx, v->callIndex.idx));
c0d043d0:	7862      	ldrb	r2, [r4, #1]
c0d043d2:	7821      	ldrb	r1, [r4, #0]
c0d043d4:	6860      	ldr	r0, [r4, #4]
c0d043d6:	6800      	ldr	r0, [r0, #0]
c0d043d8:	f7ff f878 	bl	c0d034cc <_getMethod_Name>
c0d043dc:	4603      	mov	r3, r0
c0d043de:	4a0d      	ldr	r2, [pc, #52]	; (c0d04414 <_toStringCall+0x18c>)
c0d043e0:	447a      	add	r2, pc
c0d043e2:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d043e4:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d043e6:	f7fd fec3 	bl	c0d02170 <snprintf>
c0d043ea:	e010      	b.n	c0d0440e <_toStringCall+0x186>
c0d043ec:	9809      	ldr	r0, [sp, #36]	; 0x24
            _getMethod_ItemValue(*v->_txVerPtr, &_txObj.method, v->callIndex.moduleIdx, v->callIndex.idx, i,
c0d043ee:	7843      	ldrb	r3, [r0, #1]
c0d043f0:	7802      	ldrb	r2, [r0, #0]
c0d043f2:	6840      	ldr	r0, [r0, #4]
c0d043f4:	6800      	ldr	r0, [r0, #0]
c0d043f6:	ac0d      	add	r4, sp, #52	; 0x34
c0d043f8:	9d07      	ldr	r5, [sp, #28]
c0d043fa:	9500      	str	r5, [sp, #0]
c0d043fc:	9d0b      	ldr	r5, [sp, #44]	; 0x2c
c0d043fe:	9501      	str	r5, [sp, #4]
c0d04400:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d04402:	9502      	str	r5, [sp, #8]
c0d04404:	9103      	str	r1, [sp, #12]
c0d04406:	9404      	str	r4, [sp, #16]
c0d04408:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d0440a:	f7ff f874 	bl	c0d034f6 <_getMethod_ItemValue>
c0d0440e:	2000      	movs	r0, #0
    }

    return parser_display_idx_out_of_range;
}
c0d04410:	b037      	add	sp, #220	; 0xdc
c0d04412:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d04414:	000034aa 	.word	0x000034aa

c0d04418 <_toStringVecCall>:
    const pd_VecCall_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d04418:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0441a:	b0b3      	sub	sp, #204	; 0xcc
c0d0441c:	9307      	str	r3, [sp, #28]
c0d0441e:	4607      	mov	r7, r0
c0d04420:	9108      	str	r1, [sp, #32]
    CLEAN_AND_CHECK()
c0d04422:	4608      	mov	r0, r1
c0d04424:	9209      	str	r2, [sp, #36]	; 0x24
c0d04426:	4611      	mov	r1, r2
c0d04428:	f002 ff84 	bl	c0d07334 <explicit_bzero>
c0d0442c:	9838      	ldr	r0, [sp, #224]	; 0xe0
c0d0442e:	2400      	movs	r4, #0
c0d04430:	9006      	str	r0, [sp, #24]
c0d04432:	7004      	strb	r4, [r0, #0]
c0d04434:	ad10      	add	r5, sp, #64	; 0x40
c0d04436:	2f00      	cmp	r7, #0
c0d04438:	d045      	beq.n	c0d044c6 <_toStringVecCall+0xae>
c0d0443a:	3574      	adds	r5, #116	; 0x74
    uint8_t chunkPageCount;
    uint16_t currentPage, currentTotalPage = 0;
    /* We need to do it twice because there is no memory to keep intermediate results*/
    /* First count*/
    parser_context_t ctx;
    parser_init(&ctx, v->_ptr, v->_lenBuffer);
c0d0443c:	8a3a      	ldrh	r2, [r7, #16]
c0d0443e:	68b9      	ldr	r1, [r7, #8]
c0d04440:	a82f      	add	r0, sp, #188	; 0xbc
c0d04442:	f7fe fb39 	bl	c0d02ab8 <parser_init>
c0d04446:	2174      	movs	r1, #116	; 0x74
c0d04448:	a810      	add	r0, sp, #64	; 0x40
c0d0444a:	9105      	str	r1, [sp, #20]
    _txObj.transactionVersion = v->callTxVersion;
    _call._txVerPtr = &v->callTxVersion;
    _call.nestCallIdx.isTail = true;

    ctx.tx_obj->nestCallIdx.slotIdx = 0;
    ctx.tx_obj->nestCallIdx._lenBuffer = 0;
c0d0444c:	5444      	strb	r4, [r0, r1]
c0d0444e:	a90a      	add	r1, sp, #40	; 0x28
c0d04450:	2201      	movs	r2, #1
    _call.nestCallIdx.isTail = true;
c0d04452:	754a      	strb	r2, [r1, #21]
c0d04454:	9204      	str	r2, [sp, #16]
    ctx.tx_obj->nestCallIdx._ptr = NULL;
    ctx.tx_obj->nestCallIdx._nextPtr = NULL;
    ctx.tx_obj->nestCallIdx.isTail = true;
c0d04456:	706a      	strb	r2, [r5, #1]
    ctx.tx_obj = &_txObj;
c0d04458:	9031      	str	r0, [sp, #196]	; 0xc4
    ctx.tx_obj->nestCallIdx._lenBuffer = 0;
c0d0445a:	942a      	str	r4, [sp, #168]	; 0xa8
c0d0445c:	942b      	str	r4, [sp, #172]	; 0xac
c0d0445e:	942c      	str	r4, [sp, #176]	; 0xb0
    _txObj.transactionVersion = v->callTxVersion;
c0d04460:	4638      	mov	r0, r7
c0d04462:	3018      	adds	r0, #24
    _call._txVerPtr = &v->callTxVersion;
c0d04464:	900b      	str	r0, [sp, #44]	; 0x2c
    _txObj.transactionVersion = v->callTxVersion;
c0d04466:	69b8      	ldr	r0, [r7, #24]
c0d04468:	9027      	str	r0, [sp, #156]	; 0x9c

    for (uint16_t i = 0; i < v->_len; i++) {
c0d0446a:	cf03      	ldmia	r7!, {r0, r1}
c0d0446c:	3f08      	subs	r7, #8
c0d0446e:	4301      	orrs	r1, r0
c0d04470:	d02b      	beq.n	c0d044ca <_toStringVecCall+0xb2>
        ctx.tx_obj->nestCallIdx._ptr = NULL;
        ctx.tx_obj->nestCallIdx._nextPtr = NULL;
        ctx.tx_obj->nestCallIdx.slotIdx = 0;
c0d04472:	702c      	strb	r4, [r5, #0]
        ctx.tx_obj->nestCallIdx._nextPtr = NULL;
c0d04474:	942c      	str	r4, [sp, #176]	; 0xb0
        ctx.tx_obj->nestCallIdx._ptr = NULL;
c0d04476:	942b      	str	r4, [sp, #172]	; 0xac
c0d04478:	ae10      	add	r6, sp, #64	; 0x40
c0d0447a:	3608      	adds	r6, #8
c0d0447c:	a82f      	add	r0, sp, #188	; 0xbc
c0d0447e:	a90a      	add	r1, sp, #40	; 0x28
        CHECK_ERROR(_readCallImpl(&ctx, &_call, (pd_MethodNested_t*)&_txObj.method));
c0d04480:	4632      	mov	r2, r6
c0d04482:	f7ff fce7 	bl	c0d03e54 <_readCallImpl>
c0d04486:	2800      	cmp	r0, #0
c0d04488:	d165      	bne.n	c0d04556 <_toStringVecCall+0x13e>
c0d0448a:	a832      	add	r0, sp, #200	; 0xc8
        CHECK_ERROR(_toStringCall(&_call, outValue, outValueLen, 0, &chunkPageCount));
c0d0448c:	9000      	str	r0, [sp, #0]
c0d0448e:	a80a      	add	r0, sp, #40	; 0x28
c0d04490:	2500      	movs	r5, #0
c0d04492:	9908      	ldr	r1, [sp, #32]
c0d04494:	9a09      	ldr	r2, [sp, #36]	; 0x24
c0d04496:	462b      	mov	r3, r5
c0d04498:	f7ff fef6 	bl	c0d04288 <_toStringCall>
c0d0449c:	2800      	cmp	r0, #0
c0d0449e:	d15a      	bne.n	c0d04556 <_toStringVecCall+0x13e>
c0d044a0:	9a06      	ldr	r2, [sp, #24]
        (*pageCount) += chunkPageCount;
c0d044a2:	7810      	ldrb	r0, [r2, #0]
c0d044a4:	9932      	ldr	r1, [sp, #200]	; 0xc8
c0d044a6:	1840      	adds	r0, r0, r1
c0d044a8:	7010      	strb	r0, [r2, #0]
    for (uint16_t i = 0; i < v->_len; i++) {
c0d044aa:	cf03      	ldmia	r7!, {r0, r1}
c0d044ac:	1c64      	adds	r4, r4, #1
c0d044ae:	b2a2      	uxth	r2, r4
c0d044b0:	3f08      	subs	r7, #8
c0d044b2:	1a10      	subs	r0, r2, r0
c0d044b4:	4628      	mov	r0, r5
c0d044b6:	4188      	sbcs	r0, r1
c0d044b8:	d207      	bcs.n	c0d044ca <_toStringVecCall+0xb2>
        ctx.tx_obj->nestCallIdx._ptr = NULL;
c0d044ba:	9831      	ldr	r0, [sp, #196]	; 0xc4
        ctx.tx_obj->nestCallIdx.slotIdx = 0;
c0d044bc:	9905      	ldr	r1, [sp, #20]
c0d044be:	5445      	strb	r5, [r0, r1]
        ctx.tx_obj->nestCallIdx._ptr = NULL;
c0d044c0:	66c5      	str	r5, [r0, #108]	; 0x6c
        ctx.tx_obj->nestCallIdx._nextPtr = NULL;
c0d044c2:	6705      	str	r5, [r0, #112]	; 0x70
c0d044c4:	e7da      	b.n	c0d0447c <_toStringVecCall+0x64>
c0d044c6:	2001      	movs	r0, #1
c0d044c8:	e045      	b.n	c0d04556 <_toStringVecCall+0x13e>
    }

    /* Then iterate until we can print the corresponding chunk*/
    parser_init(&ctx, v->_ptr, v->_lenBuffer);
c0d044ca:	8a3a      	ldrh	r2, [r7, #16]
c0d044cc:	68b9      	ldr	r1, [r7, #8]
c0d044ce:	a82f      	add	r0, sp, #188	; 0xbc
c0d044d0:	f7fe faf2 	bl	c0d02ab8 <parser_init>
    for (uint16_t i = 0; i < v->_len; i++) {
c0d044d4:	cf03      	ldmia	r7!, {r0, r1}
c0d044d6:	2213      	movs	r2, #19
c0d044d8:	3f08      	subs	r7, #8
c0d044da:	4301      	orrs	r1, r0
c0d044dc:	d038      	beq.n	c0d04550 <_toStringVecCall+0x138>
c0d044de:	9202      	str	r2, [sp, #8]
c0d044e0:	ac10      	add	r4, sp, #64	; 0x40
c0d044e2:	3408      	adds	r4, #8
c0d044e4:	2600      	movs	r6, #0
c0d044e6:	9606      	str	r6, [sp, #24]
c0d044e8:	4635      	mov	r5, r6
c0d044ea:	9403      	str	r4, [sp, #12]
        ctx.tx_obj->nestCallIdx._ptr = NULL;
c0d044ec:	9831      	ldr	r0, [sp, #196]	; 0xc4
        ctx.tx_obj->nestCallIdx._nextPtr = NULL;
        ctx.tx_obj->nestCallIdx.slotIdx = 0;
c0d044ee:	9905      	ldr	r1, [sp, #20]
c0d044f0:	5446      	strb	r6, [r0, r1]
        ctx.tx_obj->nestCallIdx._ptr = NULL;
c0d044f2:	66c6      	str	r6, [r0, #108]	; 0x6c
        ctx.tx_obj->nestCallIdx._nextPtr = NULL;
c0d044f4:	6706      	str	r6, [r0, #112]	; 0x70
c0d044f6:	a82f      	add	r0, sp, #188	; 0xbc
c0d044f8:	a90a      	add	r1, sp, #40	; 0x28
        CHECK_ERROR(_readCallImpl(&ctx, &_call, (pd_MethodNested_t*)&_txObj.method));
c0d044fa:	4622      	mov	r2, r4
c0d044fc:	f7ff fcaa 	bl	c0d03e54 <_readCallImpl>
c0d04500:	2800      	cmp	r0, #0
c0d04502:	d128      	bne.n	c0d04556 <_toStringVecCall+0x13e>
c0d04504:	a832      	add	r0, sp, #200	; 0xc8
        chunkPageCount = 1;
c0d04506:	9904      	ldr	r1, [sp, #16]
c0d04508:	7001      	strb	r1, [r0, #0]
c0d0450a:	2400      	movs	r4, #0
c0d0450c:	a832      	add	r0, sp, #200	; 0xc8
        currentPage = 0;
        while (currentPage < chunkPageCount) {
            CHECK_ERROR(_toStringCall(&_call, outValue, outValueLen, currentPage, &chunkPageCount));
c0d0450e:	9000      	str	r0, [sp, #0]
c0d04510:	b2e3      	uxtb	r3, r4
c0d04512:	a80a      	add	r0, sp, #40	; 0x28
c0d04514:	9908      	ldr	r1, [sp, #32]
c0d04516:	9a09      	ldr	r2, [sp, #36]	; 0x24
c0d04518:	f7ff feb6 	bl	c0d04288 <_toStringCall>
c0d0451c:	2800      	cmp	r0, #0
c0d0451e:	d11a      	bne.n	c0d04556 <_toStringVecCall+0x13e>
            if (currentTotalPage == pageIdx) {
c0d04520:	b2a8      	uxth	r0, r5
c0d04522:	9907      	ldr	r1, [sp, #28]
c0d04524:	4288      	cmp	r0, r1
c0d04526:	d015      	beq.n	c0d04554 <_toStringVecCall+0x13c>
                return parser_ok;
            }
            currentPage++;
            currentTotalPage++;
c0d04528:	1c6d      	adds	r5, r5, #1
c0d0452a:	a832      	add	r0, sp, #200	; 0xc8
        while (currentPage < chunkPageCount) {
c0d0452c:	7800      	ldrb	r0, [r0, #0]
            currentPage++;
c0d0452e:	1c64      	adds	r4, r4, #1
c0d04530:	b2a1      	uxth	r1, r4
        while (currentPage < chunkPageCount) {
c0d04532:	4281      	cmp	r1, r0
c0d04534:	d3ea      	bcc.n	c0d0450c <_toStringVecCall+0xf4>
    for (uint16_t i = 0; i < v->_len; i++) {
c0d04536:	cf03      	ldmia	r7!, {r0, r1}
c0d04538:	9a06      	ldr	r2, [sp, #24]
c0d0453a:	1c52      	adds	r2, r2, #1
c0d0453c:	9206      	str	r2, [sp, #24]
c0d0453e:	b292      	uxth	r2, r2
c0d04540:	2300      	movs	r3, #0
c0d04542:	3f08      	subs	r7, #8
c0d04544:	1a10      	subs	r0, r2, r0
c0d04546:	418b      	sbcs	r3, r1
c0d04548:	9c03      	ldr	r4, [sp, #12]
c0d0454a:	d3cf      	bcc.n	c0d044ec <_toStringVecCall+0xd4>
c0d0454c:	9802      	ldr	r0, [sp, #8]
c0d0454e:	e002      	b.n	c0d04556 <_toStringVecCall+0x13e>
c0d04550:	4610      	mov	r0, r2
c0d04552:	e000      	b.n	c0d04556 <_toStringVecCall+0x13e>
c0d04554:	2000      	movs	r0, #0
        }
    }

    return parser_print_not_supported;
}
c0d04556:	b033      	add	sp, #204	; 0xcc
c0d04558:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d0455c <_toStringCompactBalanceOf>:
    const pd_CompactBalanceOf_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d0455c:	b5b0      	push	{r4, r5, r7, lr}
c0d0455e:	b084      	sub	sp, #16
c0d04560:	460c      	mov	r4, r1
c0d04562:	9908      	ldr	r1, [sp, #32]
    CHECK_ERROR(_toStringCompactInt(&v->value, COIN_AMOUNT_DECIMAL_PLACES, 0, COIN_TICKER, outValue, outValueLen, pageIdx, pageCount))
c0d04564:	9400      	str	r4, [sp, #0]
c0d04566:	9201      	str	r2, [sp, #4]
c0d04568:	9302      	str	r3, [sp, #8]
c0d0456a:	9103      	str	r1, [sp, #12]
c0d0456c:	2106      	movs	r1, #6
c0d0456e:	2500      	movs	r5, #0
c0d04570:	4b1b      	ldr	r3, [pc, #108]	; (c0d045e0 <_toStringCompactBalanceOf+0x84>)
c0d04572:	447b      	add	r3, pc
c0d04574:	462a      	mov	r2, r5
c0d04576:	f7fe fbf7 	bl	c0d02d68 <_toStringCompactInt>
c0d0457a:	4601      	mov	r1, r0
c0d0457c:	2800      	cmp	r0, #0
c0d0457e:	d127      	bne.n	c0d045d0 <_toStringCompactBalanceOf+0x74>
    const size_t len = strlen(s);
c0d04580:	4620      	mov	r0, r4
c0d04582:	f003 f867 	bl	c0d07654 <strlen>
    if (len == 0 || len == 1 || len > 1024) {
c0d04586:	1e81      	subs	r1, r0, #2
c0d04588:	4a13      	ldr	r2, [pc, #76]	; (c0d045d8 <_toStringCompactBalanceOf+0x7c>)
c0d0458a:	4291      	cmp	r1, r2
c0d0458c:	4629      	mov	r1, r5
c0d0458e:	d81f      	bhi.n	c0d045d0 <_toStringCompactBalanceOf+0x74>
c0d04590:	4912      	ldr	r1, [pc, #72]	; (c0d045dc <_toStringCompactBalanceOf+0x80>)
c0d04592:	2300      	movs	r3, #0
c0d04594:	461a      	mov	r2, r3
        if (s[i] == '.') {
c0d04596:	5ce3      	ldrb	r3, [r4, r3]
c0d04598:	2b2e      	cmp	r3, #46	; 0x2e
c0d0459a:	4613      	mov	r3, r2
c0d0459c:	d000      	beq.n	c0d045a0 <_toStringCompactBalanceOf+0x44>
c0d0459e:	460b      	mov	r3, r1
c0d045a0:	b219      	sxth	r1, r3
    for (int16_t i = 0; i < (int16_t) len && dec_point < 0; i++) {
c0d045a2:	1c52      	adds	r2, r2, #1
c0d045a4:	b213      	sxth	r3, r2
c0d045a6:	4298      	cmp	r0, r3
c0d045a8:	dd01      	ble.n	c0d045ae <_toStringCompactBalanceOf+0x52>
c0d045aa:	2900      	cmp	r1, #0
c0d045ac:	d4f3      	bmi.n	c0d04596 <_toStringCompactBalanceOf+0x3a>
c0d045ae:	2200      	movs	r2, #0
    if (dec_point < 0) {
c0d045b0:	2900      	cmp	r1, #0
c0d045b2:	d40c      	bmi.n	c0d045ce <_toStringCompactBalanceOf+0x72>
c0d045b4:	1e40      	subs	r0, r0, #1
c0d045b6:	1c4b      	adds	r3, r1, #1
c0d045b8:	4298      	cmp	r0, r3
c0d045ba:	d908      	bls.n	c0d045ce <_toStringCompactBalanceOf+0x72>
    for (size_t i = (len - 1); i > limit && s[i] == '0'; i--) {
c0d045bc:	5c21      	ldrb	r1, [r4, r0]
c0d045be:	2930      	cmp	r1, #48	; 0x30
c0d045c0:	d105      	bne.n	c0d045ce <_toStringCompactBalanceOf+0x72>
c0d045c2:	2100      	movs	r1, #0
        s[i] = 0;
c0d045c4:	5421      	strb	r1, [r4, r0]
c0d045c6:	1e40      	subs	r0, r0, #1
    for (size_t i = (len - 1); i > limit && s[i] == '0'; i--) {
c0d045c8:	4298      	cmp	r0, r3
c0d045ca:	d8f7      	bhi.n	c0d045bc <_toStringCompactBalanceOf+0x60>
c0d045cc:	e000      	b.n	c0d045d0 <_toStringCompactBalanceOf+0x74>
c0d045ce:	4611      	mov	r1, r2
    number_inplace_trimming(outValue, 1);
    return parser_ok;
}
c0d045d0:	4608      	mov	r0, r1
c0d045d2:	b004      	add	sp, #16
c0d045d4:	bdb0      	pop	{r4, r5, r7, pc}
c0d045d6:	46c0      	nop			; (mov r8, r8)
c0d045d8:	000003fe 	.word	0x000003fe
c0d045dc:	0000ffff 	.word	0x0000ffff
c0d045e0:	00003519 	.word	0x00003519

c0d045e4 <_toStringHash>:
parser_error_t _toStringHash(
    const pd_Hash_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount) {
c0d045e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d045e6:	b085      	sub	sp, #20
c0d045e8:	9304      	str	r3, [sp, #16]
c0d045ea:	4614      	mov	r4, r2
c0d045ec:	460d      	mov	r5, r1
c0d045ee:	4606      	mov	r6, r0
    GEN_DEF_TOSTRING_ARRAY(32)
c0d045f0:	4608      	mov	r0, r1
c0d045f2:	4611      	mov	r1, r2
c0d045f4:	f002 fe9e 	bl	c0d07334 <explicit_bzero>
c0d045f8:	9f0a      	ldr	r7, [sp, #40]	; 0x28
c0d045fa:	2e00      	cmp	r6, #0
c0d045fc:	d041      	beq.n	c0d04682 <_toStringHash+0x9e>
c0d045fe:	200b      	movs	r0, #11
c0d04600:	2c00      	cmp	r4, #0
c0d04602:	d043      	beq.n	c0d0468c <_toStringHash+0xa8>
c0d04604:	6831      	ldr	r1, [r6, #0]
c0d04606:	2900      	cmp	r1, #0
c0d04608:	d040      	beq.n	c0d0468c <_toStringHash+0xa8>
c0d0460a:	9601      	str	r6, [sp, #4]
c0d0460c:	1e60      	subs	r0, r4, #1
c0d0460e:	0fc1      	lsrs	r1, r0, #31
c0d04610:	1840      	adds	r0, r0, r1
c0d04612:	1046      	asrs	r6, r0, #1
c0d04614:	b2b1      	uxth	r1, r6
c0d04616:	2020      	movs	r0, #32
c0d04618:	9003      	str	r0, [sp, #12]
c0d0461a:	f002 fce3 	bl	c0d06fe4 <__udivsi3>
c0d0461e:	4631      	mov	r1, r6
c0d04620:	4341      	muls	r1, r0
c0d04622:	b289      	uxth	r1, r1
c0d04624:	2920      	cmp	r1, #32
c0d04626:	d000      	beq.n	c0d0462a <_toStringHash+0x46>
c0d04628:	1c40      	adds	r0, r0, #1
c0d0462a:	9904      	ldr	r1, [sp, #16]
c0d0462c:	9b03      	ldr	r3, [sp, #12]
c0d0462e:	7038      	strb	r0, [r7, #0]
c0d04630:	4371      	muls	r1, r6
c0d04632:	b28a      	uxth	r2, r1
c0d04634:	1a98      	subs	r0, r3, r2
c0d04636:	42b0      	cmp	r0, r6
c0d04638:	db00      	blt.n	c0d0463c <_toStringHash+0x58>
c0d0463a:	4630      	mov	r0, r6
c0d0463c:	b283      	uxth	r3, r0
c0d0463e:	2b00      	cmp	r3, #0
c0d04640:	d023      	beq.n	c0d0468a <_toStringHash+0xa6>
c0d04642:	2100      	movs	r1, #0
c0d04644:	4812      	ldr	r0, [pc, #72]	; (c0d04690 <_toStringHash+0xac>)
c0d04646:	4478      	add	r0, pc
c0d04648:	9004      	str	r0, [sp, #16]
c0d0464a:	4608      	mov	r0, r1
c0d0464c:	9503      	str	r5, [sp, #12]
c0d0464e:	9402      	str	r4, [sp, #8]
c0d04650:	9100      	str	r1, [sp, #0]
c0d04652:	460c      	mov	r4, r1
c0d04654:	9f01      	ldr	r7, [sp, #4]
c0d04656:	6839      	ldr	r1, [r7, #0]
c0d04658:	1889      	adds	r1, r1, r2
c0d0465a:	461d      	mov	r5, r3
c0d0465c:	5c0b      	ldrb	r3, [r1, r0]
c0d0465e:	0460      	lsls	r0, r4, #17
c0d04660:	0c01      	lsrs	r1, r0, #16
c0d04662:	9803      	ldr	r0, [sp, #12]
c0d04664:	1840      	adds	r0, r0, r1
c0d04666:	9e02      	ldr	r6, [sp, #8]
c0d04668:	1a71      	subs	r1, r6, r1
c0d0466a:	4616      	mov	r6, r2
c0d0466c:	9a04      	ldr	r2, [sp, #16]
c0d0466e:	f7fd fd7f 	bl	c0d02170 <snprintf>
c0d04672:	462b      	mov	r3, r5
c0d04674:	4632      	mov	r2, r6
c0d04676:	1c64      	adds	r4, r4, #1
c0d04678:	b2a0      	uxth	r0, r4
c0d0467a:	4285      	cmp	r5, r0
c0d0467c:	d8eb      	bhi.n	c0d04656 <_toStringHash+0x72>
c0d0467e:	9800      	ldr	r0, [sp, #0]
c0d04680:	e004      	b.n	c0d0468c <_toStringHash+0xa8>
c0d04682:	2000      	movs	r0, #0
c0d04684:	7038      	strb	r0, [r7, #0]
c0d04686:	2001      	movs	r0, #1
c0d04688:	e000      	b.n	c0d0468c <_toStringHash+0xa8>
c0d0468a:	2000      	movs	r0, #0
}
c0d0468c:	b005      	add	sp, #20
c0d0468e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d04690:	000036ba 	.word	0x000036ba

c0d04694 <_readAccountId_V1>:
{
    return _readCompactInt(c, v);
}

parser_error_t _readAccountId_V1(parser_context_t* c, pd_AccountId_V1_t* v) {
    GEN_DEF_READARRAY(32)
c0d04694:	88c2      	ldrh	r2, [r0, #6]
c0d04696:	6803      	ldr	r3, [r0, #0]
c0d04698:	189b      	adds	r3, r3, r2
c0d0469a:	600b      	str	r3, [r1, #0]
c0d0469c:	3220      	adds	r2, #32
c0d0469e:	8881      	ldrh	r1, [r0, #4]
c0d046a0:	428a      	cmp	r2, r1
c0d046a2:	d901      	bls.n	c0d046a8 <_readAccountId_V1+0x14>
c0d046a4:	200b      	movs	r0, #11
}
c0d046a6:	4770      	bx	lr
    GEN_DEF_READARRAY(32)
c0d046a8:	80c2      	strh	r2, [r0, #6]
c0d046aa:	2000      	movs	r0, #0
}
c0d046ac:	4770      	bx	lr

c0d046ae <_readEraIndex_V1>:
    CHECK_ERROR(_readCompactInt(c, &v->nominators));
    return parser_ok;
}

parser_error_t _readEraIndex_V1(parser_context_t* c, pd_EraIndex_V1_t* v)
{
c0d046ae:	b580      	push	{r7, lr}
    return _readUInt32(c, &v->value);
c0d046b0:	f7fe fac7 	bl	c0d02c42 <_readUInt32>
c0d046b4:	bd80      	pop	{r7, pc}

c0d046b6 <_readKeys_V1>:
parser_error_t _readKey_V1(parser_context_t* c, pd_Key_V1_t* v) {
    GEN_DEF_READARRAY(32)
}

parser_error_t _readKeys_V1(parser_context_t* c, pd_Keys_V1_t* v) {
    GEN_DEF_READARRAY(6 * 32)
c0d046b6:	88c2      	ldrh	r2, [r0, #6]
c0d046b8:	6803      	ldr	r3, [r0, #0]
c0d046ba:	189b      	adds	r3, r3, r2
c0d046bc:	600b      	str	r3, [r1, #0]
c0d046be:	32c0      	adds	r2, #192	; 0xc0
c0d046c0:	8881      	ldrh	r1, [r0, #4]
c0d046c2:	428a      	cmp	r2, r1
c0d046c4:	d901      	bls.n	c0d046ca <_readKeys_V1+0x14>
c0d046c6:	200b      	movs	r0, #11
}
c0d046c8:	4770      	bx	lr
    GEN_DEF_READARRAY(6 * 32)
c0d046ca:	80c2      	strh	r2, [r0, #6]
c0d046cc:	2000      	movs	r0, #0
}
c0d046ce:	4770      	bx	lr

c0d046d0 <_readLookupSource_V1>:

parser_error_t _readLookupSource_V1(parser_context_t* c, pd_LookupSource_V1_t* v)
{
c0d046d0:	b570      	push	{r4, r5, r6, lr}
    CHECK_INPUT();
c0d046d2:	2900      	cmp	r1, #0
c0d046d4:	d011      	beq.n	c0d046fa <_readLookupSource_V1+0x2a>
c0d046d6:	4604      	mov	r4, r0
c0d046d8:	260b      	movs	r6, #11
c0d046da:	2800      	cmp	r0, #0
c0d046dc:	d00b      	beq.n	c0d046f6 <_readLookupSource_V1+0x26>
c0d046de:	460d      	mov	r5, r1
c0d046e0:	88a0      	ldrh	r0, [r4, #4]
c0d046e2:	88e1      	ldrh	r1, [r4, #6]
c0d046e4:	4281      	cmp	r1, r0
c0d046e6:	d206      	bcs.n	c0d046f6 <_readLookupSource_V1+0x26>
    CHECK_ERROR(_readUInt8(c, &v->value))
c0d046e8:	4620      	mov	r0, r4
c0d046ea:	4629      	mov	r1, r5
c0d046ec:	f7fe fa94 	bl	c0d02c18 <_readUInt8>
c0d046f0:	2800      	cmp	r0, #0
c0d046f2:	d004      	beq.n	c0d046fe <_readLookupSource_V1+0x2e>
    default:
        return parser_unexpected_value;
    }

    return parser_ok;
}
c0d046f4:	bd70      	pop	{r4, r5, r6, pc}
c0d046f6:	4630      	mov	r0, r6
c0d046f8:	bd70      	pop	{r4, r5, r6, pc}
c0d046fa:	2001      	movs	r0, #1
c0d046fc:	bd70      	pop	{r4, r5, r6, pc}
    switch (v->value) {
c0d046fe:	7829      	ldrb	r1, [r5, #0]
c0d04700:	200c      	movs	r0, #12
c0d04702:	2901      	cmp	r1, #1
c0d04704:	dd0c      	ble.n	c0d04720 <_readLookupSource_V1+0x50>
c0d04706:	2902      	cmp	r1, #2
c0d04708:	d014      	beq.n	c0d04734 <_readLookupSource_V1+0x64>
c0d0470a:	2903      	cmp	r1, #3
c0d0470c:	d01a      	beq.n	c0d04744 <_readLookupSource_V1+0x74>
c0d0470e:	2904      	cmp	r1, #4
c0d04710:	d1f0      	bne.n	c0d046f4 <_readLookupSource_V1+0x24>
        GEN_DEF_READARRAY(20)
c0d04712:	88e0      	ldrh	r0, [r4, #6]
c0d04714:	6821      	ldr	r1, [r4, #0]
c0d04716:	1808      	adds	r0, r1, r0
c0d04718:	60a8      	str	r0, [r5, #8]
c0d0471a:	88e1      	ldrh	r1, [r4, #6]
c0d0471c:	3114      	adds	r1, #20
c0d0471e:	e01c      	b.n	c0d0475a <_readLookupSource_V1+0x8a>
    switch (v->value) {
c0d04720:	2900      	cmp	r1, #0
c0d04722:	d015      	beq.n	c0d04750 <_readLookupSource_V1+0x80>
c0d04724:	2901      	cmp	r1, #1
c0d04726:	d1e5      	bne.n	c0d046f4 <_readLookupSource_V1+0x24>
        CHECK_ERROR(_readCompactAccountIndex_V1(c, &v->index))
c0d04728:	3508      	adds	r5, #8
    return _readCompactInt(c, &v->value);
c0d0472a:	4620      	mov	r0, r4
c0d0472c:	4629      	mov	r1, r5
c0d0472e:	f7fe faa2 	bl	c0d02c76 <_readCompactInt>
c0d04732:	e004      	b.n	c0d0473e <_readLookupSource_V1+0x6e>
        CHECK_ERROR(_readBytes(c, &v->raw))
c0d04734:	3508      	adds	r5, #8
c0d04736:	4620      	mov	r0, r4
c0d04738:	4629      	mov	r1, r5
c0d0473a:	f7ff fbd0 	bl	c0d03ede <_readBytes>
c0d0473e:	2800      	cmp	r0, #0
c0d04740:	d1d8      	bne.n	c0d046f4 <_readLookupSource_V1+0x24>
c0d04742:	e00f      	b.n	c0d04764 <_readLookupSource_V1+0x94>
        GEN_DEF_READARRAY(32)
c0d04744:	88e0      	ldrh	r0, [r4, #6]
c0d04746:	6821      	ldr	r1, [r4, #0]
c0d04748:	1808      	adds	r0, r1, r0
c0d0474a:	60a8      	str	r0, [r5, #8]
c0d0474c:	88e1      	ldrh	r1, [r4, #6]
c0d0474e:	e003      	b.n	c0d04758 <_readLookupSource_V1+0x88>
    GEN_DEF_READARRAY(32)
c0d04750:	88e1      	ldrh	r1, [r4, #6]
c0d04752:	6820      	ldr	r0, [r4, #0]
c0d04754:	1840      	adds	r0, r0, r1
c0d04756:	60a8      	str	r0, [r5, #8]
c0d04758:	3120      	adds	r1, #32
c0d0475a:	88a0      	ldrh	r0, [r4, #4]
c0d0475c:	4281      	cmp	r1, r0
c0d0475e:	4630      	mov	r0, r6
c0d04760:	d8c8      	bhi.n	c0d046f4 <_readLookupSource_V1+0x24>
c0d04762:	80e1      	strh	r1, [r4, #6]
c0d04764:	2000      	movs	r0, #0
}
c0d04766:	bd70      	pop	{r4, r5, r6, pc}

c0d04768 <_readRewardDestination_V1>:
{
    return parser_not_supported;
}

parser_error_t _readRewardDestination_V1(parser_context_t* c, pd_RewardDestination_V1_t* v)
{
c0d04768:	b510      	push	{r4, lr}
c0d0476a:	460c      	mov	r4, r1
    CHECK_INPUT();
c0d0476c:	2900      	cmp	r1, #0
c0d0476e:	d00e      	beq.n	c0d0478e <_readRewardDestination_V1+0x26>
c0d04770:	4601      	mov	r1, r0
c0d04772:	200b      	movs	r0, #11
c0d04774:	2900      	cmp	r1, #0
c0d04776:	d009      	beq.n	c0d0478c <_readRewardDestination_V1+0x24>
c0d04778:	888a      	ldrh	r2, [r1, #4]
c0d0477a:	88cb      	ldrh	r3, [r1, #6]
c0d0477c:	4293      	cmp	r3, r2
c0d0477e:	d205      	bcs.n	c0d0478c <_readRewardDestination_V1+0x24>

    CHECK_ERROR(_readUInt8(c, &v->value))
c0d04780:	4608      	mov	r0, r1
c0d04782:	4621      	mov	r1, r4
c0d04784:	f7fe fa48 	bl	c0d02c18 <_readUInt8>
c0d04788:	2800      	cmp	r0, #0
c0d0478a:	d002      	beq.n	c0d04792 <_readRewardDestination_V1+0x2a>
c0d0478c:	bd10      	pop	{r4, pc}
c0d0478e:	2001      	movs	r0, #1
c0d04790:	bd10      	pop	{r4, pc}
    if (v->value > 2) {
c0d04792:	7820      	ldrb	r0, [r4, #0]
c0d04794:	2802      	cmp	r0, #2
c0d04796:	d801      	bhi.n	c0d0479c <_readRewardDestination_V1+0x34>
c0d04798:	2000      	movs	r0, #0
c0d0479a:	bd10      	pop	{r4, pc}
c0d0479c:	200d      	movs	r0, #13
c0d0479e:	bd10      	pop	{r4, pc}

c0d047a0 <_readValidatorPrefs_V1>:
    CHECK_ERROR(_readUInt16(c, &v->value))
    return parser_ok;
}

parser_error_t _readValidatorPrefs_V1(parser_context_t* c, pd_ValidatorPrefs_V1_t* v)
{
c0d047a0:	b5b0      	push	{r4, r5, r7, lr}
    CHECK_INPUT();
c0d047a2:	2900      	cmp	r1, #0
c0d047a4:	d00f      	beq.n	c0d047c6 <_readValidatorPrefs_V1+0x26>
c0d047a6:	4605      	mov	r5, r0
c0d047a8:	200b      	movs	r0, #11
c0d047aa:	2d00      	cmp	r5, #0
c0d047ac:	d00a      	beq.n	c0d047c4 <_readValidatorPrefs_V1+0x24>
c0d047ae:	460c      	mov	r4, r1
c0d047b0:	88a9      	ldrh	r1, [r5, #4]
c0d047b2:	88ea      	ldrh	r2, [r5, #6]
c0d047b4:	428a      	cmp	r2, r1
c0d047b6:	d205      	bcs.n	c0d047c4 <_readValidatorPrefs_V1+0x24>
    return _readCompactInt(c, &v->value);
c0d047b8:	4628      	mov	r0, r5
c0d047ba:	4621      	mov	r1, r4
c0d047bc:	f7fe fa5b 	bl	c0d02c76 <_readCompactInt>
c0d047c0:	2800      	cmp	r0, #0
c0d047c2:	d002      	beq.n	c0d047ca <_readValidatorPrefs_V1+0x2a>
c0d047c4:	bdb0      	pop	{r4, r5, r7, pc}
c0d047c6:	2001      	movs	r0, #1
c0d047c8:	bdb0      	pop	{r4, r5, r7, pc}
    CHECK_ERROR(_readCompactPerBill_V1(c, &v->commission));
    CHECK_ERROR(_readbool(c, &v->blocked))
c0d047ca:	3408      	adds	r4, #8
c0d047cc:	4628      	mov	r0, r5
c0d047ce:	4621      	mov	r1, r4
c0d047d0:	f7ff fb38 	bl	c0d03e44 <_readbool>
c0d047d4:	bdb0      	pop	{r4, r5, r7, pc}

c0d047d6 <_readVecLookupSource_V1>:

parser_error_t _readVecKey_V1(parser_context_t* c, pd_VecKey_V1_t* v) {
    GEN_DEF_READVECTOR(Key_V1)
}

parser_error_t _readVecLookupSource_V1(parser_context_t* c, pd_VecLookupSource_V1_t* v) {
c0d047d6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d047d8:	b08b      	sub	sp, #44	; 0x2c
c0d047da:	460c      	mov	r4, r1
c0d047dc:	a902      	add	r1, sp, #8
c0d047de:	9001      	str	r0, [sp, #4]
    GEN_DEF_READVECTOR(LookupSource_V1)
c0d047e0:	f7fe fa49 	bl	c0d02c76 <_readCompactInt>
c0d047e4:	4605      	mov	r5, r0
c0d047e6:	f002 fbed 	bl	c0d06fc4 <check_app_canary>
c0d047ea:	2d00      	cmp	r5, #0
c0d047ec:	d134      	bne.n	c0d04858 <_readVecLookupSource_V1+0x82>
c0d047ee:	a802      	add	r0, sp, #8
c0d047f0:	4621      	mov	r1, r4
c0d047f2:	f7fe fa7b 	bl	c0d02cec <_getValue>
c0d047f6:	4605      	mov	r5, r0
c0d047f8:	f002 fbe4 	bl	c0d06fc4 <check_app_canary>
c0d047fc:	2d00      	cmp	r5, #0
c0d047fe:	d12b      	bne.n	c0d04858 <_readVecLookupSource_V1+0x82>
c0d04800:	2500      	movs	r5, #0
c0d04802:	6165      	str	r5, [r4, #20]
c0d04804:	9901      	ldr	r1, [sp, #4]
c0d04806:	88c8      	ldrh	r0, [r1, #6]
c0d04808:	6120      	str	r0, [r4, #16]
c0d0480a:	6809      	ldr	r1, [r1, #0]
c0d0480c:	1809      	adds	r1, r1, r0
c0d0480e:	60a1      	str	r1, [r4, #8]
c0d04810:	cc06      	ldmia	r4!, {r1, r2}
c0d04812:	3c08      	subs	r4, #8
c0d04814:	430a      	orrs	r2, r1
c0d04816:	4629      	mov	r1, r5
c0d04818:	4603      	mov	r3, r0
c0d0481a:	462a      	mov	r2, r5
c0d0481c:	d016      	beq.n	c0d0484c <_readVecLookupSource_V1+0x76>
c0d0481e:	2600      	movs	r6, #0
c0d04820:	4637      	mov	r7, r6
c0d04822:	9600      	str	r6, [sp, #0]
c0d04824:	1c7f      	adds	r7, r7, #1
c0d04826:	9800      	ldr	r0, [sp, #0]
c0d04828:	4146      	adcs	r6, r0
c0d0482a:	a904      	add	r1, sp, #16
c0d0482c:	9801      	ldr	r0, [sp, #4]
c0d0482e:	f7ff ff4f 	bl	c0d046d0 <_readLookupSource_V1>
c0d04832:	2800      	cmp	r0, #0
c0d04834:	d10f      	bne.n	c0d04856 <_readVecLookupSource_V1+0x80>
c0d04836:	cc03      	ldmia	r4!, {r0, r1}
c0d04838:	3c08      	subs	r4, #8
c0d0483a:	1a38      	subs	r0, r7, r0
c0d0483c:	4630      	mov	r0, r6
c0d0483e:	4188      	sbcs	r0, r1
c0d04840:	d3f0      	bcc.n	c0d04824 <_readVecLookupSource_V1+0x4e>
c0d04842:	9801      	ldr	r0, [sp, #4]
c0d04844:	88c0      	ldrh	r0, [r0, #6]
c0d04846:	6923      	ldr	r3, [r4, #16]
c0d04848:	6962      	ldr	r2, [r4, #20]
c0d0484a:	2100      	movs	r1, #0
c0d0484c:	1ac0      	subs	r0, r0, r3
c0d0484e:	6120      	str	r0, [r4, #16]
c0d04850:	4191      	sbcs	r1, r2
c0d04852:	6161      	str	r1, [r4, #20]
c0d04854:	e000      	b.n	c0d04858 <_readVecLookupSource_V1+0x82>
c0d04856:	4605      	mov	r5, r0
}
c0d04858:	4628      	mov	r0, r5
c0d0485a:	b00b      	add	sp, #44	; 0x2c
c0d0485c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0485e <_toStringAccountId_V1>:
    const pd_AccountId_V1_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d0485e:	b510      	push	{r4, lr}
c0d04860:	b082      	sub	sp, #8
    return _toStringPubkeyAsAddress(v->_ptr, outValue, outValueLen, pageIdx, pageCount);
c0d04862:	6800      	ldr	r0, [r0, #0]
c0d04864:	9c04      	ldr	r4, [sp, #16]
c0d04866:	9400      	str	r4, [sp, #0]
c0d04868:	f7fe fd34 	bl	c0d032d4 <_toStringPubkeyAsAddress>
c0d0486c:	b002      	add	sp, #8
c0d0486e:	bd10      	pop	{r4, pc}

c0d04870 <_toStringEraIndex_V1>:
    const pd_EraIndex_V1_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d04870:	b510      	push	{r4, lr}
c0d04872:	b082      	sub	sp, #8
c0d04874:	9c04      	ldr	r4, [sp, #16]
    return _toStringu32(&v->value, outValue, outValueLen, pageIdx, pageCount);
c0d04876:	9400      	str	r4, [sp, #0]
c0d04878:	f7ff fc1c 	bl	c0d040b4 <_toStringu32>
c0d0487c:	b002      	add	sp, #8
c0d0487e:	bd10      	pop	{r4, pc}

c0d04880 <_toStringKeys_V1>:
parser_error_t _toStringKeys_V1(
    const pd_Keys_V1_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount) {
c0d04880:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04882:	b085      	sub	sp, #20
c0d04884:	9304      	str	r3, [sp, #16]
c0d04886:	4614      	mov	r4, r2
c0d04888:	460d      	mov	r5, r1
c0d0488a:	4606      	mov	r6, r0
    GEN_DEF_TOSTRING_ARRAY(4 * 32)
c0d0488c:	4608      	mov	r0, r1
c0d0488e:	4611      	mov	r1, r2
c0d04890:	f002 fd50 	bl	c0d07334 <explicit_bzero>
c0d04894:	9f0a      	ldr	r7, [sp, #40]	; 0x28
c0d04896:	2e00      	cmp	r6, #0
c0d04898:	d041      	beq.n	c0d0491e <_toStringKeys_V1+0x9e>
c0d0489a:	200b      	movs	r0, #11
c0d0489c:	2c00      	cmp	r4, #0
c0d0489e:	d043      	beq.n	c0d04928 <_toStringKeys_V1+0xa8>
c0d048a0:	6831      	ldr	r1, [r6, #0]
c0d048a2:	2900      	cmp	r1, #0
c0d048a4:	d040      	beq.n	c0d04928 <_toStringKeys_V1+0xa8>
c0d048a6:	9601      	str	r6, [sp, #4]
c0d048a8:	1e60      	subs	r0, r4, #1
c0d048aa:	0fc1      	lsrs	r1, r0, #31
c0d048ac:	1840      	adds	r0, r0, r1
c0d048ae:	1046      	asrs	r6, r0, #1
c0d048b0:	b2b1      	uxth	r1, r6
c0d048b2:	2080      	movs	r0, #128	; 0x80
c0d048b4:	9003      	str	r0, [sp, #12]
c0d048b6:	f002 fb95 	bl	c0d06fe4 <__udivsi3>
c0d048ba:	4631      	mov	r1, r6
c0d048bc:	4341      	muls	r1, r0
c0d048be:	b289      	uxth	r1, r1
c0d048c0:	2980      	cmp	r1, #128	; 0x80
c0d048c2:	d000      	beq.n	c0d048c6 <_toStringKeys_V1+0x46>
c0d048c4:	1c40      	adds	r0, r0, #1
c0d048c6:	9904      	ldr	r1, [sp, #16]
c0d048c8:	9b03      	ldr	r3, [sp, #12]
c0d048ca:	7038      	strb	r0, [r7, #0]
c0d048cc:	4371      	muls	r1, r6
c0d048ce:	b28a      	uxth	r2, r1
c0d048d0:	1a98      	subs	r0, r3, r2
c0d048d2:	42b0      	cmp	r0, r6
c0d048d4:	db00      	blt.n	c0d048d8 <_toStringKeys_V1+0x58>
c0d048d6:	4630      	mov	r0, r6
c0d048d8:	b283      	uxth	r3, r0
c0d048da:	2b00      	cmp	r3, #0
c0d048dc:	d023      	beq.n	c0d04926 <_toStringKeys_V1+0xa6>
c0d048de:	2100      	movs	r1, #0
c0d048e0:	4812      	ldr	r0, [pc, #72]	; (c0d0492c <_toStringKeys_V1+0xac>)
c0d048e2:	4478      	add	r0, pc
c0d048e4:	9004      	str	r0, [sp, #16]
c0d048e6:	4608      	mov	r0, r1
c0d048e8:	9503      	str	r5, [sp, #12]
c0d048ea:	9402      	str	r4, [sp, #8]
c0d048ec:	9100      	str	r1, [sp, #0]
c0d048ee:	460c      	mov	r4, r1
c0d048f0:	9f01      	ldr	r7, [sp, #4]
c0d048f2:	6839      	ldr	r1, [r7, #0]
c0d048f4:	1889      	adds	r1, r1, r2
c0d048f6:	461d      	mov	r5, r3
c0d048f8:	5c0b      	ldrb	r3, [r1, r0]
c0d048fa:	0460      	lsls	r0, r4, #17
c0d048fc:	0c01      	lsrs	r1, r0, #16
c0d048fe:	9803      	ldr	r0, [sp, #12]
c0d04900:	1840      	adds	r0, r0, r1
c0d04902:	9e02      	ldr	r6, [sp, #8]
c0d04904:	1a71      	subs	r1, r6, r1
c0d04906:	4616      	mov	r6, r2
c0d04908:	9a04      	ldr	r2, [sp, #16]
c0d0490a:	f7fd fc31 	bl	c0d02170 <snprintf>
c0d0490e:	462b      	mov	r3, r5
c0d04910:	4632      	mov	r2, r6
c0d04912:	1c64      	adds	r4, r4, #1
c0d04914:	b2a0      	uxth	r0, r4
c0d04916:	4285      	cmp	r5, r0
c0d04918:	d8eb      	bhi.n	c0d048f2 <_toStringKeys_V1+0x72>
c0d0491a:	9800      	ldr	r0, [sp, #0]
c0d0491c:	e004      	b.n	c0d04928 <_toStringKeys_V1+0xa8>
c0d0491e:	2000      	movs	r0, #0
c0d04920:	7038      	strb	r0, [r7, #0]
c0d04922:	2001      	movs	r0, #1
c0d04924:	e000      	b.n	c0d04928 <_toStringKeys_V1+0xa8>
c0d04926:	2000      	movs	r0, #0
}
c0d04928:	b005      	add	sp, #20
c0d0492a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0492c:	0000341e 	.word	0x0000341e

c0d04930 <_toStringLookupSource_V1>:
    const pd_LookupSource_V1_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d04930:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04932:	b089      	sub	sp, #36	; 0x24
c0d04934:	9307      	str	r3, [sp, #28]
c0d04936:	4614      	mov	r4, r2
c0d04938:	460f      	mov	r7, r1
c0d0493a:	4605      	mov	r5, r0
    CLEAN_AND_CHECK()
c0d0493c:	4608      	mov	r0, r1
c0d0493e:	4611      	mov	r1, r2
c0d04940:	f002 fcf8 	bl	c0d07334 <explicit_bzero>
c0d04944:	9e0e      	ldr	r6, [sp, #56]	; 0x38
c0d04946:	2d00      	cmp	r5, #0
c0d04948:	d04e      	beq.n	c0d049e8 <_toStringLookupSource_V1+0xb8>
    switch (v->value) {
c0d0494a:	7829      	ldrb	r1, [r5, #0]
c0d0494c:	2006      	movs	r0, #6
c0d0494e:	2901      	cmp	r1, #1
c0d04950:	dd4e      	ble.n	c0d049f0 <_toStringLookupSource_V1+0xc0>
c0d04952:	2902      	cmp	r1, #2
c0d04954:	d05e      	beq.n	c0d04a14 <_toStringLookupSource_V1+0xe4>
c0d04956:	2903      	cmp	r1, #3
c0d04958:	d065      	beq.n	c0d04a26 <_toStringLookupSource_V1+0xf6>
c0d0495a:	2904      	cmp	r1, #4
c0d0495c:	d000      	beq.n	c0d04960 <_toStringLookupSource_V1+0x30>
c0d0495e:	e0b2      	b.n	c0d04ac6 <_toStringLookupSource_V1+0x196>
    {
        GEN_DEF_TOSTRING_ARRAY(32)
    }
    case 4: // Address20
    {
        GEN_DEF_TOSTRING_ARRAY(20)
c0d04960:	4638      	mov	r0, r7
c0d04962:	4621      	mov	r1, r4
c0d04964:	f002 fce6 	bl	c0d07334 <explicit_bzero>
c0d04968:	200b      	movs	r0, #11
c0d0496a:	2c00      	cmp	r4, #0
c0d0496c:	d100      	bne.n	c0d04970 <_toStringLookupSource_V1+0x40>
c0d0496e:	e0aa      	b.n	c0d04ac6 <_toStringLookupSource_V1+0x196>
c0d04970:	68a9      	ldr	r1, [r5, #8]
c0d04972:	2900      	cmp	r1, #0
c0d04974:	d100      	bne.n	c0d04978 <_toStringLookupSource_V1+0x48>
c0d04976:	e0a6      	b.n	c0d04ac6 <_toStringLookupSource_V1+0x196>
c0d04978:	9708      	str	r7, [sp, #32]
c0d0497a:	1e60      	subs	r0, r4, #1
c0d0497c:	0fc1      	lsrs	r1, r0, #31
c0d0497e:	1840      	adds	r0, r0, r1
c0d04980:	1047      	asrs	r7, r0, #1
c0d04982:	b2b9      	uxth	r1, r7
c0d04984:	2014      	movs	r0, #20
c0d04986:	9006      	str	r0, [sp, #24]
c0d04988:	f002 fb2c 	bl	c0d06fe4 <__udivsi3>
c0d0498c:	4639      	mov	r1, r7
c0d0498e:	4341      	muls	r1, r0
c0d04990:	b289      	uxth	r1, r1
c0d04992:	2914      	cmp	r1, #20
c0d04994:	d000      	beq.n	c0d04998 <_toStringLookupSource_V1+0x68>
c0d04996:	1c40      	adds	r0, r0, #1
c0d04998:	9907      	ldr	r1, [sp, #28]
c0d0499a:	9b06      	ldr	r3, [sp, #24]
c0d0499c:	7030      	strb	r0, [r6, #0]
c0d0499e:	4379      	muls	r1, r7
c0d049a0:	b28a      	uxth	r2, r1
c0d049a2:	1a98      	subs	r0, r3, r2
c0d049a4:	42b8      	cmp	r0, r7
c0d049a6:	db00      	blt.n	c0d049aa <_toStringLookupSource_V1+0x7a>
c0d049a8:	4638      	mov	r0, r7
c0d049aa:	b286      	uxth	r6, r0
c0d049ac:	2e00      	cmp	r6, #0
c0d049ae:	d100      	bne.n	c0d049b2 <_toStringLookupSource_V1+0x82>
c0d049b0:	e088      	b.n	c0d04ac4 <_toStringLookupSource_V1+0x194>
c0d049b2:	2100      	movs	r1, #0
c0d049b4:	4846      	ldr	r0, [pc, #280]	; (c0d04ad0 <_toStringLookupSource_V1+0x1a0>)
c0d049b6:	4478      	add	r0, pc
c0d049b8:	9006      	str	r0, [sp, #24]
c0d049ba:	4608      	mov	r0, r1
c0d049bc:	9407      	str	r4, [sp, #28]
c0d049be:	9105      	str	r1, [sp, #20]
c0d049c0:	460c      	mov	r4, r1
c0d049c2:	68a9      	ldr	r1, [r5, #8]
c0d049c4:	1889      	adds	r1, r1, r2
c0d049c6:	5c0b      	ldrb	r3, [r1, r0]
c0d049c8:	0460      	lsls	r0, r4, #17
c0d049ca:	0c01      	lsrs	r1, r0, #16
c0d049cc:	9808      	ldr	r0, [sp, #32]
c0d049ce:	1840      	adds	r0, r0, r1
c0d049d0:	9f07      	ldr	r7, [sp, #28]
c0d049d2:	1a79      	subs	r1, r7, r1
c0d049d4:	4617      	mov	r7, r2
c0d049d6:	9a06      	ldr	r2, [sp, #24]
c0d049d8:	f7fd fbca 	bl	c0d02170 <snprintf>
c0d049dc:	463a      	mov	r2, r7
c0d049de:	1c64      	adds	r4, r4, #1
c0d049e0:	b2a0      	uxth	r0, r4
c0d049e2:	4286      	cmp	r6, r0
c0d049e4:	d8ed      	bhi.n	c0d049c2 <_toStringLookupSource_V1+0x92>
c0d049e6:	e062      	b.n	c0d04aae <_toStringLookupSource_V1+0x17e>
c0d049e8:	2000      	movs	r0, #0
    CLEAN_AND_CHECK()
c0d049ea:	7030      	strb	r0, [r6, #0]
c0d049ec:	2001      	movs	r0, #1
c0d049ee:	e06a      	b.n	c0d04ac6 <_toStringLookupSource_V1+0x196>
    switch (v->value) {
c0d049f0:	2900      	cmp	r1, #0
c0d049f2:	d05e      	beq.n	c0d04ab2 <_toStringLookupSource_V1+0x182>
c0d049f4:	2901      	cmp	r1, #1
c0d049f6:	d166      	bne.n	c0d04ac6 <_toStringLookupSource_V1+0x196>
    return _toStringCompactInt(&v->value, 0, 0, "", outValue, outValueLen, pageIdx, pageCount);
c0d049f8:	9700      	str	r7, [sp, #0]
c0d049fa:	9401      	str	r4, [sp, #4]
c0d049fc:	9807      	ldr	r0, [sp, #28]
c0d049fe:	9002      	str	r0, [sp, #8]
c0d04a00:	9603      	str	r6, [sp, #12]
        CHECK_ERROR(_toStringCompactAccountIndex_V1(&v->index, outValue, outValueLen, pageIdx, pageCount))
c0d04a02:	3508      	adds	r5, #8
c0d04a04:	2100      	movs	r1, #0
    return _toStringCompactInt(&v->value, 0, 0, "", outValue, outValueLen, pageIdx, pageCount);
c0d04a06:	4b31      	ldr	r3, [pc, #196]	; (c0d04acc <_toStringLookupSource_V1+0x19c>)
c0d04a08:	447b      	add	r3, pc
c0d04a0a:	4628      	mov	r0, r5
c0d04a0c:	460a      	mov	r2, r1
c0d04a0e:	f7fe f9ab 	bl	c0d02d68 <_toStringCompactInt>
c0d04a12:	e055      	b.n	c0d04ac0 <_toStringLookupSource_V1+0x190>
        CHECK_ERROR(_toStringBytes(&v->raw, outValue, outValueLen, pageIdx, pageCount))
c0d04a14:	9600      	str	r6, [sp, #0]
c0d04a16:	3508      	adds	r5, #8
c0d04a18:	4628      	mov	r0, r5
c0d04a1a:	4639      	mov	r1, r7
c0d04a1c:	4622      	mov	r2, r4
c0d04a1e:	9b07      	ldr	r3, [sp, #28]
c0d04a20:	f7ff fbca 	bl	c0d041b8 <_toStringBytes>
c0d04a24:	e04c      	b.n	c0d04ac0 <_toStringLookupSource_V1+0x190>
        GEN_DEF_TOSTRING_ARRAY(32)
c0d04a26:	4638      	mov	r0, r7
c0d04a28:	4621      	mov	r1, r4
c0d04a2a:	f002 fc83 	bl	c0d07334 <explicit_bzero>
c0d04a2e:	200b      	movs	r0, #11
c0d04a30:	2c00      	cmp	r4, #0
c0d04a32:	d048      	beq.n	c0d04ac6 <_toStringLookupSource_V1+0x196>
c0d04a34:	68a9      	ldr	r1, [r5, #8]
c0d04a36:	2900      	cmp	r1, #0
c0d04a38:	d045      	beq.n	c0d04ac6 <_toStringLookupSource_V1+0x196>
c0d04a3a:	9708      	str	r7, [sp, #32]
c0d04a3c:	1e60      	subs	r0, r4, #1
c0d04a3e:	0fc1      	lsrs	r1, r0, #31
c0d04a40:	1840      	adds	r0, r0, r1
c0d04a42:	1047      	asrs	r7, r0, #1
c0d04a44:	b2b9      	uxth	r1, r7
c0d04a46:	2020      	movs	r0, #32
c0d04a48:	9006      	str	r0, [sp, #24]
c0d04a4a:	f002 facb 	bl	c0d06fe4 <__udivsi3>
c0d04a4e:	4639      	mov	r1, r7
c0d04a50:	4341      	muls	r1, r0
c0d04a52:	b289      	uxth	r1, r1
c0d04a54:	2920      	cmp	r1, #32
c0d04a56:	d000      	beq.n	c0d04a5a <_toStringLookupSource_V1+0x12a>
c0d04a58:	1c40      	adds	r0, r0, #1
c0d04a5a:	9907      	ldr	r1, [sp, #28]
c0d04a5c:	9b06      	ldr	r3, [sp, #24]
c0d04a5e:	7030      	strb	r0, [r6, #0]
c0d04a60:	4379      	muls	r1, r7
c0d04a62:	b28a      	uxth	r2, r1
c0d04a64:	1a98      	subs	r0, r3, r2
c0d04a66:	42b8      	cmp	r0, r7
c0d04a68:	db00      	blt.n	c0d04a6c <_toStringLookupSource_V1+0x13c>
c0d04a6a:	4638      	mov	r0, r7
c0d04a6c:	b283      	uxth	r3, r0
c0d04a6e:	2b00      	cmp	r3, #0
c0d04a70:	d028      	beq.n	c0d04ac4 <_toStringLookupSource_V1+0x194>
c0d04a72:	2100      	movs	r1, #0
c0d04a74:	4817      	ldr	r0, [pc, #92]	; (c0d04ad4 <_toStringLookupSource_V1+0x1a4>)
c0d04a76:	4478      	add	r0, pc
c0d04a78:	9006      	str	r0, [sp, #24]
c0d04a7a:	4608      	mov	r0, r1
c0d04a7c:	9407      	str	r4, [sp, #28]
c0d04a7e:	9105      	str	r1, [sp, #20]
c0d04a80:	460c      	mov	r4, r1
c0d04a82:	68a9      	ldr	r1, [r5, #8]
c0d04a84:	1889      	adds	r1, r1, r2
c0d04a86:	462e      	mov	r6, r5
c0d04a88:	461d      	mov	r5, r3
c0d04a8a:	5c0b      	ldrb	r3, [r1, r0]
c0d04a8c:	0460      	lsls	r0, r4, #17
c0d04a8e:	0c01      	lsrs	r1, r0, #16
c0d04a90:	9808      	ldr	r0, [sp, #32]
c0d04a92:	1840      	adds	r0, r0, r1
c0d04a94:	9f07      	ldr	r7, [sp, #28]
c0d04a96:	1a79      	subs	r1, r7, r1
c0d04a98:	4617      	mov	r7, r2
c0d04a9a:	9a06      	ldr	r2, [sp, #24]
c0d04a9c:	f7fd fb68 	bl	c0d02170 <snprintf>
c0d04aa0:	462b      	mov	r3, r5
c0d04aa2:	4635      	mov	r5, r6
c0d04aa4:	463a      	mov	r2, r7
c0d04aa6:	1c64      	adds	r4, r4, #1
c0d04aa8:	b2a0      	uxth	r0, r4
c0d04aaa:	4283      	cmp	r3, r0
c0d04aac:	d8e9      	bhi.n	c0d04a82 <_toStringLookupSource_V1+0x152>
c0d04aae:	9805      	ldr	r0, [sp, #20]
c0d04ab0:	e009      	b.n	c0d04ac6 <_toStringLookupSource_V1+0x196>
    return _toStringPubkeyAsAddress(v->_ptr, outValue, outValueLen, pageIdx, pageCount);
c0d04ab2:	68a8      	ldr	r0, [r5, #8]
c0d04ab4:	9600      	str	r6, [sp, #0]
c0d04ab6:	4639      	mov	r1, r7
c0d04ab8:	4622      	mov	r2, r4
c0d04aba:	9b07      	ldr	r3, [sp, #28]
c0d04abc:	f7fe fc0a 	bl	c0d032d4 <_toStringPubkeyAsAddress>
c0d04ac0:	2800      	cmp	r0, #0
c0d04ac2:	d100      	bne.n	c0d04ac6 <_toStringLookupSource_V1+0x196>
c0d04ac4:	2000      	movs	r0, #0
    default:
        return parser_unexpected_address_type;
    }

    return parser_ok;
}
c0d04ac6:	b009      	add	sp, #36	; 0x24
c0d04ac8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d04aca:	46c0      	nop			; (mov r8, r8)
c0d04acc:	000039b5 	.word	0x000039b5
c0d04ad0:	0000334a 	.word	0x0000334a
c0d04ad4:	0000328a 	.word	0x0000328a

c0d04ad8 <_toStringRewardDestination_V1>:
    const pd_RewardDestination_V1_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d04ad8:	b570      	push	{r4, r5, r6, lr}
c0d04ada:	4614      	mov	r4, r2
c0d04adc:	460d      	mov	r5, r1
c0d04ade:	4606      	mov	r6, r0
    CLEAN_AND_CHECK()
c0d04ae0:	4608      	mov	r0, r1
c0d04ae2:	4611      	mov	r1, r2
c0d04ae4:	f002 fc26 	bl	c0d07334 <explicit_bzero>
c0d04ae8:	9804      	ldr	r0, [sp, #16]
c0d04aea:	2e00      	cmp	r6, #0
c0d04aec:	d00b      	beq.n	c0d04b06 <_toStringRewardDestination_V1+0x2e>
c0d04aee:	2101      	movs	r1, #1

    *pageCount = 1;
c0d04af0:	7001      	strb	r1, [r0, #0]
    switch (v->value) {
c0d04af2:	7830      	ldrb	r0, [r6, #0]
c0d04af4:	2802      	cmp	r0, #2
c0d04af6:	d00a      	beq.n	c0d04b0e <_toStringRewardDestination_V1+0x36>
c0d04af8:	2801      	cmp	r0, #1
c0d04afa:	d00b      	beq.n	c0d04b14 <_toStringRewardDestination_V1+0x3c>
c0d04afc:	2800      	cmp	r0, #0
c0d04afe:	d111      	bne.n	c0d04b24 <_toStringRewardDestination_V1+0x4c>
    case 0:
        snprintf(outValue, outValueLen, "Staked");
c0d04b00:	4a09      	ldr	r2, [pc, #36]	; (c0d04b28 <_toStringRewardDestination_V1+0x50>)
c0d04b02:	447a      	add	r2, pc
c0d04b04:	e008      	b.n	c0d04b18 <_toStringRewardDestination_V1+0x40>
c0d04b06:	2100      	movs	r1, #0
    CLEAN_AND_CHECK()
c0d04b08:	7001      	strb	r1, [r0, #0]
c0d04b0a:	2001      	movs	r0, #1
    default:
        return parser_print_not_supported;
    }

    return parser_ok;
}
c0d04b0c:	bd70      	pop	{r4, r5, r6, pc}
        snprintf(outValue, outValueLen, "Controller");
c0d04b0e:	4a08      	ldr	r2, [pc, #32]	; (c0d04b30 <_toStringRewardDestination_V1+0x58>)
c0d04b10:	447a      	add	r2, pc
c0d04b12:	e001      	b.n	c0d04b18 <_toStringRewardDestination_V1+0x40>
        snprintf(outValue, outValueLen, "Stash");
c0d04b14:	4a05      	ldr	r2, [pc, #20]	; (c0d04b2c <_toStringRewardDestination_V1+0x54>)
c0d04b16:	447a      	add	r2, pc
c0d04b18:	4628      	mov	r0, r5
c0d04b1a:	4621      	mov	r1, r4
c0d04b1c:	f7fd fb28 	bl	c0d02170 <snprintf>
c0d04b20:	2000      	movs	r0, #0
}
c0d04b22:	bd70      	pop	{r4, r5, r6, pc}
c0d04b24:	2013      	movs	r0, #19
c0d04b26:	bd70      	pop	{r4, r5, r6, pc}
c0d04b28:	0000326c 	.word	0x0000326c
c0d04b2c:	0000325f 	.word	0x0000325f
c0d04b30:	0000318e 	.word	0x0000318e

c0d04b34 <_toStringValidatorPrefs_V1>:
    const pd_ValidatorPrefs_V1_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d04b34:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04b36:	b089      	sub	sp, #36	; 0x24
c0d04b38:	9307      	str	r3, [sp, #28]
c0d04b3a:	4614      	mov	r4, r2
c0d04b3c:	460d      	mov	r5, r1
c0d04b3e:	4606      	mov	r6, r0
    CLEAN_AND_CHECK()
c0d04b40:	4608      	mov	r0, r1
c0d04b42:	4611      	mov	r1, r2
c0d04b44:	f002 fbf6 	bl	c0d07334 <explicit_bzero>
c0d04b48:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d04b4a:	2e00      	cmp	r6, #0
c0d04b4c:	d039      	beq.n	c0d04bc2 <_toStringValidatorPrefs_V1+0x8e>
c0d04b4e:	9106      	str	r1, [sp, #24]
c0d04b50:	a808      	add	r0, sp, #32
c0d04b52:	2100      	movs	r1, #0
    return _toStringCompactInt(&v->value, 7, '%', "", outValue, outValueLen, pageIdx, pageCount);
c0d04b54:	9500      	str	r5, [sp, #0]
c0d04b56:	9401      	str	r4, [sp, #4]
c0d04b58:	9102      	str	r1, [sp, #8]
c0d04b5a:	9003      	str	r0, [sp, #12]
c0d04b5c:	2107      	movs	r1, #7
c0d04b5e:	2225      	movs	r2, #37	; 0x25
c0d04b60:	4b21      	ldr	r3, [pc, #132]	; (c0d04be8 <_toStringValidatorPrefs_V1+0xb4>)
c0d04b62:	447b      	add	r3, pc
c0d04b64:	4630      	mov	r0, r6
c0d04b66:	f7fe f8ff 	bl	c0d02d68 <_toStringCompactInt>
c0d04b6a:	2800      	cmp	r0, #0
c0d04b6c:	d12c      	bne.n	c0d04bc8 <_toStringValidatorPrefs_V1+0x94>
c0d04b6e:	a808      	add	r0, sp, #32

    uint8_t pages[2];
    CHECK_ERROR(_toStringCompactPerBill_V1(&v->commission, outValue, outValueLen, 0, &pages[0]))
    CHECK_ERROR(_toStringbool(&v->blocked, outValue, outValueLen, 0, &pages[1]))
c0d04b70:	1c40      	adds	r0, r0, #1
c0d04b72:	9005      	str	r0, [sp, #20]
c0d04b74:	9000      	str	r0, [sp, #0]
c0d04b76:	4637      	mov	r7, r6
c0d04b78:	3708      	adds	r7, #8
c0d04b7a:	2300      	movs	r3, #0
c0d04b7c:	4638      	mov	r0, r7
c0d04b7e:	4629      	mov	r1, r5
c0d04b80:	4622      	mov	r2, r4
c0d04b82:	f7ff fa6f 	bl	c0d04064 <_toStringbool>
c0d04b86:	2800      	cmp	r0, #0
c0d04b88:	d11e      	bne.n	c0d04bc8 <_toStringValidatorPrefs_V1+0x94>
c0d04b8a:	9704      	str	r7, [sp, #16]
c0d04b8c:	a808      	add	r0, sp, #32

    *pageCount = 0;
    for (uint8_t i = 0; i < (uint8_t)sizeof(pages); i++) {
        *pageCount += pages[i];
c0d04b8e:	7841      	ldrb	r1, [r0, #1]
c0d04b90:	7802      	ldrb	r2, [r0, #0]
c0d04b92:	1850      	adds	r0, r2, r1
c0d04b94:	9b06      	ldr	r3, [sp, #24]
c0d04b96:	7018      	strb	r0, [r3, #0]
c0d04b98:	b2c3      	uxtb	r3, r0
c0d04b9a:	2003      	movs	r0, #3
c0d04b9c:	9f07      	ldr	r7, [sp, #28]
    }

    if (pageIdx > *pageCount) {
c0d04b9e:	42bb      	cmp	r3, r7
c0d04ba0:	d312      	bcc.n	c0d04bc8 <_toStringValidatorPrefs_V1+0x94>
c0d04ba2:	463b      	mov	r3, r7
        return parser_display_idx_out_of_range;
    }

    if (pageIdx < pages[0]) {
c0d04ba4:	42ba      	cmp	r2, r7
c0d04ba6:	d911      	bls.n	c0d04bcc <_toStringValidatorPrefs_V1+0x98>
c0d04ba8:	a808      	add	r0, sp, #32
    return _toStringCompactInt(&v->value, 7, '%', "", outValue, outValueLen, pageIdx, pageCount);
c0d04baa:	9500      	str	r5, [sp, #0]
c0d04bac:	9401      	str	r4, [sp, #4]
c0d04bae:	9302      	str	r3, [sp, #8]
c0d04bb0:	9003      	str	r0, [sp, #12]
c0d04bb2:	2107      	movs	r1, #7
c0d04bb4:	2225      	movs	r2, #37	; 0x25
c0d04bb6:	4b0d      	ldr	r3, [pc, #52]	; (c0d04bec <_toStringValidatorPrefs_V1+0xb8>)
c0d04bb8:	447b      	add	r3, pc
c0d04bba:	4630      	mov	r0, r6
c0d04bbc:	f7fe f8d4 	bl	c0d02d68 <_toStringCompactInt>
c0d04bc0:	e002      	b.n	c0d04bc8 <_toStringValidatorPrefs_V1+0x94>
c0d04bc2:	2000      	movs	r0, #0
    CLEAN_AND_CHECK()
c0d04bc4:	7008      	strb	r0, [r1, #0]
c0d04bc6:	2001      	movs	r0, #1
        CHECK_ERROR(_toStringbool(&v->blocked, outValue, outValueLen, pageIdx, &pages[1]))
        return parser_ok;
    }

    return parser_display_idx_out_of_range;
}
c0d04bc8:	b009      	add	sp, #36	; 0x24
c0d04bca:	bdf0      	pop	{r4, r5, r6, r7, pc}
    pageIdx -= pages[0];
c0d04bcc:	1a9a      	subs	r2, r3, r2
c0d04bce:	b2d3      	uxtb	r3, r2
    if (pageIdx < pages[1]) {
c0d04bd0:	428b      	cmp	r3, r1
c0d04bd2:	9905      	ldr	r1, [sp, #20]
c0d04bd4:	9a04      	ldr	r2, [sp, #16]
c0d04bd6:	d2f7      	bcs.n	c0d04bc8 <_toStringValidatorPrefs_V1+0x94>
        CHECK_ERROR(_toStringbool(&v->blocked, outValue, outValueLen, pageIdx, &pages[1]))
c0d04bd8:	9100      	str	r1, [sp, #0]
c0d04bda:	4610      	mov	r0, r2
c0d04bdc:	4629      	mov	r1, r5
c0d04bde:	4622      	mov	r2, r4
c0d04be0:	f7ff fa40 	bl	c0d04064 <_toStringbool>
c0d04be4:	e7f0      	b.n	c0d04bc8 <_toStringValidatorPrefs_V1+0x94>
c0d04be6:	46c0      	nop			; (mov r8, r8)
c0d04be8:	0000385b 	.word	0x0000385b
c0d04bec:	00003805 	.word	0x00003805

c0d04bf0 <_toStringVecLookupSource_V1>:
    const pd_VecLookupSource_V1_t* v,
    char* outValue,
    uint16_t outValueLen,
    uint8_t pageIdx,
    uint8_t* pageCount)
{
c0d04bf0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04bf2:	b091      	sub	sp, #68	; 0x44
c0d04bf4:	9303      	str	r3, [sp, #12]
c0d04bf6:	4607      	mov	r7, r0
c0d04bf8:	9104      	str	r1, [sp, #16]
    GEN_DEF_TOSTRING_VECTOR(LookupSource_V1);
c0d04bfa:	4608      	mov	r0, r1
c0d04bfc:	9205      	str	r2, [sp, #20]
c0d04bfe:	4611      	mov	r1, r2
c0d04c00:	f002 fb98 	bl	c0d07334 <explicit_bzero>
c0d04c04:	9c16      	ldr	r4, [sp, #88]	; 0x58
c0d04c06:	2500      	movs	r5, #0
c0d04c08:	7025      	strb	r5, [r4, #0]
c0d04c0a:	2f00      	cmp	r7, #0
c0d04c0c:	d05e      	beq.n	c0d04ccc <_toStringVecLookupSource_V1+0xdc>
c0d04c0e:	cf03      	ldmia	r7!, {r0, r1}
c0d04c10:	3f08      	subs	r7, #8
c0d04c12:	4301      	orrs	r1, r0
c0d04c14:	d05c      	beq.n	c0d04cd0 <_toStringVecLookupSource_V1+0xe0>
c0d04c16:	8a3a      	ldrh	r2, [r7, #16]
c0d04c18:	68b9      	ldr	r1, [r7, #8]
c0d04c1a:	a807      	add	r0, sp, #28
c0d04c1c:	f7fd ff4c 	bl	c0d02ab8 <parser_init>
c0d04c20:	cf03      	ldmia	r7!, {r0, r1}
c0d04c22:	3f08      	subs	r7, #8
c0d04c24:	4301      	orrs	r1, r0
c0d04c26:	d01b      	beq.n	c0d04c60 <_toStringVecLookupSource_V1+0x70>
c0d04c28:	a807      	add	r0, sp, #28
c0d04c2a:	a90a      	add	r1, sp, #40	; 0x28
c0d04c2c:	f7ff fd50 	bl	c0d046d0 <_readLookupSource_V1>
c0d04c30:	2800      	cmp	r0, #0
c0d04c32:	d158      	bne.n	c0d04ce6 <_toStringVecLookupSource_V1+0xf6>
c0d04c34:	a806      	add	r0, sp, #24
c0d04c36:	9000      	str	r0, [sp, #0]
c0d04c38:	a80a      	add	r0, sp, #40	; 0x28
c0d04c3a:	2600      	movs	r6, #0
c0d04c3c:	9904      	ldr	r1, [sp, #16]
c0d04c3e:	9a05      	ldr	r2, [sp, #20]
c0d04c40:	4633      	mov	r3, r6
c0d04c42:	f7ff fe75 	bl	c0d04930 <_toStringLookupSource_V1>
c0d04c46:	2800      	cmp	r0, #0
c0d04c48:	d14d      	bne.n	c0d04ce6 <_toStringVecLookupSource_V1+0xf6>
c0d04c4a:	7820      	ldrb	r0, [r4, #0]
c0d04c4c:	9906      	ldr	r1, [sp, #24]
c0d04c4e:	1840      	adds	r0, r0, r1
c0d04c50:	7020      	strb	r0, [r4, #0]
c0d04c52:	cf03      	ldmia	r7!, {r0, r1}
c0d04c54:	1c6d      	adds	r5, r5, #1
c0d04c56:	b2aa      	uxth	r2, r5
c0d04c58:	3f08      	subs	r7, #8
c0d04c5a:	1a10      	subs	r0, r2, r0
c0d04c5c:	418e      	sbcs	r6, r1
c0d04c5e:	d3e3      	bcc.n	c0d04c28 <_toStringVecLookupSource_V1+0x38>
c0d04c60:	8a3a      	ldrh	r2, [r7, #16]
c0d04c62:	68b9      	ldr	r1, [r7, #8]
c0d04c64:	a807      	add	r0, sp, #28
c0d04c66:	f7fd ff27 	bl	c0d02ab8 <parser_init>
c0d04c6a:	cf03      	ldmia	r7!, {r0, r1}
c0d04c6c:	2213      	movs	r2, #19
c0d04c6e:	3f08      	subs	r7, #8
c0d04c70:	4301      	orrs	r1, r0
c0d04c72:	d037      	beq.n	c0d04ce4 <_toStringVecLookupSource_V1+0xf4>
c0d04c74:	9202      	str	r2, [sp, #8]
c0d04c76:	2500      	movs	r5, #0
c0d04c78:	462e      	mov	r6, r5
c0d04c7a:	a807      	add	r0, sp, #28
c0d04c7c:	a90a      	add	r1, sp, #40	; 0x28
c0d04c7e:	f7ff fd27 	bl	c0d046d0 <_readLookupSource_V1>
c0d04c82:	2800      	cmp	r0, #0
c0d04c84:	d12f      	bne.n	c0d04ce6 <_toStringVecLookupSource_V1+0xf6>
c0d04c86:	a806      	add	r0, sp, #24
c0d04c88:	2101      	movs	r1, #1
c0d04c8a:	7001      	strb	r1, [r0, #0]
c0d04c8c:	2400      	movs	r4, #0
c0d04c8e:	a806      	add	r0, sp, #24
c0d04c90:	9000      	str	r0, [sp, #0]
c0d04c92:	b2e3      	uxtb	r3, r4
c0d04c94:	a80a      	add	r0, sp, #40	; 0x28
c0d04c96:	9904      	ldr	r1, [sp, #16]
c0d04c98:	9a05      	ldr	r2, [sp, #20]
c0d04c9a:	f7ff fe49 	bl	c0d04930 <_toStringLookupSource_V1>
c0d04c9e:	2800      	cmp	r0, #0
c0d04ca0:	d121      	bne.n	c0d04ce6 <_toStringVecLookupSource_V1+0xf6>
c0d04ca2:	b2b0      	uxth	r0, r6
c0d04ca4:	9903      	ldr	r1, [sp, #12]
c0d04ca6:	4288      	cmp	r0, r1
c0d04ca8:	d01a      	beq.n	c0d04ce0 <_toStringVecLookupSource_V1+0xf0>
c0d04caa:	1c76      	adds	r6, r6, #1
c0d04cac:	a806      	add	r0, sp, #24
c0d04cae:	7800      	ldrb	r0, [r0, #0]
c0d04cb0:	1c64      	adds	r4, r4, #1
c0d04cb2:	b2a1      	uxth	r1, r4
c0d04cb4:	4281      	cmp	r1, r0
c0d04cb6:	d3ea      	bcc.n	c0d04c8e <_toStringVecLookupSource_V1+0x9e>
c0d04cb8:	cf03      	ldmia	r7!, {r0, r1}
c0d04cba:	1c6d      	adds	r5, r5, #1
c0d04cbc:	b2aa      	uxth	r2, r5
c0d04cbe:	2300      	movs	r3, #0
c0d04cc0:	3f08      	subs	r7, #8
c0d04cc2:	1a10      	subs	r0, r2, r0
c0d04cc4:	418b      	sbcs	r3, r1
c0d04cc6:	d3d8      	bcc.n	c0d04c7a <_toStringVecLookupSource_V1+0x8a>
c0d04cc8:	9802      	ldr	r0, [sp, #8]
c0d04cca:	e00c      	b.n	c0d04ce6 <_toStringVecLookupSource_V1+0xf6>
c0d04ccc:	2001      	movs	r0, #1
c0d04cce:	e00a      	b.n	c0d04ce6 <_toStringVecLookupSource_V1+0xf6>
c0d04cd0:	2001      	movs	r0, #1
c0d04cd2:	7020      	strb	r0, [r4, #0]
c0d04cd4:	4a05      	ldr	r2, [pc, #20]	; (c0d04cec <_toStringVecLookupSource_V1+0xfc>)
c0d04cd6:	447a      	add	r2, pc
c0d04cd8:	9804      	ldr	r0, [sp, #16]
c0d04cda:	9905      	ldr	r1, [sp, #20]
c0d04cdc:	f7fd fa48 	bl	c0d02170 <snprintf>
c0d04ce0:	2000      	movs	r0, #0
c0d04ce2:	e000      	b.n	c0d04ce6 <_toStringVecLookupSource_V1+0xf6>
c0d04ce4:	4610      	mov	r0, r2
}
c0d04ce6:	b011      	add	sp, #68	; 0x44
c0d04ce8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d04cea:	46c0      	nop			; (mov r8, r8)
c0d04cec:	00003034 	.word	0x00003034

c0d04cf0 <SVC_Call>:
.thumb
.thumb_func
.global SVC_Call

SVC_Call:
    svc 1
c0d04cf0:	df01      	svc	1
    cmp r1, #0
c0d04cf2:	2900      	cmp	r1, #0
    bne exception
c0d04cf4:	d100      	bne.n	c0d04cf8 <exception>
    bx lr
c0d04cf6:	4770      	bx	lr

c0d04cf8 <exception>:
exception:
    // THROW(ex);
    mov r0, r1
c0d04cf8:	4608      	mov	r0, r1
    bl os_longjmp
c0d04cfa:	f7fc fc94 	bl	c0d01626 <os_longjmp>

c0d04cfe <SVC_cx_call>:
.thumb
.thumb_func
.global SVC_cx_call

SVC_cx_call:
    svc 1
c0d04cfe:	df01      	svc	1
    bx lr
c0d04d00:	4770      	bx	lr
	...

c0d04d04 <get_api_level>:
#include <string.h>

unsigned int SVC_Call(unsigned int syscall_id, void *parameters);
unsigned int SVC_cx_call(unsigned int syscall_id, unsigned int * parameters);

unsigned int get_api_level(void) {
c0d04d04:	b580      	push	{r7, lr}
c0d04d06:	b084      	sub	sp, #16
c0d04d08:	2000      	movs	r0, #0
  unsigned int parameters [2+1];
  parameters[0] = 0;
  parameters[1] = 0;
c0d04d0a:	9002      	str	r0, [sp, #8]
  parameters[0] = 0;
c0d04d0c:	9001      	str	r0, [sp, #4]
c0d04d0e:	4803      	ldr	r0, [pc, #12]	; (c0d04d1c <get_api_level+0x18>)
c0d04d10:	a901      	add	r1, sp, #4
  return SVC_Call(SYSCALL_get_api_level_ID_IN, parameters);
c0d04d12:	f7ff ffed 	bl	c0d04cf0 <SVC_Call>
c0d04d16:	b004      	add	sp, #16
c0d04d18:	bd80      	pop	{r7, pc}
c0d04d1a:	46c0      	nop			; (mov r8, r8)
c0d04d1c:	60000138 	.word	0x60000138

c0d04d20 <halt>:
}

void halt ( void ) {
c0d04d20:	b580      	push	{r7, lr}
c0d04d22:	b082      	sub	sp, #8
c0d04d24:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d04d26:	9001      	str	r0, [sp, #4]
c0d04d28:	4802      	ldr	r0, [pc, #8]	; (c0d04d34 <halt+0x14>)
c0d04d2a:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_halt_ID_IN, parameters);
c0d04d2c:	f7ff ffe0 	bl	c0d04cf0 <SVC_Call>
  return;
}
c0d04d30:	b002      	add	sp, #8
c0d04d32:	bd80      	pop	{r7, pc}
c0d04d34:	6000023c 	.word	0x6000023c

c0d04d38 <nvm_write>:

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) {
c0d04d38:	b580      	push	{r7, lr}
c0d04d3a:	b086      	sub	sp, #24
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)dst_adr;
c0d04d3c:	ab01      	add	r3, sp, #4
c0d04d3e:	c307      	stmia	r3!, {r0, r1, r2}
c0d04d40:	4802      	ldr	r0, [pc, #8]	; (c0d04d4c <nvm_write+0x14>)
c0d04d42:	a901      	add	r1, sp, #4
  parameters[1] = (unsigned int)src_adr;
  parameters[2] = (unsigned int)src_len;
  SVC_Call(SYSCALL_nvm_write_ID_IN, parameters);
c0d04d44:	f7ff ffd4 	bl	c0d04cf0 <SVC_Call>
  return;
}
c0d04d48:	b006      	add	sp, #24
c0d04d4a:	bd80      	pop	{r7, pc}
c0d04d4c:	6000037f 	.word	0x6000037f

c0d04d50 <cx_ecdomain_parameters_length>:
  parameters[0] = (unsigned int)cv;
  parameters[1] = (unsigned int)length;
  return SVC_cx_call(SYSCALL_cx_ecdomain_size_ID_IN, parameters);
}

cx_err_t cx_ecdomain_parameters_length ( cx_curve_t cv, size_t *length ) {
c0d04d50:	b580      	push	{r7, lr}
c0d04d52:	b084      	sub	sp, #16
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)cv;
  parameters[1] = (unsigned int)length;
c0d04d54:	9101      	str	r1, [sp, #4]
  parameters[0] = (unsigned int)cv;
c0d04d56:	9000      	str	r0, [sp, #0]
c0d04d58:	4802      	ldr	r0, [pc, #8]	; (c0d04d64 <cx_ecdomain_parameters_length+0x14>)
c0d04d5a:	4669      	mov	r1, sp
  return SVC_cx_call(SYSCALL_cx_ecdomain_parameters_length_ID_IN, parameters);
c0d04d5c:	f7ff ffcf 	bl	c0d04cfe <SVC_cx_call>
c0d04d60:	b004      	add	sp, #16
c0d04d62:	bd80      	pop	{r7, pc}
c0d04d64:	60012fb4 	.word	0x60012fb4

c0d04d68 <os_perso_isonboarded>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_perso_finalize_ID_IN, parameters);
  return;
}

bolos_bool_t os_perso_isonboarded ( void ) {
c0d04d68:	b580      	push	{r7, lr}
c0d04d6a:	b082      	sub	sp, #8
c0d04d6c:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d04d6e:	9001      	str	r0, [sp, #4]
c0d04d70:	4803      	ldr	r0, [pc, #12]	; (c0d04d80 <os_perso_isonboarded+0x18>)
c0d04d72:	4669      	mov	r1, sp
  return (bolos_bool_t) SVC_Call(SYSCALL_os_perso_isonboarded_ID_IN, parameters);
c0d04d74:	f7ff ffbc 	bl	c0d04cf0 <SVC_Call>
c0d04d78:	b2c0      	uxtb	r0, r0
c0d04d7a:	b002      	add	sp, #8
c0d04d7c:	bd80      	pop	{r7, pc}
c0d04d7e:	46c0      	nop			; (mov r8, r8)
c0d04d80:	60009f4f 	.word	0x60009f4f

c0d04d84 <os_perso_derive_node_with_seed_key>:
  parameters[4] = (unsigned int)chain;
  SVC_Call(SYSCALL_os_perso_derive_node_bip32_ID_IN, parameters);
  return;
}

void os_perso_derive_node_with_seed_key ( unsigned int mode, cx_curve_t curve, const unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain, unsigned char * seed_key, unsigned int seed_key_length ) {
c0d04d84:	b510      	push	{r4, lr}
c0d04d86:	b08a      	sub	sp, #40	; 0x28
c0d04d88:	9c0f      	ldr	r4, [sp, #60]	; 0x3c
  parameters[2] = (unsigned int)path;
  parameters[3] = (unsigned int)pathLength;
  parameters[4] = (unsigned int)privateKey;
  parameters[5] = (unsigned int)chain;
  parameters[6] = (unsigned int)seed_key;
  parameters[7] = (unsigned int)seed_key_length;
c0d04d8a:	9407      	str	r4, [sp, #28]
c0d04d8c:	9c0e      	ldr	r4, [sp, #56]	; 0x38
  parameters[6] = (unsigned int)seed_key;
c0d04d8e:	9406      	str	r4, [sp, #24]
c0d04d90:	9c0d      	ldr	r4, [sp, #52]	; 0x34
  parameters[5] = (unsigned int)chain;
c0d04d92:	9405      	str	r4, [sp, #20]
c0d04d94:	9c0c      	ldr	r4, [sp, #48]	; 0x30
  parameters[4] = (unsigned int)privateKey;
c0d04d96:	9404      	str	r4, [sp, #16]
  parameters[3] = (unsigned int)pathLength;
c0d04d98:	9303      	str	r3, [sp, #12]
  parameters[2] = (unsigned int)path;
c0d04d9a:	9202      	str	r2, [sp, #8]
  parameters[1] = (unsigned int)curve;
c0d04d9c:	9101      	str	r1, [sp, #4]
  parameters[0] = (unsigned int)mode;
c0d04d9e:	9000      	str	r0, [sp, #0]
c0d04da0:	4802      	ldr	r0, [pc, #8]	; (c0d04dac <os_perso_derive_node_with_seed_key+0x28>)
c0d04da2:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_perso_derive_node_with_seed_key_ID_IN, parameters);
c0d04da4:	f7ff ffa4 	bl	c0d04cf0 <SVC_Call>
  return;
}
c0d04da8:	b00a      	add	sp, #40	; 0x28
c0d04daa:	bd10      	pop	{r4, pc}
c0d04dac:	6000a6d8 	.word	0x6000a6d8

c0d04db0 <os_perso_seed_cookie>:
  SVC_Call(SYSCALL_os_perso_derive_eip2333_ID_IN, parameters);
  return;
}

#if defined(HAVE_SEED_COOKIE)
unsigned int os_perso_seed_cookie ( unsigned char * seed_cookie, unsigned int seed_cookie_length ) {
c0d04db0:	b580      	push	{r7, lr}
c0d04db2:	b084      	sub	sp, #16
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)seed_cookie;
  parameters[1] = (unsigned int)seed_cookie_length;
c0d04db4:	9101      	str	r1, [sp, #4]
  parameters[0] = (unsigned int)seed_cookie;
c0d04db6:	9000      	str	r0, [sp, #0]
c0d04db8:	4802      	ldr	r0, [pc, #8]	; (c0d04dc4 <os_perso_seed_cookie+0x14>)
c0d04dba:	4669      	mov	r1, sp
  return (unsigned int) SVC_Call(SYSCALL_os_perso_seed_cookie_ID_IN, parameters);
c0d04dbc:	f7ff ff98 	bl	c0d04cf0 <SVC_Call>
c0d04dc0:	b004      	add	sp, #16
c0d04dc2:	bd80      	pop	{r7, pc}
c0d04dc4:	6000a8fc 	.word	0x6000a8fc

c0d04dc8 <os_global_pin_is_validated>:
  parameters[1] = (unsigned int)length;
  SVC_Call(SYSCALL_os_perso_set_current_identity_pin_ID_IN, parameters);
  return;
}

bolos_bool_t os_global_pin_is_validated ( void ) {
c0d04dc8:	b580      	push	{r7, lr}
c0d04dca:	b082      	sub	sp, #8
c0d04dcc:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d04dce:	9001      	str	r0, [sp, #4]
c0d04dd0:	4803      	ldr	r0, [pc, #12]	; (c0d04de0 <os_global_pin_is_validated+0x18>)
c0d04dd2:	4669      	mov	r1, sp
  return (bolos_bool_t) SVC_Call(SYSCALL_os_global_pin_is_validated_ID_IN, parameters);
c0d04dd4:	f7ff ff8c 	bl	c0d04cf0 <SVC_Call>
c0d04dd8:	b2c0      	uxtb	r0, r0
c0d04dda:	b002      	add	sp, #8
c0d04ddc:	bd80      	pop	{r7, pc}
c0d04dde:	46c0      	nop			; (mov r8, r8)
c0d04de0:	6000a03c 	.word	0x6000a03c

c0d04de4 <os_ux>:
  SVC_Call(SYSCALL_os_registry_get_ID_IN, parameters);
  return;
}

#if !defined(APP_UX)
unsigned int os_ux ( bolos_ux_params_t * params ) {
c0d04de4:	b580      	push	{r7, lr}
c0d04de6:	b084      	sub	sp, #16
c0d04de8:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)params;
  parameters[1] = 0;
c0d04dea:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)params;
c0d04dec:	9001      	str	r0, [sp, #4]
c0d04dee:	4803      	ldr	r0, [pc, #12]	; (c0d04dfc <os_ux+0x18>)
c0d04df0:	a901      	add	r1, sp, #4
  return (unsigned int) SVC_Call(SYSCALL_os_ux_ID_IN, parameters);
c0d04df2:	f7ff ff7d 	bl	c0d04cf0 <SVC_Call>
c0d04df6:	b004      	add	sp, #16
c0d04df8:	bd80      	pop	{r7, pc}
c0d04dfa:	46c0      	nop			; (mov r8, r8)
c0d04dfc:	60006458 	.word	0x60006458

c0d04e00 <os_flags>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_lib_end_ID_IN, parameters);
  return;
}

unsigned int os_flags ( void ) {
c0d04e00:	b580      	push	{r7, lr}
c0d04e02:	b082      	sub	sp, #8
c0d04e04:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d04e06:	9001      	str	r0, [sp, #4]
c0d04e08:	4802      	ldr	r0, [pc, #8]	; (c0d04e14 <os_flags+0x14>)
c0d04e0a:	4669      	mov	r1, sp
  return (unsigned int) SVC_Call(SYSCALL_os_flags_ID_IN, parameters);
c0d04e0c:	f7ff ff70 	bl	c0d04cf0 <SVC_Call>
c0d04e10:	b002      	add	sp, #8
c0d04e12:	bd80      	pop	{r7, pc}
c0d04e14:	60006a6e 	.word	0x60006a6e

c0d04e18 <os_version>:
}

unsigned int os_version ( unsigned char * version, unsigned int maxlength ) {
c0d04e18:	b580      	push	{r7, lr}
c0d04e1a:	b084      	sub	sp, #16
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)version;
  parameters[1] = (unsigned int)maxlength;
c0d04e1c:	9101      	str	r1, [sp, #4]
  parameters[0] = (unsigned int)version;
c0d04e1e:	9000      	str	r0, [sp, #0]
c0d04e20:	4802      	ldr	r0, [pc, #8]	; (c0d04e2c <os_version+0x14>)
c0d04e22:	4669      	mov	r1, sp
  return (unsigned int) SVC_Call(SYSCALL_os_version_ID_IN, parameters);
c0d04e24:	f7ff ff64 	bl	c0d04cf0 <SVC_Call>
c0d04e28:	b004      	add	sp, #16
c0d04e2a:	bd80      	pop	{r7, pc}
c0d04e2c:	60006bb8 	.word	0x60006bb8

c0d04e30 <os_seph_version>:
  unsigned int parameters [2];
  parameters[1] = 0;
  return (unsigned int) SVC_Call(SYSCALL_os_seph_features_ID_IN, parameters);
}

unsigned int os_seph_version ( unsigned char * version, unsigned int maxlength ) {
c0d04e30:	b580      	push	{r7, lr}
c0d04e32:	b084      	sub	sp, #16
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)version;
  parameters[1] = (unsigned int)maxlength;
c0d04e34:	9101      	str	r1, [sp, #4]
  parameters[0] = (unsigned int)version;
c0d04e36:	9000      	str	r0, [sp, #0]
c0d04e38:	4802      	ldr	r0, [pc, #8]	; (c0d04e44 <os_seph_version+0x14>)
c0d04e3a:	4669      	mov	r1, sp
  return (unsigned int) SVC_Call(SYSCALL_os_seph_version_ID_IN, parameters);
c0d04e3c:	f7ff ff58 	bl	c0d04cf0 <SVC_Call>
c0d04e40:	b004      	add	sp, #16
c0d04e42:	bd80      	pop	{r7, pc}
c0d04e44:	60006fac 	.word	0x60006fac

c0d04e48 <os_registry_get_current_app_tag>:
  parameters[4] = (unsigned int)buffer;
  parameters[5] = (unsigned int)maxlength;
  return (unsigned int) SVC_Call(SYSCALL_os_registry_get_tag_ID_IN, parameters);
}

unsigned int os_registry_get_current_app_tag ( unsigned int tag, unsigned char * buffer, unsigned int maxlen ) {
c0d04e48:	b580      	push	{r7, lr}
c0d04e4a:	b086      	sub	sp, #24
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)tag;
c0d04e4c:	ab01      	add	r3, sp, #4
c0d04e4e:	c307      	stmia	r3!, {r0, r1, r2}
c0d04e50:	4802      	ldr	r0, [pc, #8]	; (c0d04e5c <os_registry_get_current_app_tag+0x14>)
c0d04e52:	a901      	add	r1, sp, #4
  parameters[1] = (unsigned int)buffer;
  parameters[2] = (unsigned int)maxlen;
  return (unsigned int) SVC_Call(SYSCALL_os_registry_get_current_app_tag_ID_IN, parameters);
c0d04e54:	f7ff ff4c 	bl	c0d04cf0 <SVC_Call>
c0d04e58:	b006      	add	sp, #24
c0d04e5a:	bd80      	pop	{r7, pc}
c0d04e5c:	600074d4 	.word	0x600074d4

c0d04e60 <os_sched_exit>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_exec_ID_IN, parameters);
  return;
}

void os_sched_exit ( bolos_task_status_t exit_code ) {
c0d04e60:	b580      	push	{r7, lr}
c0d04e62:	b084      	sub	sp, #16
c0d04e64:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)exit_code;
  parameters[1] = 0;
c0d04e66:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)exit_code;
c0d04e68:	9001      	str	r0, [sp, #4]
c0d04e6a:	4803      	ldr	r0, [pc, #12]	; (c0d04e78 <os_sched_exit+0x18>)
c0d04e6c:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
c0d04e6e:	f7ff ff3f 	bl	c0d04cf0 <SVC_Call>
  return;
}
c0d04e72:	b004      	add	sp, #16
c0d04e74:	bd80      	pop	{r7, pc}
c0d04e76:	46c0      	nop			; (mov r8, r8)
c0d04e78:	60009abe 	.word	0x60009abe

c0d04e7c <io_seph_send>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_kill_ID_IN, parameters);
  return;
}

void io_seph_send ( const unsigned char * buffer, unsigned short length ) {
c0d04e7c:	b580      	push	{r7, lr}
c0d04e7e:	b084      	sub	sp, #16
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
  parameters[1] = (unsigned int)length;
c0d04e80:	9101      	str	r1, [sp, #4]
  parameters[0] = (unsigned int)buffer;
c0d04e82:	9000      	str	r0, [sp, #0]
c0d04e84:	4802      	ldr	r0, [pc, #8]	; (c0d04e90 <io_seph_send+0x14>)
c0d04e86:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_io_seph_send_ID_IN, parameters);
c0d04e88:	f7ff ff32 	bl	c0d04cf0 <SVC_Call>
  return;
}
c0d04e8c:	b004      	add	sp, #16
c0d04e8e:	bd80      	pop	{r7, pc}
c0d04e90:	60008381 	.word	0x60008381

c0d04e94 <io_seph_is_status_sent>:

unsigned int io_seph_is_status_sent ( void ) {
c0d04e94:	b580      	push	{r7, lr}
c0d04e96:	b082      	sub	sp, #8
c0d04e98:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d04e9a:	9001      	str	r0, [sp, #4]
c0d04e9c:	4802      	ldr	r0, [pc, #8]	; (c0d04ea8 <io_seph_is_status_sent+0x14>)
c0d04e9e:	4669      	mov	r1, sp
  return (unsigned int) SVC_Call(SYSCALL_io_seph_is_status_sent_ID_IN, parameters);
c0d04ea0:	f7ff ff26 	bl	c0d04cf0 <SVC_Call>
c0d04ea4:	b002      	add	sp, #8
c0d04ea6:	bd80      	pop	{r7, pc}
c0d04ea8:	600084bb 	.word	0x600084bb

c0d04eac <io_seph_recv>:
}

unsigned short io_seph_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) {
c0d04eac:	b580      	push	{r7, lr}
c0d04eae:	b086      	sub	sp, #24
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)buffer;
c0d04eb0:	ab01      	add	r3, sp, #4
c0d04eb2:	c307      	stmia	r3!, {r0, r1, r2}
c0d04eb4:	4803      	ldr	r0, [pc, #12]	; (c0d04ec4 <io_seph_recv+0x18>)
c0d04eb6:	a901      	add	r1, sp, #4
  parameters[1] = (unsigned int)maxlength;
  parameters[2] = (unsigned int)flags;
  return (unsigned short) SVC_Call(SYSCALL_io_seph_recv_ID_IN, parameters);
c0d04eb8:	f7ff ff1a 	bl	c0d04cf0 <SVC_Call>
c0d04ebc:	b280      	uxth	r0, r0
c0d04ebe:	b006      	add	sp, #24
c0d04ec0:	bd80      	pop	{r7, pc}
c0d04ec2:	46c0      	nop			; (mov r8, r8)
c0d04ec4:	600085e4 	.word	0x600085e4

c0d04ec8 <try_context_get>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_nvm_erase_page_ID_IN, parameters);
  return;
}

try_context_t * try_context_get ( void ) {
c0d04ec8:	b580      	push	{r7, lr}
c0d04eca:	b082      	sub	sp, #8
c0d04ecc:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d04ece:	9001      	str	r0, [sp, #4]
c0d04ed0:	4802      	ldr	r0, [pc, #8]	; (c0d04edc <try_context_get+0x14>)
c0d04ed2:	4669      	mov	r1, sp
  return (try_context_t *) SVC_Call(SYSCALL_try_context_get_ID_IN, parameters);
c0d04ed4:	f7ff ff0c 	bl	c0d04cf0 <SVC_Call>
c0d04ed8:	b002      	add	sp, #8
c0d04eda:	bd80      	pop	{r7, pc}
c0d04edc:	600087b1 	.word	0x600087b1

c0d04ee0 <try_context_set>:
}

try_context_t * try_context_set ( try_context_t *context ) {
c0d04ee0:	b580      	push	{r7, lr}
c0d04ee2:	b084      	sub	sp, #16
c0d04ee4:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)context;
  parameters[1] = 0;
c0d04ee6:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)context;
c0d04ee8:	9001      	str	r0, [sp, #4]
c0d04eea:	4803      	ldr	r0, [pc, #12]	; (c0d04ef8 <try_context_set+0x18>)
c0d04eec:	a901      	add	r1, sp, #4
  return (try_context_t *) SVC_Call(SYSCALL_try_context_set_ID_IN, parameters);
c0d04eee:	f7ff feff 	bl	c0d04cf0 <SVC_Call>
c0d04ef2:	b004      	add	sp, #16
c0d04ef4:	bd80      	pop	{r7, pc}
c0d04ef6:	46c0      	nop			; (mov r8, r8)
c0d04ef8:	60010b06 	.word	0x60010b06

c0d04efc <os_sched_last_status>:
}

bolos_task_status_t os_sched_last_status ( unsigned int task_idx ) {
c0d04efc:	b580      	push	{r7, lr}
c0d04efe:	b084      	sub	sp, #16
c0d04f00:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)task_idx;
  parameters[1] = 0;
c0d04f02:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)task_idx;
c0d04f04:	9001      	str	r0, [sp, #4]
c0d04f06:	4803      	ldr	r0, [pc, #12]	; (c0d04f14 <os_sched_last_status+0x18>)
c0d04f08:	a901      	add	r1, sp, #4
  return (bolos_task_status_t) SVC_Call(SYSCALL_os_sched_last_status_ID_IN, parameters);
c0d04f0a:	f7ff fef1 	bl	c0d04cf0 <SVC_Call>
c0d04f0e:	b2c0      	uxtb	r0, r0
c0d04f10:	b004      	add	sp, #16
c0d04f12:	bd80      	pop	{r7, pc}
c0d04f14:	60009c8b 	.word	0x60009c8b

c0d04f18 <tx_initialize>:
#define N_appdata (*(NV_VOLATILE storage_t *)PIC(&N_appdata_impl))
#endif

parser_context_t ctx_parsed_tx;

void tx_initialize() {
c0d04f18:	b580      	push	{r7, lr}
    buffering_init(
            ram_buffer,
            sizeof(ram_buffer),
            (uint8_t *) N_appdata.buffer,
c0d04f1a:	4805      	ldr	r0, [pc, #20]	; (c0d04f30 <tx_initialize+0x18>)
c0d04f1c:	f7fe fa30 	bl	c0d03380 <pic>
c0d04f20:	4602      	mov	r2, r0
c0d04f22:	2001      	movs	r0, #1
c0d04f24:	0343      	lsls	r3, r0, #13
    buffering_init(
c0d04f26:	4803      	ldr	r0, [pc, #12]	; (c0d04f34 <tx_initialize+0x1c>)
c0d04f28:	2100      	movs	r1, #0
c0d04f2a:	f7fc f837 	bl	c0d00f9c <buffering_init>
            sizeof(N_appdata.buffer)
    );
}
c0d04f2e:	bd80      	pop	{r7, pc}
c0d04f30:	c0d08680 	.word	0xc0d08680
c0d04f34:	20000435 	.word	0x20000435

c0d04f38 <tx_reset>:

void tx_reset() {
c0d04f38:	b580      	push	{r7, lr}
    buffering_reset();
c0d04f3a:	f7fc f847 	bl	c0d00fcc <buffering_reset>
}
c0d04f3e:	bd80      	pop	{r7, pc}

c0d04f40 <tx_append>:

uint32_t tx_append(unsigned char *buffer, uint32_t length) {
c0d04f40:	b580      	push	{r7, lr}
    return buffering_append(buffer, length);
c0d04f42:	f7fc f855 	bl	c0d00ff0 <buffering_append>
c0d04f46:	bd80      	pop	{r7, pc}

c0d04f48 <tx_get_buffer_length>:
}

uint32_t tx_get_buffer_length() {
c0d04f48:	b580      	push	{r7, lr}
    return buffering_get_buffer()->pos;
c0d04f4a:	f7fc f891 	bl	c0d01070 <buffering_get_buffer>
c0d04f4e:	88c0      	ldrh	r0, [r0, #6]
c0d04f50:	bd80      	pop	{r7, pc}

c0d04f52 <tx_get_buffer>:
}

uint8_t *tx_get_buffer() {
c0d04f52:	b580      	push	{r7, lr}
    return buffering_get_buffer()->data;
c0d04f54:	f7fc f88c 	bl	c0d01070 <buffering_get_buffer>
c0d04f58:	6800      	ldr	r0, [r0, #0]
c0d04f5a:	bd80      	pop	{r7, pc}

c0d04f5c <tx_parse>:
}

const char *tx_parse() {
c0d04f5c:	b510      	push	{r4, lr}
c0d04f5e:	b082      	sub	sp, #8
c0d04f60:	2078      	movs	r0, #120	; 0x78
    parser_tx_t *tx_obj;

    zb_allocate(sizeof(parser_tx_t));
c0d04f62:	f001 ff87 	bl	c0d06e74 <zb_allocate>
c0d04f66:	a801      	add	r0, sp, #4
    zb_get((uint8_t **) &tx_obj);
c0d04f68:	f001 ff70 	bl	c0d06e4c <zb_get>
    return buffering_get_buffer()->data;
c0d04f6c:	f7fc f880 	bl	c0d01070 <buffering_get_buffer>
c0d04f70:	6804      	ldr	r4, [r0, #0]
    return buffering_get_buffer()->pos;
c0d04f72:	f7fc f87d 	bl	c0d01070 <buffering_get_buffer>
c0d04f76:	88c2      	ldrh	r2, [r0, #6]

    uint8_t err = parser_parse(
            &ctx_parsed_tx,
            tx_get_buffer(),
            tx_get_buffer_length(),
            tx_obj);
c0d04f78:	9b01      	ldr	r3, [sp, #4]
    uint8_t err = parser_parse(
c0d04f7a:	480b      	ldr	r0, [pc, #44]	; (c0d04fa8 <tx_parse+0x4c>)
c0d04f7c:	4621      	mov	r1, r4
c0d04f7e:	f7fd fabd 	bl	c0d024fc <parser_parse>
c0d04f82:	4604      	mov	r4, r0

    if (err != parser_ok) {
c0d04f84:	2800      	cmp	r0, #0
c0d04f86:	d107      	bne.n	c0d04f98 <tx_parse+0x3c>
        return parser_getErrorDescription(err);
    }

    err = parser_validate(&ctx_parsed_tx);
c0d04f88:	4807      	ldr	r0, [pc, #28]	; (c0d04fa8 <tx_parse+0x4c>)
c0d04f8a:	f7fd fadb 	bl	c0d02544 <parser_validate>
c0d04f8e:	4604      	mov	r4, r0
    CHECK_APP_CANARY()
c0d04f90:	f002 f818 	bl	c0d06fc4 <check_app_canary>

    if (err != parser_ok) {
c0d04f94:	2c00      	cmp	r4, #0
c0d04f96:	d004      	beq.n	c0d04fa2 <tx_parse+0x46>
c0d04f98:	4620      	mov	r0, r4
c0d04f9a:	f7fd fd9d 	bl	c0d02ad8 <parser_getErrorDescription>
        return parser_getErrorDescription(err);
    }

    return NULL;
}
c0d04f9e:	b002      	add	sp, #8
c0d04fa0:	bd10      	pop	{r4, pc}
c0d04fa2:	2000      	movs	r0, #0
c0d04fa4:	e7fb      	b.n	c0d04f9e <tx_parse+0x42>
c0d04fa6:	46c0      	nop			; (mov r8, r8)
c0d04fa8:	20000438 	.word	0x20000438

c0d04fac <tx_getNumItems>:

void tx_parse_reset() {
    zb_deallocate();
}

zxerr_t tx_getNumItems(uint8_t *num_items) {
c0d04fac:	b580      	push	{r7, lr}
c0d04fae:	4601      	mov	r1, r0
    parser_error_t err = parser_getNumItems(&ctx_parsed_tx, num_items);
c0d04fb0:	4804      	ldr	r0, [pc, #16]	; (c0d04fc4 <tx_getNumItems+0x18>)
c0d04fb2:	f7fd faf7 	bl	c0d025a4 <parser_getNumItems>
    if (err != parser_ok) {
        return zxerr_no_data;
    }

    return zxerr_ok;
}
c0d04fb6:	2800      	cmp	r0, #0
c0d04fb8:	d001      	beq.n	c0d04fbe <tx_getNumItems+0x12>
c0d04fba:	2005      	movs	r0, #5
c0d04fbc:	bd80      	pop	{r7, pc}
c0d04fbe:	2003      	movs	r0, #3
c0d04fc0:	bd80      	pop	{r7, pc}
c0d04fc2:	46c0      	nop			; (mov r8, r8)
c0d04fc4:	20000438 	.word	0x20000438

c0d04fc8 <tx_getItem>:

zxerr_t tx_getItem(int8_t displayIdx,
                   char *outKey, uint16_t outKeyLen,
                   char *outVal, uint16_t outValLen,
                   uint8_t pageIdx, uint8_t *pageCount) {
c0d04fc8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04fca:	b087      	sub	sp, #28
c0d04fcc:	461f      	mov	r7, r3
c0d04fce:	9205      	str	r2, [sp, #20]
c0d04fd0:	9104      	str	r1, [sp, #16]
c0d04fd2:	4605      	mov	r5, r0
c0d04fd4:	ae06      	add	r6, sp, #24
c0d04fd6:	2400      	movs	r4, #0
    uint8_t numItems = 0;
c0d04fd8:	7034      	strb	r4, [r6, #0]
    parser_error_t err = parser_getNumItems(&ctx_parsed_tx, num_items);
c0d04fda:	4815      	ldr	r0, [pc, #84]	; (c0d05030 <tx_getItem+0x68>)
c0d04fdc:	4631      	mov	r1, r6
c0d04fde:	f7fd fae1 	bl	c0d025a4 <parser_getNumItems>
c0d04fe2:	2205      	movs	r2, #5
c0d04fe4:	2d00      	cmp	r5, #0
c0d04fe6:	d41f      	bmi.n	c0d05028 <tx_getItem+0x60>
c0d04fe8:	2800      	cmp	r0, #0
c0d04fea:	d11d      	bne.n	c0d05028 <tx_getItem+0x60>
c0d04fec:	b2e9      	uxtb	r1, r5
c0d04fee:	7830      	ldrb	r0, [r6, #0]
c0d04ff0:	4288      	cmp	r0, r1
c0d04ff2:	d319      	bcc.n	c0d05028 <tx_getItem+0x60>
c0d04ff4:	4615      	mov	r5, r2
c0d04ff6:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d04ff8:	9a0d      	ldr	r2, [sp, #52]	; 0x34
c0d04ffa:	9b0c      	ldr	r3, [sp, #48]	; 0x30

    if (displayIdx < 0 || displayIdx > numItems) {
        return zxerr_no_data;
    }

    parser_error_t err = parser_getItem(&ctx_parsed_tx,
c0d04ffc:	9700      	str	r7, [sp, #0]
c0d04ffe:	9301      	str	r3, [sp, #4]
c0d05000:	9202      	str	r2, [sp, #8]
c0d05002:	9003      	str	r0, [sp, #12]
c0d05004:	480a      	ldr	r0, [pc, #40]	; (c0d05030 <tx_getItem+0x68>)
c0d05006:	9a04      	ldr	r2, [sp, #16]
c0d05008:	9b05      	ldr	r3, [sp, #20]
c0d0500a:	f7fd fb17 	bl	c0d0263c <parser_getItem>
                                        outKey, outKeyLen,
                                        outVal, outValLen,
                                        pageIdx, pageCount);

    // Convert error codes
    if (err == parser_no_data ||
c0d0500e:	1ec1      	subs	r1, r0, #3
c0d05010:	2902      	cmp	r1, #2
c0d05012:	d306      	bcc.n	c0d05022 <tx_getItem+0x5a>
c0d05014:	2800      	cmp	r0, #0
c0d05016:	d006      	beq.n	c0d05026 <tx_getItem+0x5e>
c0d05018:	462a      	mov	r2, r5
c0d0501a:	2801      	cmp	r0, #1
c0d0501c:	d004      	beq.n	c0d05028 <tx_getItem+0x60>
c0d0501e:	4622      	mov	r2, r4
c0d05020:	e002      	b.n	c0d05028 <tx_getItem+0x60>
c0d05022:	462a      	mov	r2, r5
c0d05024:	e000      	b.n	c0d05028 <tx_getItem+0x60>
c0d05026:	2203      	movs	r2, #3

    if (err != parser_ok)
        return zxerr_unknown;

    return zxerr_ok;
}
c0d05028:	4610      	mov	r0, r2
c0d0502a:	b007      	add	sp, #28
c0d0502c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0502e:	46c0      	nop			; (mov r8, r8)
c0d05030:	20000438 	.word	0x20000438

c0d05034 <USBD_LL_Init>:
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
  ep_out_stall = 0;
c0d05034:	4902      	ldr	r1, [pc, #8]	; (c0d05040 <USBD_LL_Init+0xc>)
c0d05036:	2000      	movs	r0, #0
c0d05038:	6008      	str	r0, [r1, #0]
  ep_in_stall = 0;
c0d0503a:	4902      	ldr	r1, [pc, #8]	; (c0d05044 <USBD_LL_Init+0x10>)
c0d0503c:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d0503e:	4770      	bx	lr
c0d05040:	20000448 	.word	0x20000448
c0d05044:	20000444 	.word	0x20000444

c0d05048 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d05048:	b510      	push	{r4, lr}
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0504a:	4807      	ldr	r0, [pc, #28]	; (c0d05068 <USBD_LL_DeInit+0x20>)
c0d0504c:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 1;
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d0504e:	70c1      	strb	r1, [r0, #3]
c0d05050:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d05052:	7081      	strb	r1, [r0, #2]
c0d05054:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d05056:	7044      	strb	r4, [r0, #1]
c0d05058:	214f      	movs	r1, #79	; 0x4f
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0505a:	7001      	strb	r1, [r0, #0]
c0d0505c:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0505e:	f7ff ff0d 	bl	c0d04e7c <io_seph_send>

  return USBD_OK; 
c0d05062:	4620      	mov	r0, r4
c0d05064:	bd10      	pop	{r4, pc}
c0d05066:	46c0      	nop			; (mov r8, r8)
c0d05068:	20000202 	.word	0x20000202

c0d0506c <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d0506c:	b570      	push	{r4, r5, r6, lr}
c0d0506e:	b082      	sub	sp, #8
c0d05070:	466d      	mov	r5, sp
c0d05072:	2400      	movs	r4, #0
  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 2;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = 0;
c0d05074:	712c      	strb	r4, [r5, #4]
c0d05076:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d05078:	70e8      	strb	r0, [r5, #3]
c0d0507a:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d0507c:	70a8      	strb	r0, [r5, #2]
  buffer[1] = 0;
c0d0507e:	706c      	strb	r4, [r5, #1]
c0d05080:	264f      	movs	r6, #79	; 0x4f
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d05082:	702e      	strb	r6, [r5, #0]
c0d05084:	2105      	movs	r1, #5
  io_seproxyhal_spi_send(buffer, 5);
c0d05086:	4628      	mov	r0, r5
c0d05088:	f7ff fef8 	bl	c0d04e7c <io_seph_send>
c0d0508c:	2001      	movs	r0, #1
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 1;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d0508e:	70e8      	strb	r0, [r5, #3]
  buffer[2] = 1;
c0d05090:	70a8      	strb	r0, [r5, #2]
  buffer[1] = 0;
c0d05092:	706c      	strb	r4, [r5, #1]
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d05094:	702e      	strb	r6, [r5, #0]
c0d05096:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d05098:	4628      	mov	r0, r5
c0d0509a:	f7ff feef 	bl	c0d04e7c <io_seph_send>
  return USBD_OK; 
c0d0509e:	4620      	mov	r0, r4
c0d050a0:	b002      	add	sp, #8
c0d050a2:	bd70      	pop	{r4, r5, r6, pc}

c0d050a4 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d050a4:	b510      	push	{r4, lr}
c0d050a6:	b082      	sub	sp, #8
c0d050a8:	a801      	add	r0, sp, #4
c0d050aa:	2102      	movs	r1, #2
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 1;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d050ac:	70c1      	strb	r1, [r0, #3]
c0d050ae:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d050b0:	7081      	strb	r1, [r0, #2]
c0d050b2:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d050b4:	7044      	strb	r4, [r0, #1]
c0d050b6:	214f      	movs	r1, #79	; 0x4f
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d050b8:	7001      	strb	r1, [r0, #0]
c0d050ba:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d050bc:	f7ff fede 	bl	c0d04e7c <io_seph_send>
  return USBD_OK; 
c0d050c0:	4620      	mov	r0, r4
c0d050c2:	b002      	add	sp, #8
c0d050c4:	bd10      	pop	{r4, pc}
	...

c0d050c8 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d050c8:	b570      	push	{r4, r5, r6, lr}
c0d050ca:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d050cc:	4814      	ldr	r0, [pc, #80]	; (c0d05120 <USBD_LL_OpenEP+0x58>)
c0d050ce:	2400      	movs	r4, #0
c0d050d0:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d050d2:	4814      	ldr	r0, [pc, #80]	; (c0d05124 <USBD_LL_OpenEP+0x5c>)
c0d050d4:	6004      	str	r4, [r0, #0]
c0d050d6:	466d      	mov	r5, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d050d8:	71ac      	strb	r4, [r5, #6]
  buffer[5] = ep_addr;
c0d050da:	7169      	strb	r1, [r5, #5]
c0d050dc:	2001      	movs	r0, #1
  buffer[4] = 1;
c0d050de:	7128      	strb	r0, [r5, #4]
c0d050e0:	2104      	movs	r1, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d050e2:	70e9      	strb	r1, [r5, #3]
c0d050e4:	2605      	movs	r6, #5
  buffer[2] = 5;
c0d050e6:	70ae      	strb	r6, [r5, #2]
  buffer[1] = 0;
c0d050e8:	706c      	strb	r4, [r5, #1]
c0d050ea:	244f      	movs	r4, #79	; 0x4f
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d050ec:	702c      	strb	r4, [r5, #0]
  switch(ep_type) {
c0d050ee:	2a01      	cmp	r2, #1
c0d050f0:	dc05      	bgt.n	c0d050fe <USBD_LL_OpenEP+0x36>
c0d050f2:	2a00      	cmp	r2, #0
c0d050f4:	d00a      	beq.n	c0d0510c <USBD_LL_OpenEP+0x44>
c0d050f6:	2a01      	cmp	r2, #1
c0d050f8:	d10a      	bne.n	c0d05110 <USBD_LL_OpenEP+0x48>
c0d050fa:	4608      	mov	r0, r1
c0d050fc:	e006      	b.n	c0d0510c <USBD_LL_OpenEP+0x44>
c0d050fe:	2a02      	cmp	r2, #2
c0d05100:	d003      	beq.n	c0d0510a <USBD_LL_OpenEP+0x42>
c0d05102:	2a03      	cmp	r2, #3
c0d05104:	d104      	bne.n	c0d05110 <USBD_LL_OpenEP+0x48>
c0d05106:	2002      	movs	r0, #2
c0d05108:	e000      	b.n	c0d0510c <USBD_LL_OpenEP+0x44>
c0d0510a:	2003      	movs	r0, #3
c0d0510c:	4669      	mov	r1, sp
c0d0510e:	7188      	strb	r0, [r1, #6]
c0d05110:	4668      	mov	r0, sp
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d05112:	71c3      	strb	r3, [r0, #7]
c0d05114:	2108      	movs	r1, #8
  io_seproxyhal_spi_send(buffer, 8);
c0d05116:	f7ff feb1 	bl	c0d04e7c <io_seph_send>
c0d0511a:	2000      	movs	r0, #0
  return USBD_OK; 
c0d0511c:	b002      	add	sp, #8
c0d0511e:	bd70      	pop	{r4, r5, r6, pc}
c0d05120:	20000444 	.word	0x20000444
c0d05124:	20000448 	.word	0x20000448

c0d05128 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d05128:	b5b0      	push	{r4, r5, r7, lr}
c0d0512a:	b082      	sub	sp, #8
c0d0512c:	460d      	mov	r5, r1
c0d0512e:	4668      	mov	r0, sp
c0d05130:	2400      	movs	r4, #0
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
  buffer[5] = 0;
c0d05132:	7144      	strb	r4, [r0, #5]
c0d05134:	2140      	movs	r1, #64	; 0x40
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d05136:	7101      	strb	r1, [r0, #4]
  buffer[3] = ep_addr;
c0d05138:	70c5      	strb	r5, [r0, #3]
c0d0513a:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d0513c:	7081      	strb	r1, [r0, #2]
  buffer[1] = 0;
c0d0513e:	7044      	strb	r4, [r0, #1]
c0d05140:	2150      	movs	r1, #80	; 0x50
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d05142:	7001      	strb	r1, [r0, #0]
c0d05144:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d05146:	f7ff fe99 	bl	c0d04e7c <io_seph_send>
  if (ep_addr & 0x80) {
c0d0514a:	0628      	lsls	r0, r5, #24
c0d0514c:	d501      	bpl.n	c0d05152 <USBD_LL_StallEP+0x2a>
c0d0514e:	4807      	ldr	r0, [pc, #28]	; (c0d0516c <USBD_LL_StallEP+0x44>)
c0d05150:	e000      	b.n	c0d05154 <USBD_LL_StallEP+0x2c>
c0d05152:	4805      	ldr	r0, [pc, #20]	; (c0d05168 <USBD_LL_StallEP+0x40>)
c0d05154:	6801      	ldr	r1, [r0, #0]
c0d05156:	227f      	movs	r2, #127	; 0x7f
c0d05158:	4015      	ands	r5, r2
c0d0515a:	2201      	movs	r2, #1
c0d0515c:	40aa      	lsls	r2, r5
c0d0515e:	430a      	orrs	r2, r1
c0d05160:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d05162:	4620      	mov	r0, r4
c0d05164:	b002      	add	sp, #8
c0d05166:	bdb0      	pop	{r4, r5, r7, pc}
c0d05168:	20000448 	.word	0x20000448
c0d0516c:	20000444 	.word	0x20000444

c0d05170 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d05170:	b5b0      	push	{r4, r5, r7, lr}
c0d05172:	b082      	sub	sp, #8
c0d05174:	460d      	mov	r5, r1
c0d05176:	4668      	mov	r0, sp
c0d05178:	2400      	movs	r4, #0
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
  buffer[5] = 0;
c0d0517a:	7144      	strb	r4, [r0, #5]
c0d0517c:	2180      	movs	r1, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d0517e:	7101      	strb	r1, [r0, #4]
  buffer[3] = ep_addr;
c0d05180:	70c5      	strb	r5, [r0, #3]
c0d05182:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d05184:	7081      	strb	r1, [r0, #2]
  buffer[1] = 0;
c0d05186:	7044      	strb	r4, [r0, #1]
c0d05188:	2150      	movs	r1, #80	; 0x50
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0518a:	7001      	strb	r1, [r0, #0]
c0d0518c:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d0518e:	f7ff fe75 	bl	c0d04e7c <io_seph_send>
  if (ep_addr & 0x80) {
c0d05192:	0628      	lsls	r0, r5, #24
c0d05194:	d501      	bpl.n	c0d0519a <USBD_LL_ClearStallEP+0x2a>
c0d05196:	4807      	ldr	r0, [pc, #28]	; (c0d051b4 <USBD_LL_ClearStallEP+0x44>)
c0d05198:	e000      	b.n	c0d0519c <USBD_LL_ClearStallEP+0x2c>
c0d0519a:	4805      	ldr	r0, [pc, #20]	; (c0d051b0 <USBD_LL_ClearStallEP+0x40>)
c0d0519c:	6801      	ldr	r1, [r0, #0]
c0d0519e:	227f      	movs	r2, #127	; 0x7f
c0d051a0:	4015      	ands	r5, r2
c0d051a2:	2201      	movs	r2, #1
c0d051a4:	40aa      	lsls	r2, r5
c0d051a6:	4391      	bics	r1, r2
c0d051a8:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d051aa:	4620      	mov	r0, r4
c0d051ac:	b002      	add	sp, #8
c0d051ae:	bdb0      	pop	{r4, r5, r7, pc}
c0d051b0:	20000448 	.word	0x20000448
c0d051b4:	20000444 	.word	0x20000444

c0d051b8 <USBD_LL_IsStallEP>:
c0d051b8:	0608      	lsls	r0, r1, #24
c0d051ba:	d501      	bpl.n	c0d051c0 <USBD_LL_IsStallEP+0x8>
c0d051bc:	4805      	ldr	r0, [pc, #20]	; (c0d051d4 <USBD_LL_IsStallEP+0x1c>)
c0d051be:	e000      	b.n	c0d051c2 <USBD_LL_IsStallEP+0xa>
c0d051c0:	4803      	ldr	r0, [pc, #12]	; (c0d051d0 <USBD_LL_IsStallEP+0x18>)
c0d051c2:	7802      	ldrb	r2, [r0, #0]
c0d051c4:	207f      	movs	r0, #127	; 0x7f
c0d051c6:	4001      	ands	r1, r0
c0d051c8:	2001      	movs	r0, #1
c0d051ca:	4088      	lsls	r0, r1
c0d051cc:	4010      	ands	r0, r2
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d051ce:	4770      	bx	lr
c0d051d0:	20000448 	.word	0x20000448
c0d051d4:	20000444 	.word	0x20000444

c0d051d8 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d051d8:	b510      	push	{r4, lr}
c0d051da:	b082      	sub	sp, #8
c0d051dc:	4668      	mov	r0, sp
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 2;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = dev_addr;
c0d051de:	7101      	strb	r1, [r0, #4]
c0d051e0:	2103      	movs	r1, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d051e2:	70c1      	strb	r1, [r0, #3]
c0d051e4:	2102      	movs	r1, #2
  buffer[2] = 2;
c0d051e6:	7081      	strb	r1, [r0, #2]
c0d051e8:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d051ea:	7044      	strb	r4, [r0, #1]
c0d051ec:	214f      	movs	r1, #79	; 0x4f
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d051ee:	7001      	strb	r1, [r0, #0]
c0d051f0:	2105      	movs	r1, #5
  io_seproxyhal_spi_send(buffer, 5);
c0d051f2:	f7ff fe43 	bl	c0d04e7c <io_seph_send>
  return USBD_OK; 
c0d051f6:	4620      	mov	r0, r4
c0d051f8:	b002      	add	sp, #8
c0d051fa:	bd10      	pop	{r4, pc}

c0d051fc <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d051fc:	b5b0      	push	{r4, r5, r7, lr}
c0d051fe:	b082      	sub	sp, #8
c0d05200:	461c      	mov	r4, r3
c0d05202:	4615      	mov	r5, r2
c0d05204:	4668      	mov	r0, sp
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3+size)>>8;
  buffer[2] = (3+size);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  buffer[5] = size;
c0d05206:	7143      	strb	r3, [r0, #5]
c0d05208:	2220      	movs	r2, #32
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0520a:	7102      	strb	r2, [r0, #4]
  buffer[3] = ep_addr;
c0d0520c:	70c1      	strb	r1, [r0, #3]
c0d0520e:	2150      	movs	r1, #80	; 0x50
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d05210:	7001      	strb	r1, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d05212:	1cd9      	adds	r1, r3, #3
  buffer[2] = (3+size);
c0d05214:	7081      	strb	r1, [r0, #2]
  buffer[1] = (3+size)>>8;
c0d05216:	0a09      	lsrs	r1, r1, #8
c0d05218:	7041      	strb	r1, [r0, #1]
c0d0521a:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d0521c:	f7ff fe2e 	bl	c0d04e7c <io_seph_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d05220:	4628      	mov	r0, r5
c0d05222:	4621      	mov	r1, r4
c0d05224:	f7ff fe2a 	bl	c0d04e7c <io_seph_send>
c0d05228:	2000      	movs	r0, #0
  return USBD_OK;   
c0d0522a:	b002      	add	sp, #8
c0d0522c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0522e <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d0522e:	b510      	push	{r4, lr}
c0d05230:	b082      	sub	sp, #8
c0d05232:	4668      	mov	r0, sp
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3/*+size*/)>>8;
  buffer[2] = (3/*+size*/);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
  buffer[5] = size; // expected size, not transmitted here !
c0d05234:	7142      	strb	r2, [r0, #5]
c0d05236:	2230      	movs	r2, #48	; 0x30
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d05238:	7102      	strb	r2, [r0, #4]
  buffer[3] = ep_addr;
c0d0523a:	70c1      	strb	r1, [r0, #3]
c0d0523c:	2103      	movs	r1, #3
  buffer[2] = (3/*+size*/);
c0d0523e:	7081      	strb	r1, [r0, #2]
c0d05240:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d05242:	7044      	strb	r4, [r0, #1]
c0d05244:	2150      	movs	r1, #80	; 0x50
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d05246:	7001      	strb	r1, [r0, #0]
c0d05248:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d0524a:	f7ff fe17 	bl	c0d04e7c <io_seph_send>
  return USBD_OK;   
c0d0524e:	4620      	mov	r0, r4
c0d05250:	b002      	add	sp, #8
c0d05252:	bd10      	pop	{r4, pc}

c0d05254 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d05254:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05256:	b081      	sub	sp, #4
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d05258:	2800      	cmp	r0, #0
c0d0525a:	d014      	beq.n	c0d05286 <USBD_Init+0x32>
c0d0525c:	4615      	mov	r5, r2
c0d0525e:	460e      	mov	r6, r1
c0d05260:	4604      	mov	r4, r0
c0d05262:	4607      	mov	r7, r0
c0d05264:	37fc      	adds	r7, #252	; 0xfc
c0d05266:	204d      	movs	r0, #77	; 0x4d
c0d05268:	0081      	lsls	r1, r0, #2
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d0526a:	4620      	mov	r0, r4
c0d0526c:	f002 f84c 	bl	c0d07308 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d05270:	2e00      	cmp	r6, #0
c0d05272:	d000      	beq.n	c0d05276 <USBD_Init+0x22>
  {
    pdev->pDesc = pdesc;
c0d05274:	617e      	str	r6, [r7, #20]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
  pdev->id = id;
c0d05276:	7025      	strb	r5, [r4, #0]
c0d05278:	2001      	movs	r0, #1
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d0527a:	7038      	strb	r0, [r7, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d0527c:	4620      	mov	r0, r4
c0d0527e:	f7ff fed9 	bl	c0d05034 <USBD_LL_Init>
c0d05282:	2000      	movs	r0, #0
c0d05284:	e000      	b.n	c0d05288 <USBD_Init+0x34>
c0d05286:	2002      	movs	r0, #2
  
  return USBD_OK; 
}
c0d05288:	b001      	add	sp, #4
c0d0528a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0528c <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d0528c:	b570      	push	{r4, r5, r6, lr}
c0d0528e:	4604      	mov	r4, r0
c0d05290:	20fc      	movs	r0, #252	; 0xfc
c0d05292:	2101      	movs	r1, #1
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d05294:	5421      	strb	r1, [r4, r0]
c0d05296:	2045      	movs	r0, #69	; 0x45
c0d05298:	0080      	lsls	r0, r0, #2
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0529a:	1825      	adds	r5, r4, r0
c0d0529c:	2017      	movs	r0, #23
c0d0529e:	43c6      	mvns	r6, r0
    if(pdev->interfacesClass[intf].pClass != NULL) {
c0d052a0:	19a8      	adds	r0, r5, r6
c0d052a2:	6980      	ldr	r0, [r0, #24]
c0d052a4:	2800      	cmp	r0, #0
c0d052a6:	d006      	beq.n	c0d052b6 <USBD_DeInit+0x2a>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
c0d052a8:	6840      	ldr	r0, [r0, #4]
c0d052aa:	f7fe f869 	bl	c0d03380 <pic>
c0d052ae:	4602      	mov	r2, r0
c0d052b0:	7921      	ldrb	r1, [r4, #4]
c0d052b2:	4620      	mov	r0, r4
c0d052b4:	4790      	blx	r2
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d052b6:	3608      	adds	r6, #8
c0d052b8:	d1f2      	bne.n	c0d052a0 <USBD_DeInit+0x14>
    }
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d052ba:	4620      	mov	r0, r4
c0d052bc:	f7ff fef2 	bl	c0d050a4 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d052c0:	4620      	mov	r0, r4
c0d052c2:	f7ff fec1 	bl	c0d05048 <USBD_LL_DeInit>
c0d052c6:	2000      	movs	r0, #0
  
  return USBD_OK;
c0d052c8:	bd70      	pop	{r4, r5, r6, pc}

c0d052ca <USBD_RegisterClassForInterface>:
  * @retval USBD Status
  */
USBD_StatusTypeDef USBD_RegisterClassForInterface(uint8_t interfaceidx, USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d052ca:	2a00      	cmp	r2, #0
c0d052cc:	d009      	beq.n	c0d052e2 <USBD_RegisterClassForInterface+0x18>
c0d052ce:	4603      	mov	r3, r0
c0d052d0:	2000      	movs	r0, #0
  {
    if (interfaceidx < USBD_MAX_NUM_INTERFACES) {
c0d052d2:	2b02      	cmp	r3, #2
c0d052d4:	d804      	bhi.n	c0d052e0 <USBD_RegisterClassForInterface+0x16>
      /* link the class to the USB Device handle */
      pdev->interfacesClass[interfaceidx].pClass = pclass;
c0d052d6:	00db      	lsls	r3, r3, #3
c0d052d8:	18c9      	adds	r1, r1, r3
c0d052da:	2345      	movs	r3, #69	; 0x45
c0d052dc:	009b      	lsls	r3, r3, #2
c0d052de:	50ca      	str	r2, [r1, r3]
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d052e0:	4770      	bx	lr
c0d052e2:	2002      	movs	r0, #2
c0d052e4:	4770      	bx	lr

c0d052e6 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d052e6:	b580      	push	{r7, lr}
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d052e8:	f7ff fec0 	bl	c0d0506c <USBD_LL_Start>
c0d052ec:	2000      	movs	r0, #0
  
  return USBD_OK;  
c0d052ee:	bd80      	pop	{r7, pc}

c0d052f0 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d052f0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d052f2:	b081      	sub	sp, #4
c0d052f4:	460c      	mov	r4, r1
c0d052f6:	4605      	mov	r5, r0
c0d052f8:	2045      	movs	r0, #69	; 0x45
c0d052fa:	0087      	lsls	r7, r0, #2
c0d052fc:	2600      	movs	r6, #0
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d052fe:	4628      	mov	r0, r5
c0d05300:	4631      	mov	r1, r6
c0d05302:	f000 f967 	bl	c0d055d4 <usbd_is_valid_intf>
c0d05306:	2800      	cmp	r0, #0
c0d05308:	d007      	beq.n	c0d0531a <USBD_SetClassConfig+0x2a>
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
c0d0530a:	59e8      	ldr	r0, [r5, r7]
c0d0530c:	6800      	ldr	r0, [r0, #0]
c0d0530e:	f7fe f837 	bl	c0d03380 <pic>
c0d05312:	4602      	mov	r2, r0
c0d05314:	4628      	mov	r0, r5
c0d05316:	4621      	mov	r1, r4
c0d05318:	4790      	blx	r2
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0531a:	3708      	adds	r7, #8
c0d0531c:	1c76      	adds	r6, r6, #1
c0d0531e:	2e03      	cmp	r6, #3
c0d05320:	d1ed      	bne.n	c0d052fe <USBD_SetClassConfig+0xe>
c0d05322:	2000      	movs	r0, #0
    }
  }

  return USBD_OK; 
c0d05324:	b001      	add	sp, #4
c0d05326:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d05328 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d05328:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0532a:	b081      	sub	sp, #4
c0d0532c:	460c      	mov	r4, r1
c0d0532e:	4605      	mov	r5, r0
c0d05330:	2045      	movs	r0, #69	; 0x45
c0d05332:	0087      	lsls	r7, r0, #2
c0d05334:	2600      	movs	r6, #0
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d05336:	4628      	mov	r0, r5
c0d05338:	4631      	mov	r1, r6
c0d0533a:	f000 f94b 	bl	c0d055d4 <usbd_is_valid_intf>
c0d0533e:	2800      	cmp	r0, #0
c0d05340:	d007      	beq.n	c0d05352 <USBD_ClrClassConfig+0x2a>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
c0d05342:	59e8      	ldr	r0, [r5, r7]
c0d05344:	6840      	ldr	r0, [r0, #4]
c0d05346:	f7fe f81b 	bl	c0d03380 <pic>
c0d0534a:	4602      	mov	r2, r0
c0d0534c:	4628      	mov	r0, r5
c0d0534e:	4621      	mov	r1, r4
c0d05350:	4790      	blx	r2
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d05352:	3708      	adds	r7, #8
c0d05354:	1c76      	adds	r6, r6, #1
c0d05356:	2e03      	cmp	r6, #3
c0d05358:	d1ed      	bne.n	c0d05336 <USBD_ClrClassConfig+0xe>
c0d0535a:	2000      	movs	r0, #0
    }
  }
  return USBD_OK;
c0d0535c:	b001      	add	sp, #4
c0d0535e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d05360 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d05360:	b570      	push	{r4, r5, r6, lr}
c0d05362:	4604      	mov	r4, r0
c0d05364:	4606      	mov	r6, r0
c0d05366:	36f4      	adds	r6, #244	; 0xf4
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d05368:	4635      	mov	r5, r6
c0d0536a:	3514      	adds	r5, #20
c0d0536c:	4628      	mov	r0, r5
c0d0536e:	f000 fb70 	bl	c0d05a52 <USBD_ParseSetupRequest>
c0d05372:	20f4      	movs	r0, #244	; 0xf4
c0d05374:	2101      	movs	r1, #1
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d05376:	5021      	str	r1, [r4, r0]
c0d05378:	2087      	movs	r0, #135	; 0x87
c0d0537a:	0040      	lsls	r0, r0, #1
  pdev->ep0_data_len = pdev->request.wLength;
c0d0537c:	5a20      	ldrh	r0, [r4, r0]
c0d0537e:	6070      	str	r0, [r6, #4]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d05380:	7d31      	ldrb	r1, [r6, #20]
c0d05382:	201f      	movs	r0, #31
c0d05384:	4008      	ands	r0, r1
c0d05386:	2802      	cmp	r0, #2
c0d05388:	d008      	beq.n	c0d0539c <USBD_LL_SetupStage+0x3c>
c0d0538a:	2801      	cmp	r0, #1
c0d0538c:	d00b      	beq.n	c0d053a6 <USBD_LL_SetupStage+0x46>
c0d0538e:	2800      	cmp	r0, #0
c0d05390:	d10e      	bne.n	c0d053b0 <USBD_LL_SetupStage+0x50>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d05392:	4620      	mov	r0, r4
c0d05394:	4629      	mov	r1, r5
c0d05396:	f000 f929 	bl	c0d055ec <USBD_StdDevReq>
c0d0539a:	e00e      	b.n	c0d053ba <USBD_LL_SetupStage+0x5a>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d0539c:	4620      	mov	r0, r4
c0d0539e:	4629      	mov	r1, r5
c0d053a0:	f000 fad2 	bl	c0d05948 <USBD_StdEPReq>
c0d053a4:	e009      	b.n	c0d053ba <USBD_LL_SetupStage+0x5a>
    USBD_StdItfReq(pdev, &pdev->request);
c0d053a6:	4620      	mov	r0, r4
c0d053a8:	4629      	mov	r1, r5
c0d053aa:	f000 faa8 	bl	c0d058fe <USBD_StdItfReq>
c0d053ae:	e004      	b.n	c0d053ba <USBD_LL_SetupStage+0x5a>
c0d053b0:	2080      	movs	r0, #128	; 0x80
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d053b2:	4001      	ands	r1, r0
c0d053b4:	4620      	mov	r0, r4
c0d053b6:	f7ff feb7 	bl	c0d05128 <USBD_LL_StallEP>
c0d053ba:	2000      	movs	r0, #0
    break;
  }  
  return USBD_OK;  
c0d053bc:	bd70      	pop	{r4, r5, r6, pc}

c0d053be <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d053be:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d053c0:	b083      	sub	sp, #12
c0d053c2:	9202      	str	r2, [sp, #8]
c0d053c4:	4604      	mov	r4, r0
c0d053c6:	4606      	mov	r6, r0
c0d053c8:	36fc      	adds	r6, #252	; 0xfc
c0d053ca:	9101      	str	r1, [sp, #4]
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d053cc:	2900      	cmp	r1, #0
c0d053ce:	d01b      	beq.n	c0d05408 <USBD_LL_DataOutStage+0x4a>
c0d053d0:	2045      	movs	r0, #69	; 0x45
c0d053d2:	0085      	lsls	r5, r0, #2
c0d053d4:	2700      	movs	r7, #0
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d053d6:	4620      	mov	r0, r4
c0d053d8:	4639      	mov	r1, r7
c0d053da:	f000 f8fb 	bl	c0d055d4 <usbd_is_valid_intf>
c0d053de:	2800      	cmp	r0, #0
c0d053e0:	d00d      	beq.n	c0d053fe <USBD_LL_DataOutStage+0x40>
c0d053e2:	5960      	ldr	r0, [r4, r5]
c0d053e4:	6980      	ldr	r0, [r0, #24]
c0d053e6:	2800      	cmp	r0, #0
c0d053e8:	d009      	beq.n	c0d053fe <USBD_LL_DataOutStage+0x40>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d053ea:	7831      	ldrb	r1, [r6, #0]
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d053ec:	2903      	cmp	r1, #3
c0d053ee:	d106      	bne.n	c0d053fe <USBD_LL_DataOutStage+0x40>
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
c0d053f0:	f7fd ffc6 	bl	c0d03380 <pic>
c0d053f4:	4603      	mov	r3, r0
c0d053f6:	4620      	mov	r0, r4
c0d053f8:	9901      	ldr	r1, [sp, #4]
c0d053fa:	9a02      	ldr	r2, [sp, #8]
c0d053fc:	4798      	blx	r3
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d053fe:	3508      	adds	r5, #8
c0d05400:	1c7f      	adds	r7, r7, #1
c0d05402:	2f03      	cmp	r7, #3
c0d05404:	d1e7      	bne.n	c0d053d6 <USBD_LL_DataOutStage+0x18>
c0d05406:	e02f      	b.n	c0d05468 <USBD_LL_DataOutStage+0xaa>
c0d05408:	4620      	mov	r0, r4
c0d0540a:	308c      	adds	r0, #140	; 0x8c
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d0540c:	6e81      	ldr	r1, [r0, #104]	; 0x68
c0d0540e:	2903      	cmp	r1, #3
c0d05410:	d12a      	bne.n	c0d05468 <USBD_LL_DataOutStage+0xaa>
      if(pep->rem_length > pep->maxpacket)
c0d05412:	6802      	ldr	r2, [r0, #0]
c0d05414:	6841      	ldr	r1, [r0, #4]
c0d05416:	428a      	cmp	r2, r1
c0d05418:	d90a      	bls.n	c0d05430 <USBD_LL_DataOutStage+0x72>
        pep->rem_length -=  pep->maxpacket;
c0d0541a:	1a52      	subs	r2, r2, r1
c0d0541c:	6002      	str	r2, [r0, #0]
                            MIN(pep->rem_length ,pep->maxpacket));
c0d0541e:	428a      	cmp	r2, r1
c0d05420:	d300      	bcc.n	c0d05424 <USBD_LL_DataOutStage+0x66>
c0d05422:	460a      	mov	r2, r1
        USBD_CtlContinueRx (pdev, 
c0d05424:	b292      	uxth	r2, r2
c0d05426:	4620      	mov	r0, r4
c0d05428:	9902      	ldr	r1, [sp, #8]
c0d0542a:	f000 fd33 	bl	c0d05e94 <USBD_CtlContinueRx>
c0d0542e:	e01b      	b.n	c0d05468 <USBD_LL_DataOutStage+0xaa>
c0d05430:	2045      	movs	r0, #69	; 0x45
c0d05432:	0087      	lsls	r7, r0, #2
c0d05434:	2500      	movs	r5, #0
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d05436:	4620      	mov	r0, r4
c0d05438:	4629      	mov	r1, r5
c0d0543a:	f000 f8cb 	bl	c0d055d4 <usbd_is_valid_intf>
c0d0543e:	2800      	cmp	r0, #0
c0d05440:	d00b      	beq.n	c0d0545a <USBD_LL_DataOutStage+0x9c>
c0d05442:	59e0      	ldr	r0, [r4, r7]
c0d05444:	6900      	ldr	r0, [r0, #16]
c0d05446:	2800      	cmp	r0, #0
c0d05448:	d007      	beq.n	c0d0545a <USBD_LL_DataOutStage+0x9c>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0544a:	7831      	ldrb	r1, [r6, #0]
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d0544c:	2903      	cmp	r1, #3
c0d0544e:	d104      	bne.n	c0d0545a <USBD_LL_DataOutStage+0x9c>
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
c0d05450:	f7fd ff96 	bl	c0d03380 <pic>
c0d05454:	4601      	mov	r1, r0
c0d05456:	4620      	mov	r0, r4
c0d05458:	4788      	blx	r1
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0545a:	3708      	adds	r7, #8
c0d0545c:	1c6d      	adds	r5, r5, #1
c0d0545e:	2d03      	cmp	r5, #3
c0d05460:	d1e9      	bne.n	c0d05436 <USBD_LL_DataOutStage+0x78>
        USBD_CtlSendStatus(pdev);
c0d05462:	4620      	mov	r0, r4
c0d05464:	f000 fd1d 	bl	c0d05ea2 <USBD_CtlSendStatus>
c0d05468:	2000      	movs	r0, #0
      }
    }
  }  
  return USBD_OK;
c0d0546a:	b003      	add	sp, #12
c0d0546c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0546e <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d0546e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05470:	b081      	sub	sp, #4
c0d05472:	4604      	mov	r4, r0
c0d05474:	4607      	mov	r7, r0
c0d05476:	37f4      	adds	r7, #244	; 0xf4
c0d05478:	9100      	str	r1, [sp, #0]
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d0547a:	2900      	cmp	r1, #0
c0d0547c:	d01b      	beq.n	c0d054b6 <USBD_LL_DataInStage+0x48>
c0d0547e:	463d      	mov	r5, r7
c0d05480:	2045      	movs	r0, #69	; 0x45
c0d05482:	0087      	lsls	r7, r0, #2
c0d05484:	2600      	movs	r6, #0
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d05486:	4620      	mov	r0, r4
c0d05488:	4631      	mov	r1, r6
c0d0548a:	f000 f8a3 	bl	c0d055d4 <usbd_is_valid_intf>
c0d0548e:	2800      	cmp	r0, #0
c0d05490:	d00c      	beq.n	c0d054ac <USBD_LL_DataInStage+0x3e>
c0d05492:	59e0      	ldr	r0, [r4, r7]
c0d05494:	6940      	ldr	r0, [r0, #20]
c0d05496:	2800      	cmp	r0, #0
c0d05498:	d008      	beq.n	c0d054ac <USBD_LL_DataInStage+0x3e>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0549a:	7a29      	ldrb	r1, [r5, #8]
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d0549c:	2903      	cmp	r1, #3
c0d0549e:	d105      	bne.n	c0d054ac <USBD_LL_DataInStage+0x3e>
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
c0d054a0:	f7fd ff6e 	bl	c0d03380 <pic>
c0d054a4:	4602      	mov	r2, r0
c0d054a6:	4620      	mov	r0, r4
c0d054a8:	9900      	ldr	r1, [sp, #0]
c0d054aa:	4790      	blx	r2
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d054ac:	3708      	adds	r7, #8
c0d054ae:	1c76      	adds	r6, r6, #1
c0d054b0:	2e03      	cmp	r6, #3
c0d054b2:	d1e8      	bne.n	c0d05486 <USBD_LL_DataInStage+0x18>
c0d054b4:	e046      	b.n	c0d05544 <USBD_LL_DataInStage+0xd6>
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d054b6:	6838      	ldr	r0, [r7, #0]
c0d054b8:	2802      	cmp	r0, #2
c0d054ba:	d13d      	bne.n	c0d05538 <USBD_LL_DataInStage+0xca>
      if(pep->rem_length > pep->maxpacket)
c0d054bc:	69e0      	ldr	r0, [r4, #28]
c0d054be:	6a25      	ldr	r5, [r4, #32]
c0d054c0:	42a8      	cmp	r0, r5
c0d054c2:	d909      	bls.n	c0d054d8 <USBD_LL_DataInStage+0x6a>
        pep->rem_length -=  pep->maxpacket;
c0d054c4:	1b40      	subs	r0, r0, r5
c0d054c6:	61e0      	str	r0, [r4, #28]
        pdev->pData = (uint8_t *)pdev->pData + pep->maxpacket;
c0d054c8:	6bf9      	ldr	r1, [r7, #60]	; 0x3c
c0d054ca:	1949      	adds	r1, r1, r5
c0d054cc:	63f9      	str	r1, [r7, #60]	; 0x3c
        USBD_CtlContinueSendData (pdev, 
c0d054ce:	b282      	uxth	r2, r0
c0d054d0:	4620      	mov	r0, r4
c0d054d2:	f000 fcd1 	bl	c0d05e78 <USBD_CtlContinueSendData>
c0d054d6:	e02f      	b.n	c0d05538 <USBD_LL_DataInStage+0xca>
        if((pep->total_length % pep->maxpacket == 0) &&
c0d054d8:	69a6      	ldr	r6, [r4, #24]
c0d054da:	4630      	mov	r0, r6
c0d054dc:	4629      	mov	r1, r5
c0d054de:	f001 fdbd 	bl	c0d0705c <__aeabi_uidivmod>
c0d054e2:	42ae      	cmp	r6, r5
c0d054e4:	d30c      	bcc.n	c0d05500 <USBD_LL_DataInStage+0x92>
c0d054e6:	2900      	cmp	r1, #0
c0d054e8:	d10a      	bne.n	c0d05500 <USBD_LL_DataInStage+0x92>
             (pep->total_length < pdev->ep0_data_len ))
c0d054ea:	6878      	ldr	r0, [r7, #4]
        if((pep->total_length % pep->maxpacket == 0) &&
c0d054ec:	4286      	cmp	r6, r0
c0d054ee:	d207      	bcs.n	c0d05500 <USBD_LL_DataInStage+0x92>
c0d054f0:	2500      	movs	r5, #0
          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d054f2:	4620      	mov	r0, r4
c0d054f4:	4629      	mov	r1, r5
c0d054f6:	462a      	mov	r2, r5
c0d054f8:	f000 fcbe 	bl	c0d05e78 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d054fc:	607d      	str	r5, [r7, #4]
c0d054fe:	e01b      	b.n	c0d05538 <USBD_LL_DataInStage+0xca>
c0d05500:	2045      	movs	r0, #69	; 0x45
c0d05502:	0086      	lsls	r6, r0, #2
c0d05504:	2500      	movs	r5, #0
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d05506:	4620      	mov	r0, r4
c0d05508:	4629      	mov	r1, r5
c0d0550a:	f000 f863 	bl	c0d055d4 <usbd_is_valid_intf>
c0d0550e:	2800      	cmp	r0, #0
c0d05510:	d00b      	beq.n	c0d0552a <USBD_LL_DataInStage+0xbc>
c0d05512:	59a0      	ldr	r0, [r4, r6]
c0d05514:	68c0      	ldr	r0, [r0, #12]
c0d05516:	2800      	cmp	r0, #0
c0d05518:	d007      	beq.n	c0d0552a <USBD_LL_DataInStage+0xbc>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0551a:	7a39      	ldrb	r1, [r7, #8]
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d0551c:	2903      	cmp	r1, #3
c0d0551e:	d104      	bne.n	c0d0552a <USBD_LL_DataInStage+0xbc>
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
c0d05520:	f7fd ff2e 	bl	c0d03380 <pic>
c0d05524:	4601      	mov	r1, r0
c0d05526:	4620      	mov	r0, r4
c0d05528:	4788      	blx	r1
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0552a:	3608      	adds	r6, #8
c0d0552c:	1c6d      	adds	r5, r5, #1
c0d0552e:	2d03      	cmp	r5, #3
c0d05530:	d1e9      	bne.n	c0d05506 <USBD_LL_DataInStage+0x98>
          USBD_CtlReceiveStatus(pdev);
c0d05532:	4620      	mov	r0, r4
c0d05534:	f000 fcc1 	bl	c0d05eba <USBD_CtlReceiveStatus>
    if (pdev->dev_test_mode == 1)
c0d05538:	7b38      	ldrb	r0, [r7, #12]
c0d0553a:	2801      	cmp	r0, #1
c0d0553c:	d102      	bne.n	c0d05544 <USBD_LL_DataInStage+0xd6>
c0d0553e:	4639      	mov	r1, r7
c0d05540:	2000      	movs	r0, #0
      pdev->dev_test_mode = 0;
c0d05542:	7338      	strb	r0, [r7, #12]
c0d05544:	2000      	movs	r0, #0
      }
    }
  }
  return USBD_OK;
c0d05546:	b001      	add	sp, #4
c0d05548:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0554a <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d0554a:	b570      	push	{r4, r5, r6, lr}
c0d0554c:	4604      	mov	r4, r0
c0d0554e:	20fc      	movs	r0, #252	; 0xfc
c0d05550:	2101      	movs	r1, #1
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d05552:	5421      	strb	r1, [r4, r0]
c0d05554:	2090      	movs	r0, #144	; 0x90
c0d05556:	2140      	movs	r1, #64	; 0x40
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d05558:	5021      	str	r1, [r4, r0]
  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d0555a:	6221      	str	r1, [r4, #32]
c0d0555c:	2045      	movs	r0, #69	; 0x45
c0d0555e:	0086      	lsls	r6, r0, #2
c0d05560:	2500      	movs	r5, #0
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if( usbd_is_valid_intf(pdev, intf))
c0d05562:	4620      	mov	r0, r4
c0d05564:	4629      	mov	r1, r5
c0d05566:	f000 f835 	bl	c0d055d4 <usbd_is_valid_intf>
c0d0556a:	2800      	cmp	r0, #0
c0d0556c:	d007      	beq.n	c0d0557e <USBD_LL_Reset+0x34>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
c0d0556e:	59a0      	ldr	r0, [r4, r6]
c0d05570:	6840      	ldr	r0, [r0, #4]
c0d05572:	f7fd ff05 	bl	c0d03380 <pic>
c0d05576:	4602      	mov	r2, r0
c0d05578:	7921      	ldrb	r1, [r4, #4]
c0d0557a:	4620      	mov	r0, r4
c0d0557c:	4790      	blx	r2
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0557e:	3608      	adds	r6, #8
c0d05580:	1c6d      	adds	r5, r5, #1
c0d05582:	2d03      	cmp	r5, #3
c0d05584:	d1ed      	bne.n	c0d05562 <USBD_LL_Reset+0x18>
c0d05586:	2000      	movs	r0, #0
    }
  }
  
  return USBD_OK;
c0d05588:	bd70      	pop	{r4, r5, r6, pc}

c0d0558a <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d0558a:	7401      	strb	r1, [r0, #16]
c0d0558c:	2000      	movs	r0, #0
  return USBD_OK;
c0d0558e:	4770      	bx	lr

c0d05590 <USBD_LL_Suspend>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Suspend(USBD_HandleTypeDef  *pdev)
{
c0d05590:	2000      	movs	r0, #0
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d05592:	4770      	bx	lr

c0d05594 <USBD_LL_Resume>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
c0d05594:	2000      	movs	r0, #0
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d05596:	4770      	bx	lr

c0d05598 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d05598:	b570      	push	{r4, r5, r6, lr}
c0d0559a:	4604      	mov	r4, r0
c0d0559c:	20fc      	movs	r0, #252	; 0xfc
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d0559e:	5c20      	ldrb	r0, [r4, r0]
c0d055a0:	2803      	cmp	r0, #3
c0d055a2:	d115      	bne.n	c0d055d0 <USBD_LL_SOF+0x38>
c0d055a4:	2045      	movs	r0, #69	; 0x45
c0d055a6:	0086      	lsls	r6, r0, #2
c0d055a8:	2500      	movs	r5, #0
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && pdev->interfacesClass[intf].pClass->SOF != NULL)
c0d055aa:	4620      	mov	r0, r4
c0d055ac:	4629      	mov	r1, r5
c0d055ae:	f000 f811 	bl	c0d055d4 <usbd_is_valid_intf>
c0d055b2:	2800      	cmp	r0, #0
c0d055b4:	d008      	beq.n	c0d055c8 <USBD_LL_SOF+0x30>
c0d055b6:	59a0      	ldr	r0, [r4, r6]
c0d055b8:	69c0      	ldr	r0, [r0, #28]
c0d055ba:	2800      	cmp	r0, #0
c0d055bc:	d004      	beq.n	c0d055c8 <USBD_LL_SOF+0x30>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
c0d055be:	f7fd fedf 	bl	c0d03380 <pic>
c0d055c2:	4601      	mov	r1, r0
c0d055c4:	4620      	mov	r0, r4
c0d055c6:	4788      	blx	r1
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d055c8:	3608      	adds	r6, #8
c0d055ca:	1c6d      	adds	r5, r5, #1
c0d055cc:	2d03      	cmp	r5, #3
c0d055ce:	d1ec      	bne.n	c0d055aa <USBD_LL_SOF+0x12>
c0d055d0:	2000      	movs	r0, #0
      }
    }
  }
  return USBD_OK;
c0d055d2:	bd70      	pop	{r4, r5, r6, pc}

c0d055d4 <usbd_is_valid_intf>:
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d055d4:	2902      	cmp	r1, #2
c0d055d6:	d807      	bhi.n	c0d055e8 <usbd_is_valid_intf+0x14>
c0d055d8:	00c9      	lsls	r1, r1, #3
c0d055da:	1840      	adds	r0, r0, r1
c0d055dc:	2145      	movs	r1, #69	; 0x45
c0d055de:	0089      	lsls	r1, r1, #2
c0d055e0:	5840      	ldr	r0, [r0, r1]
c0d055e2:	1e41      	subs	r1, r0, #1
c0d055e4:	4188      	sbcs	r0, r1
c0d055e6:	4770      	bx	lr
c0d055e8:	2000      	movs	r0, #0
c0d055ea:	4770      	bx	lr

c0d055ec <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d055ec:	b580      	push	{r7, lr}
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d055ee:	784a      	ldrb	r2, [r1, #1]
c0d055f0:	2a04      	cmp	r2, #4
c0d055f2:	dd08      	ble.n	c0d05606 <USBD_StdDevReq+0x1a>
c0d055f4:	2a07      	cmp	r2, #7
c0d055f6:	dc0f      	bgt.n	c0d05618 <USBD_StdDevReq+0x2c>
c0d055f8:	2a05      	cmp	r2, #5
c0d055fa:	d014      	beq.n	c0d05626 <USBD_StdDevReq+0x3a>
c0d055fc:	2a06      	cmp	r2, #6
c0d055fe:	d11b      	bne.n	c0d05638 <USBD_StdDevReq+0x4c>
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d05600:	f000 f821 	bl	c0d05646 <USBD_GetDescriptor>
c0d05604:	e01d      	b.n	c0d05642 <USBD_StdDevReq+0x56>
  switch (req->bRequest) 
c0d05606:	2a00      	cmp	r2, #0
c0d05608:	d010      	beq.n	c0d0562c <USBD_StdDevReq+0x40>
c0d0560a:	2a01      	cmp	r2, #1
c0d0560c:	d017      	beq.n	c0d0563e <USBD_StdDevReq+0x52>
c0d0560e:	2a03      	cmp	r2, #3
c0d05610:	d112      	bne.n	c0d05638 <USBD_StdDevReq+0x4c>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d05612:	f000 f92b 	bl	c0d0586c <USBD_SetFeature>
c0d05616:	e014      	b.n	c0d05642 <USBD_StdDevReq+0x56>
  switch (req->bRequest) 
c0d05618:	2a08      	cmp	r2, #8
c0d0561a:	d00a      	beq.n	c0d05632 <USBD_StdDevReq+0x46>
c0d0561c:	2a09      	cmp	r2, #9
c0d0561e:	d10b      	bne.n	c0d05638 <USBD_StdDevReq+0x4c>
    USBD_SetConfig (pdev , req);
c0d05620:	f000 f8b2 	bl	c0d05788 <USBD_SetConfig>
c0d05624:	e00d      	b.n	c0d05642 <USBD_StdDevReq+0x56>
    USBD_SetAddress(pdev, req);
c0d05626:	f000 f88c 	bl	c0d05742 <USBD_SetAddress>
c0d0562a:	e00a      	b.n	c0d05642 <USBD_StdDevReq+0x56>
    USBD_GetStatus (pdev , req);
c0d0562c:	f000 f8fa 	bl	c0d05824 <USBD_GetStatus>
c0d05630:	e007      	b.n	c0d05642 <USBD_StdDevReq+0x56>
    USBD_GetConfig (pdev , req);
c0d05632:	f000 f8e0 	bl	c0d057f6 <USBD_GetConfig>
c0d05636:	e004      	b.n	c0d05642 <USBD_StdDevReq+0x56>
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
    break;
    
  default:  
    USBD_CtlError(pdev , req);
c0d05638:	f000 fb78 	bl	c0d05d2c <USBD_CtlError>
c0d0563c:	e001      	b.n	c0d05642 <USBD_StdDevReq+0x56>
    USBD_ClrFeature (pdev , req);
c0d0563e:	f000 f934 	bl	c0d058aa <USBD_ClrFeature>
c0d05642:	2000      	movs	r0, #0
    break;
  }
  
  return ret;
c0d05644:	bd80      	pop	{r7, pc}

c0d05646 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d05646:	b5b0      	push	{r4, r5, r7, lr}
c0d05648:	b082      	sub	sp, #8
c0d0564a:	460d      	mov	r5, r1
c0d0564c:	4604      	mov	r4, r0
c0d0564e:	a801      	add	r0, sp, #4
c0d05650:	2100      	movs	r1, #0
  uint16_t len = 0;
c0d05652:	8001      	strh	r1, [r0, #0]
c0d05654:	2011      	movs	r0, #17
c0d05656:	0100      	lsls	r0, r0, #4
c0d05658:	1820      	adds	r0, r4, r0
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d0565a:	886b      	ldrh	r3, [r5, #2]
c0d0565c:	0a1a      	lsrs	r2, r3, #8
c0d0565e:	2a05      	cmp	r2, #5
c0d05660:	dc11      	bgt.n	c0d05686 <USBD_GetDescriptor+0x40>
c0d05662:	2a01      	cmp	r2, #1
c0d05664:	d01a      	beq.n	c0d0569c <USBD_GetDescriptor+0x56>
c0d05666:	2a02      	cmp	r2, #2
c0d05668:	d021      	beq.n	c0d056ae <USBD_GetDescriptor+0x68>
c0d0566a:	2a03      	cmp	r2, #3
c0d0566c:	d132      	bne.n	c0d056d4 <USBD_GetDescriptor+0x8e>
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d0566e:	b2d9      	uxtb	r1, r3
c0d05670:	2902      	cmp	r1, #2
c0d05672:	dc34      	bgt.n	c0d056de <USBD_GetDescriptor+0x98>
c0d05674:	2900      	cmp	r1, #0
c0d05676:	d058      	beq.n	c0d0572a <USBD_GetDescriptor+0xe4>
c0d05678:	2901      	cmp	r1, #1
c0d0567a:	d05c      	beq.n	c0d05736 <USBD_GetDescriptor+0xf0>
c0d0567c:	2902      	cmp	r1, #2
c0d0567e:	d129      	bne.n	c0d056d4 <USBD_GetDescriptor+0x8e>
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d05680:	6800      	ldr	r0, [r0, #0]
c0d05682:	68c0      	ldr	r0, [r0, #12]
c0d05684:	e00c      	b.n	c0d056a0 <USBD_GetDescriptor+0x5a>
  switch (req->wValue >> 8)
c0d05686:	2a06      	cmp	r2, #6
c0d05688:	d019      	beq.n	c0d056be <USBD_GetDescriptor+0x78>
c0d0568a:	2a07      	cmp	r2, #7
c0d0568c:	d01f      	beq.n	c0d056ce <USBD_GetDescriptor+0x88>
c0d0568e:	2a0f      	cmp	r2, #15
c0d05690:	d120      	bne.n	c0d056d4 <USBD_GetDescriptor+0x8e>
    if(pdev->pDesc->GetBOSDescriptor != NULL) {
c0d05692:	6800      	ldr	r0, [r0, #0]
c0d05694:	69c0      	ldr	r0, [r0, #28]
c0d05696:	2800      	cmp	r0, #0
c0d05698:	d102      	bne.n	c0d056a0 <USBD_GetDescriptor+0x5a>
c0d0569a:	e01b      	b.n	c0d056d4 <USBD_GetDescriptor+0x8e>
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d0569c:	6800      	ldr	r0, [r0, #0]
c0d0569e:	6800      	ldr	r0, [r0, #0]
c0d056a0:	f7fd fe6e 	bl	c0d03380 <pic>
c0d056a4:	4602      	mov	r2, r0
c0d056a6:	7c20      	ldrb	r0, [r4, #16]
c0d056a8:	a901      	add	r1, sp, #4
c0d056aa:	4790      	blx	r2
c0d056ac:	e02b      	b.n	c0d05706 <USBD_GetDescriptor+0xc0>
    if(pdev->interfacesClass[0].pClass != NULL) {
c0d056ae:	6840      	ldr	r0, [r0, #4]
c0d056b0:	2800      	cmp	r0, #0
c0d056b2:	d029      	beq.n	c0d05708 <USBD_GetDescriptor+0xc2>
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d056b4:	7c21      	ldrb	r1, [r4, #16]
c0d056b6:	2900      	cmp	r1, #0
c0d056b8:	d01f      	beq.n	c0d056fa <USBD_GetDescriptor+0xb4>
        pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetFSConfigDescriptor))(&len);
c0d056ba:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d056bc:	e01e      	b.n	c0d056fc <USBD_GetDescriptor+0xb6>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL )   
c0d056be:	7c21      	ldrb	r1, [r4, #16]
c0d056c0:	2900      	cmp	r1, #0
c0d056c2:	d107      	bne.n	c0d056d4 <USBD_GetDescriptor+0x8e>
c0d056c4:	6840      	ldr	r0, [r0, #4]
c0d056c6:	2800      	cmp	r0, #0
c0d056c8:	d004      	beq.n	c0d056d4 <USBD_GetDescriptor+0x8e>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetDeviceQualifierDescriptor))(&len);
c0d056ca:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d056cc:	e016      	b.n	c0d056fc <USBD_GetDescriptor+0xb6>
    {
      goto default_error;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d056ce:	7c21      	ldrb	r1, [r4, #16]
c0d056d0:	2900      	cmp	r1, #0
c0d056d2:	d00d      	beq.n	c0d056f0 <USBD_GetDescriptor+0xaa>
      goto default_error;
    }

  default: 
  default_error:
     USBD_CtlError(pdev , req);
c0d056d4:	4620      	mov	r0, r4
c0d056d6:	4629      	mov	r1, r5
c0d056d8:	f000 fb28 	bl	c0d05d2c <USBD_CtlError>
c0d056dc:	e023      	b.n	c0d05726 <USBD_GetDescriptor+0xe0>
    switch ((uint8_t)(req->wValue))
c0d056de:	2903      	cmp	r1, #3
c0d056e0:	d026      	beq.n	c0d05730 <USBD_GetDescriptor+0xea>
c0d056e2:	2904      	cmp	r1, #4
c0d056e4:	d02a      	beq.n	c0d0573c <USBD_GetDescriptor+0xf6>
c0d056e6:	2905      	cmp	r1, #5
c0d056e8:	d1f4      	bne.n	c0d056d4 <USBD_GetDescriptor+0x8e>
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d056ea:	6800      	ldr	r0, [r0, #0]
c0d056ec:	6980      	ldr	r0, [r0, #24]
c0d056ee:	e7d7      	b.n	c0d056a0 <USBD_GetDescriptor+0x5a>
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d056f0:	6840      	ldr	r0, [r0, #4]
c0d056f2:	2800      	cmp	r0, #0
c0d056f4:	d0ee      	beq.n	c0d056d4 <USBD_GetDescriptor+0x8e>
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d056f6:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d056f8:	e000      	b.n	c0d056fc <USBD_GetDescriptor+0xb6>
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
c0d056fa:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d056fc:	f7fd fe40 	bl	c0d03380 <pic>
c0d05700:	4601      	mov	r1, r0
c0d05702:	a801      	add	r0, sp, #4
c0d05704:	4788      	blx	r1
c0d05706:	4601      	mov	r1, r0
c0d05708:	a801      	add	r0, sp, #4
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d0570a:	8802      	ldrh	r2, [r0, #0]
c0d0570c:	2a00      	cmp	r2, #0
c0d0570e:	d00a      	beq.n	c0d05726 <USBD_GetDescriptor+0xe0>
c0d05710:	88e8      	ldrh	r0, [r5, #6]
c0d05712:	2800      	cmp	r0, #0
c0d05714:	d007      	beq.n	c0d05726 <USBD_GetDescriptor+0xe0>
  {
    
    len = MIN(len , req->wLength);
c0d05716:	4282      	cmp	r2, r0
c0d05718:	d300      	bcc.n	c0d0571c <USBD_GetDescriptor+0xd6>
c0d0571a:	4602      	mov	r2, r0
c0d0571c:	a801      	add	r0, sp, #4
c0d0571e:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d05720:	4620      	mov	r0, r4
c0d05722:	f000 fb93 	bl	c0d05e4c <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d05726:	b002      	add	sp, #8
c0d05728:	bdb0      	pop	{r4, r5, r7, pc}
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d0572a:	6800      	ldr	r0, [r0, #0]
c0d0572c:	6840      	ldr	r0, [r0, #4]
c0d0572e:	e7b7      	b.n	c0d056a0 <USBD_GetDescriptor+0x5a>
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d05730:	6800      	ldr	r0, [r0, #0]
c0d05732:	6900      	ldr	r0, [r0, #16]
c0d05734:	e7b4      	b.n	c0d056a0 <USBD_GetDescriptor+0x5a>
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d05736:	6800      	ldr	r0, [r0, #0]
c0d05738:	6880      	ldr	r0, [r0, #8]
c0d0573a:	e7b1      	b.n	c0d056a0 <USBD_GetDescriptor+0x5a>
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d0573c:	6800      	ldr	r0, [r0, #0]
c0d0573e:	6940      	ldr	r0, [r0, #20]
c0d05740:	e7ae      	b.n	c0d056a0 <USBD_GetDescriptor+0x5a>

c0d05742 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d05742:	b570      	push	{r4, r5, r6, lr}
c0d05744:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d05746:	8888      	ldrh	r0, [r1, #4]
c0d05748:	2800      	cmp	r0, #0
c0d0574a:	d107      	bne.n	c0d0575c <USBD_SetAddress+0x1a>
c0d0574c:	88c8      	ldrh	r0, [r1, #6]
c0d0574e:	2800      	cmp	r0, #0
c0d05750:	d104      	bne.n	c0d0575c <USBD_SetAddress+0x1a>
c0d05752:	4626      	mov	r6, r4
c0d05754:	36fc      	adds	r6, #252	; 0xfc
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d05756:	7830      	ldrb	r0, [r6, #0]
c0d05758:	2803      	cmp	r0, #3
c0d0575a:	d103      	bne.n	c0d05764 <USBD_SetAddress+0x22>
c0d0575c:	4620      	mov	r0, r4
c0d0575e:	f000 fae5 	bl	c0d05d2c <USBD_CtlError>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d05762:	bd70      	pop	{r4, r5, r6, pc}
c0d05764:	7888      	ldrb	r0, [r1, #2]
c0d05766:	257f      	movs	r5, #127	; 0x7f
c0d05768:	4005      	ands	r5, r0
      pdev->dev_address = dev_addr;
c0d0576a:	70b5      	strb	r5, [r6, #2]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d0576c:	4620      	mov	r0, r4
c0d0576e:	4629      	mov	r1, r5
c0d05770:	f7ff fd32 	bl	c0d051d8 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d05774:	4620      	mov	r0, r4
c0d05776:	f000 fb94 	bl	c0d05ea2 <USBD_CtlSendStatus>
      if (dev_addr != 0) 
c0d0577a:	2d00      	cmp	r5, #0
c0d0577c:	d001      	beq.n	c0d05782 <USBD_SetAddress+0x40>
c0d0577e:	2002      	movs	r0, #2
c0d05780:	e000      	b.n	c0d05784 <USBD_SetAddress+0x42>
c0d05782:	2001      	movs	r0, #1
c0d05784:	7030      	strb	r0, [r6, #0]
}
c0d05786:	bd70      	pop	{r4, r5, r6, pc}

c0d05788 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d05788:	b570      	push	{r4, r5, r6, lr}
c0d0578a:	460d      	mov	r5, r1
c0d0578c:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d0578e:	788e      	ldrb	r6, [r1, #2]
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d05790:	2e02      	cmp	r6, #2
c0d05792:	d21c      	bcs.n	c0d057ce <USBD_SetConfig+0x46>
c0d05794:	20fc      	movs	r0, #252	; 0xfc
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d05796:	5c21      	ldrb	r1, [r4, r0]
c0d05798:	4620      	mov	r0, r4
c0d0579a:	30fc      	adds	r0, #252	; 0xfc
c0d0579c:	2903      	cmp	r1, #3
c0d0579e:	d006      	beq.n	c0d057ae <USBD_SetConfig+0x26>
c0d057a0:	2902      	cmp	r1, #2
c0d057a2:	d114      	bne.n	c0d057ce <USBD_SetConfig+0x46>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d057a4:	2e00      	cmp	r6, #0
c0d057a6:	d022      	beq.n	c0d057ee <USBD_SetConfig+0x66>
c0d057a8:	2103      	movs	r1, #3
      {                                                                               
        pdev->dev_config = cfgidx;
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d057aa:	7001      	strb	r1, [r0, #0]
c0d057ac:	e008      	b.n	c0d057c0 <USBD_SetConfig+0x38>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d057ae:	2e00      	cmp	r6, #0
c0d057b0:	d012      	beq.n	c0d057d8 <USBD_SetConfig+0x50>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d057b2:	6860      	ldr	r0, [r4, #4]
c0d057b4:	42b0      	cmp	r0, r6
c0d057b6:	d01a      	beq.n	c0d057ee <USBD_SetConfig+0x66>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d057b8:	b2c1      	uxtb	r1, r0
c0d057ba:	4620      	mov	r0, r4
c0d057bc:	f7ff fdb4 	bl	c0d05328 <USBD_ClrClassConfig>
c0d057c0:	6066      	str	r6, [r4, #4]
c0d057c2:	4620      	mov	r0, r4
c0d057c4:	4631      	mov	r1, r6
c0d057c6:	f7ff fd93 	bl	c0d052f0 <USBD_SetClassConfig>
c0d057ca:	2802      	cmp	r0, #2
c0d057cc:	d10f      	bne.n	c0d057ee <USBD_SetConfig+0x66>
c0d057ce:	4620      	mov	r0, r4
c0d057d0:	4629      	mov	r1, r5
c0d057d2:	f000 faab 	bl	c0d05d2c <USBD_CtlError>
    default:          
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d057d6:	bd70      	pop	{r4, r5, r6, pc}
c0d057d8:	2100      	movs	r1, #0
        pdev->dev_config = cfgidx;          
c0d057da:	6061      	str	r1, [r4, #4]
c0d057dc:	2102      	movs	r1, #2
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d057de:	7001      	strb	r1, [r0, #0]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d057e0:	4620      	mov	r0, r4
c0d057e2:	4631      	mov	r1, r6
c0d057e4:	f7ff fda0 	bl	c0d05328 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d057e8:	4620      	mov	r0, r4
c0d057ea:	f000 fb5a 	bl	c0d05ea2 <USBD_CtlSendStatus>
c0d057ee:	4620      	mov	r0, r4
c0d057f0:	f000 fb57 	bl	c0d05ea2 <USBD_CtlSendStatus>
}
c0d057f4:	bd70      	pop	{r4, r5, r6, pc}

c0d057f6 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d057f6:	b580      	push	{r7, lr}

  if (req->wLength != 1) 
c0d057f8:	88ca      	ldrh	r2, [r1, #6]
c0d057fa:	2a01      	cmp	r2, #1
c0d057fc:	d10a      	bne.n	c0d05814 <USBD_GetConfig+0x1e>
c0d057fe:	22fc      	movs	r2, #252	; 0xfc
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d05800:	5c82      	ldrb	r2, [r0, r2]
c0d05802:	2a03      	cmp	r2, #3
c0d05804:	d009      	beq.n	c0d0581a <USBD_GetConfig+0x24>
c0d05806:	2a02      	cmp	r2, #2
c0d05808:	d104      	bne.n	c0d05814 <USBD_GetConfig+0x1e>
c0d0580a:	2100      	movs	r1, #0
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d0580c:	6081      	str	r1, [r0, #8]
c0d0580e:	4601      	mov	r1, r0
c0d05810:	3108      	adds	r1, #8
c0d05812:	e003      	b.n	c0d0581c <USBD_GetConfig+0x26>
c0d05814:	f000 fa8a 	bl	c0d05d2c <USBD_CtlError>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d05818:	bd80      	pop	{r7, pc}
                        (uint8_t *)&pdev->dev_config,
c0d0581a:	1d01      	adds	r1, r0, #4
c0d0581c:	2201      	movs	r2, #1
c0d0581e:	f000 fb15 	bl	c0d05e4c <USBD_CtlSendData>
}
c0d05822:	bd80      	pop	{r7, pc}

c0d05824 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d05824:	b5b0      	push	{r4, r5, r7, lr}
c0d05826:	4604      	mov	r4, r0
c0d05828:	20fc      	movs	r0, #252	; 0xfc
  
    
  switch (pdev->dev_state) 
c0d0582a:	5c20      	ldrb	r0, [r4, r0]
c0d0582c:	22fe      	movs	r2, #254	; 0xfe
c0d0582e:	4002      	ands	r2, r0
c0d05830:	2a02      	cmp	r2, #2
c0d05832:	d10f      	bne.n	c0d05854 <USBD_GetStatus+0x30>
c0d05834:	4620      	mov	r0, r4
c0d05836:	30fc      	adds	r0, #252	; 0xfc
c0d05838:	2101      	movs	r1, #1
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d0583a:	60e1      	str	r1, [r4, #12]
c0d0583c:	4625      	mov	r5, r4
c0d0583e:	350c      	adds	r5, #12
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d05840:	6880      	ldr	r0, [r0, #8]
c0d05842:	2800      	cmp	r0, #0
c0d05844:	d00a      	beq.n	c0d0585c <USBD_GetStatus+0x38>
c0d05846:	4620      	mov	r0, r4
c0d05848:	f000 fb37 	bl	c0d05eba <USBD_CtlReceiveStatus>
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d0584c:	68e1      	ldr	r1, [r4, #12]
c0d0584e:	2002      	movs	r0, #2
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d05850:	4308      	orrs	r0, r1
c0d05852:	e004      	b.n	c0d0585e <USBD_GetStatus+0x3a>
                      (uint8_t *)& pdev->dev_config_status,
                      2);
    break;
    
  default :
    USBD_CtlError(pdev , req);                        
c0d05854:	4620      	mov	r0, r4
c0d05856:	f000 fa69 	bl	c0d05d2c <USBD_CtlError>
    break;
  }
}
c0d0585a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0585c:	2003      	movs	r0, #3
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d0585e:	60e0      	str	r0, [r4, #12]
c0d05860:	2202      	movs	r2, #2
    USBD_CtlSendData (pdev, 
c0d05862:	4620      	mov	r0, r4
c0d05864:	4629      	mov	r1, r5
c0d05866:	f000 faf1 	bl	c0d05e4c <USBD_CtlSendData>
}
c0d0586a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0586c <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0586c:	b5b0      	push	{r4, r5, r7, lr}
c0d0586e:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d05870:	8848      	ldrh	r0, [r1, #2]
c0d05872:	2801      	cmp	r0, #1
c0d05874:	d118      	bne.n	c0d058a8 <USBD_SetFeature+0x3c>
c0d05876:	460d      	mov	r5, r1
c0d05878:	2041      	movs	r0, #65	; 0x41
c0d0587a:	0080      	lsls	r0, r0, #2
c0d0587c:	2101      	movs	r1, #1
  {
    pdev->dev_remote_wakeup = 1;  
c0d0587e:	5021      	str	r1, [r4, r0]
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d05880:	7928      	ldrb	r0, [r5, #4]
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d05882:	2802      	cmp	r0, #2
c0d05884:	d80d      	bhi.n	c0d058a2 <USBD_SetFeature+0x36>
c0d05886:	00c0      	lsls	r0, r0, #3
c0d05888:	1820      	adds	r0, r4, r0
c0d0588a:	2145      	movs	r1, #69	; 0x45
c0d0588c:	0089      	lsls	r1, r1, #2
c0d0588e:	5840      	ldr	r0, [r0, r1]
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d05890:	2800      	cmp	r0, #0
c0d05892:	d006      	beq.n	c0d058a2 <USBD_SetFeature+0x36>
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d05894:	6880      	ldr	r0, [r0, #8]
c0d05896:	f7fd fd73 	bl	c0d03380 <pic>
c0d0589a:	4602      	mov	r2, r0
c0d0589c:	4620      	mov	r0, r4
c0d0589e:	4629      	mov	r1, r5
c0d058a0:	4790      	blx	r2
    }
    USBD_CtlSendStatus(pdev);
c0d058a2:	4620      	mov	r0, r4
c0d058a4:	f000 fafd 	bl	c0d05ea2 <USBD_CtlSendStatus>
  }

}
c0d058a8:	bdb0      	pop	{r4, r5, r7, pc}

c0d058aa <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d058aa:	b5b0      	push	{r4, r5, r7, lr}
c0d058ac:	460d      	mov	r5, r1
c0d058ae:	4604      	mov	r4, r0
c0d058b0:	20fc      	movs	r0, #252	; 0xfc
  switch (pdev->dev_state)
c0d058b2:	5c20      	ldrb	r0, [r4, r0]
c0d058b4:	21fe      	movs	r1, #254	; 0xfe
c0d058b6:	4001      	ands	r1, r0
c0d058b8:	2902      	cmp	r1, #2
c0d058ba:	d11b      	bne.n	c0d058f4 <USBD_ClrFeature+0x4a>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d058bc:	8868      	ldrh	r0, [r5, #2]
c0d058be:	2801      	cmp	r0, #1
c0d058c0:	d11c      	bne.n	c0d058fc <USBD_ClrFeature+0x52>
c0d058c2:	4620      	mov	r0, r4
c0d058c4:	30fc      	adds	r0, #252	; 0xfc
c0d058c6:	2100      	movs	r1, #0
    {
      pdev->dev_remote_wakeup = 0; 
c0d058c8:	6081      	str	r1, [r0, #8]
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d058ca:	7928      	ldrb	r0, [r5, #4]
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d058cc:	2802      	cmp	r0, #2
c0d058ce:	d80d      	bhi.n	c0d058ec <USBD_ClrFeature+0x42>
c0d058d0:	00c0      	lsls	r0, r0, #3
c0d058d2:	1820      	adds	r0, r4, r0
c0d058d4:	2145      	movs	r1, #69	; 0x45
c0d058d6:	0089      	lsls	r1, r1, #2
c0d058d8:	5840      	ldr	r0, [r0, r1]
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d058da:	2800      	cmp	r0, #0
c0d058dc:	d006      	beq.n	c0d058ec <USBD_ClrFeature+0x42>
        ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d058de:	6880      	ldr	r0, [r0, #8]
c0d058e0:	f7fd fd4e 	bl	c0d03380 <pic>
c0d058e4:	4602      	mov	r2, r0
c0d058e6:	4620      	mov	r0, r4
c0d058e8:	4629      	mov	r1, r5
c0d058ea:	4790      	blx	r2
      }
      USBD_CtlSendStatus(pdev);
c0d058ec:	4620      	mov	r0, r4
c0d058ee:	f000 fad8 	bl	c0d05ea2 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d058f2:	bdb0      	pop	{r4, r5, r7, pc}
     USBD_CtlError(pdev , req);
c0d058f4:	4620      	mov	r0, r4
c0d058f6:	4629      	mov	r1, r5
c0d058f8:	f000 fa18 	bl	c0d05d2c <USBD_CtlError>
}
c0d058fc:	bdb0      	pop	{r4, r5, r7, pc}

c0d058fe <USBD_StdItfReq>:
{
c0d058fe:	b5b0      	push	{r4, r5, r7, lr}
c0d05900:	460d      	mov	r5, r1
c0d05902:	4604      	mov	r4, r0
c0d05904:	20fc      	movs	r0, #252	; 0xfc
  switch (pdev->dev_state) 
c0d05906:	5c20      	ldrb	r0, [r4, r0]
c0d05908:	2803      	cmp	r0, #3
c0d0590a:	d117      	bne.n	c0d0593c <USBD_StdItfReq+0x3e>
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d0590c:	7928      	ldrb	r0, [r5, #4]
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d0590e:	2802      	cmp	r0, #2
c0d05910:	d814      	bhi.n	c0d0593c <USBD_StdItfReq+0x3e>
c0d05912:	00c0      	lsls	r0, r0, #3
c0d05914:	1820      	adds	r0, r4, r0
c0d05916:	2145      	movs	r1, #69	; 0x45
c0d05918:	0089      	lsls	r1, r1, #2
c0d0591a:	5840      	ldr	r0, [r0, r1]
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d0591c:	2800      	cmp	r0, #0
c0d0591e:	d00d      	beq.n	c0d0593c <USBD_StdItfReq+0x3e>
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d05920:	6880      	ldr	r0, [r0, #8]
c0d05922:	f7fd fd2d 	bl	c0d03380 <pic>
c0d05926:	4602      	mov	r2, r0
c0d05928:	4620      	mov	r0, r4
c0d0592a:	4629      	mov	r1, r5
c0d0592c:	4790      	blx	r2
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d0592e:	88e8      	ldrh	r0, [r5, #6]
c0d05930:	2800      	cmp	r0, #0
c0d05932:	d107      	bne.n	c0d05944 <USBD_StdItfReq+0x46>
         USBD_CtlSendStatus(pdev);
c0d05934:	4620      	mov	r0, r4
c0d05936:	f000 fab4 	bl	c0d05ea2 <USBD_CtlSendStatus>
c0d0593a:	e003      	b.n	c0d05944 <USBD_StdItfReq+0x46>
c0d0593c:	4620      	mov	r0, r4
c0d0593e:	4629      	mov	r1, r5
c0d05940:	f000 f9f4 	bl	c0d05d2c <USBD_CtlError>
c0d05944:	2000      	movs	r0, #0
  return USBD_OK;
c0d05946:	bdb0      	pop	{r4, r5, r7, pc}

c0d05948 <USBD_StdEPReq>:
{
c0d05948:	b5b0      	push	{r4, r5, r7, lr}
c0d0594a:	b082      	sub	sp, #8
c0d0594c:	460d      	mov	r5, r1
c0d0594e:	4604      	mov	r4, r0
  ep_addr  = LOBYTE(req->wIndex);
c0d05950:	7909      	ldrb	r1, [r1, #4]
c0d05952:	207f      	movs	r0, #127	; 0x7f
  if ((ep_addr & 0x7F) > IO_USB_MAX_ENDPOINTS) {
c0d05954:	4008      	ands	r0, r1
c0d05956:	2808      	cmp	r0, #8
c0d05958:	d304      	bcc.n	c0d05964 <USBD_StdEPReq+0x1c>
c0d0595a:	4620      	mov	r0, r4
c0d0595c:	4629      	mov	r1, r5
c0d0595e:	f000 f9e5 	bl	c0d05d2c <USBD_CtlError>
c0d05962:	e073      	b.n	c0d05a4c <USBD_StdEPReq+0x104>
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d05964:	2902      	cmp	r1, #2
c0d05966:	d813      	bhi.n	c0d05990 <USBD_StdEPReq+0x48>
c0d05968:	782a      	ldrb	r2, [r5, #0]
c0d0596a:	2360      	movs	r3, #96	; 0x60
c0d0596c:	4013      	ands	r3, r2
c0d0596e:	2b20      	cmp	r3, #32
c0d05970:	d10e      	bne.n	c0d05990 <USBD_StdEPReq+0x48>
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d05972:	00ca      	lsls	r2, r1, #3
c0d05974:	18a2      	adds	r2, r4, r2
c0d05976:	2345      	movs	r3, #69	; 0x45
c0d05978:	009b      	lsls	r3, r3, #2
c0d0597a:	58d2      	ldr	r2, [r2, r3]
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d0597c:	2a00      	cmp	r2, #0
c0d0597e:	d007      	beq.n	c0d05990 <USBD_StdEPReq+0x48>
    ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d05980:	6890      	ldr	r0, [r2, #8]
c0d05982:	f7fd fcfd 	bl	c0d03380 <pic>
c0d05986:	4602      	mov	r2, r0
c0d05988:	4620      	mov	r0, r4
c0d0598a:	4629      	mov	r1, r5
c0d0598c:	4790      	blx	r2
c0d0598e:	e05d      	b.n	c0d05a4c <USBD_StdEPReq+0x104>
  switch (req->bRequest) 
c0d05990:	786a      	ldrb	r2, [r5, #1]
c0d05992:	2a00      	cmp	r2, #0
c0d05994:	d00a      	beq.n	c0d059ac <USBD_StdEPReq+0x64>
c0d05996:	2a01      	cmp	r2, #1
c0d05998:	d011      	beq.n	c0d059be <USBD_StdEPReq+0x76>
c0d0599a:	2a03      	cmp	r2, #3
c0d0599c:	d156      	bne.n	c0d05a4c <USBD_StdEPReq+0x104>
c0d0599e:	20fc      	movs	r0, #252	; 0xfc
    switch (pdev->dev_state) 
c0d059a0:	5c20      	ldrb	r0, [r4, r0]
c0d059a2:	2803      	cmp	r0, #3
c0d059a4:	d01a      	beq.n	c0d059dc <USBD_StdEPReq+0x94>
c0d059a6:	2802      	cmp	r0, #2
c0d059a8:	d00f      	beq.n	c0d059ca <USBD_StdEPReq+0x82>
c0d059aa:	e7d6      	b.n	c0d0595a <USBD_StdEPReq+0x12>
c0d059ac:	22fc      	movs	r2, #252	; 0xfc
    switch (pdev->dev_state) 
c0d059ae:	5ca2      	ldrb	r2, [r4, r2]
c0d059b0:	2a03      	cmp	r2, #3
c0d059b2:	d02f      	beq.n	c0d05a14 <USBD_StdEPReq+0xcc>
c0d059b4:	2a02      	cmp	r2, #2
c0d059b6:	d1d0      	bne.n	c0d0595a <USBD_StdEPReq+0x12>
      if ((ep_addr & 0x7F) != 0x00) 
c0d059b8:	2800      	cmp	r0, #0
c0d059ba:	d10b      	bne.n	c0d059d4 <USBD_StdEPReq+0x8c>
c0d059bc:	e046      	b.n	c0d05a4c <USBD_StdEPReq+0x104>
c0d059be:	22fc      	movs	r2, #252	; 0xfc
    switch (pdev->dev_state) 
c0d059c0:	5ca2      	ldrb	r2, [r4, r2]
c0d059c2:	2a03      	cmp	r2, #3
c0d059c4:	d032      	beq.n	c0d05a2c <USBD_StdEPReq+0xe4>
c0d059c6:	2a02      	cmp	r2, #2
c0d059c8:	d1c7      	bne.n	c0d0595a <USBD_StdEPReq+0x12>
c0d059ca:	2080      	movs	r0, #128	; 0x80
c0d059cc:	460a      	mov	r2, r1
c0d059ce:	4302      	orrs	r2, r0
c0d059d0:	2a80      	cmp	r2, #128	; 0x80
c0d059d2:	d03b      	beq.n	c0d05a4c <USBD_StdEPReq+0x104>
c0d059d4:	4620      	mov	r0, r4
c0d059d6:	f7ff fba7 	bl	c0d05128 <USBD_LL_StallEP>
c0d059da:	e037      	b.n	c0d05a4c <USBD_StdEPReq+0x104>
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d059dc:	8868      	ldrh	r0, [r5, #2]
c0d059de:	2800      	cmp	r0, #0
c0d059e0:	d107      	bne.n	c0d059f2 <USBD_StdEPReq+0xaa>
c0d059e2:	2080      	movs	r0, #128	; 0x80
c0d059e4:	4308      	orrs	r0, r1
c0d059e6:	2880      	cmp	r0, #128	; 0x80
c0d059e8:	d003      	beq.n	c0d059f2 <USBD_StdEPReq+0xaa>
          USBD_LL_StallEP(pdev , ep_addr);
c0d059ea:	4620      	mov	r0, r4
c0d059ec:	f7ff fb9c 	bl	c0d05128 <USBD_LL_StallEP>
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d059f0:	7929      	ldrb	r1, [r5, #4]
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d059f2:	2902      	cmp	r1, #2
c0d059f4:	d827      	bhi.n	c0d05a46 <USBD_StdEPReq+0xfe>
c0d059f6:	00c8      	lsls	r0, r1, #3
c0d059f8:	1820      	adds	r0, r4, r0
c0d059fa:	2145      	movs	r1, #69	; 0x45
c0d059fc:	0089      	lsls	r1, r1, #2
c0d059fe:	5840      	ldr	r0, [r0, r1]
c0d05a00:	2800      	cmp	r0, #0
c0d05a02:	d020      	beq.n	c0d05a46 <USBD_StdEPReq+0xfe>
c0d05a04:	6880      	ldr	r0, [r0, #8]
c0d05a06:	f7fd fcbb 	bl	c0d03380 <pic>
c0d05a0a:	4602      	mov	r2, r0
c0d05a0c:	4620      	mov	r0, r4
c0d05a0e:	4629      	mov	r1, r5
c0d05a10:	4790      	blx	r2
c0d05a12:	e018      	b.n	c0d05a46 <USBD_StdEPReq+0xfe>
        unsigned short status = USBD_LL_IsStallEP(pdev, ep_addr)? 1 : 0;        
c0d05a14:	4620      	mov	r0, r4
c0d05a16:	f7ff fbcf 	bl	c0d051b8 <USBD_LL_IsStallEP>
c0d05a1a:	1e41      	subs	r1, r0, #1
c0d05a1c:	4188      	sbcs	r0, r1
c0d05a1e:	a901      	add	r1, sp, #4
c0d05a20:	8008      	strh	r0, [r1, #0]
c0d05a22:	2202      	movs	r2, #2
        USBD_CtlSendData (pdev,
c0d05a24:	4620      	mov	r0, r4
c0d05a26:	f000 fa11 	bl	c0d05e4c <USBD_CtlSendData>
c0d05a2a:	e00f      	b.n	c0d05a4c <USBD_StdEPReq+0x104>
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d05a2c:	886a      	ldrh	r2, [r5, #2]
c0d05a2e:	2a00      	cmp	r2, #0
c0d05a30:	d10c      	bne.n	c0d05a4c <USBD_StdEPReq+0x104>
        if ((ep_addr & 0x7F) != 0x00) 
c0d05a32:	2800      	cmp	r0, #0
c0d05a34:	d007      	beq.n	c0d05a46 <USBD_StdEPReq+0xfe>
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d05a36:	4620      	mov	r0, r4
c0d05a38:	f7ff fb9a 	bl	c0d05170 <USBD_LL_ClearStallEP>
          if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d05a3c:	7928      	ldrb	r0, [r5, #4]
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d05a3e:	2802      	cmp	r0, #2
c0d05a40:	d801      	bhi.n	c0d05a46 <USBD_StdEPReq+0xfe>
c0d05a42:	00c0      	lsls	r0, r0, #3
c0d05a44:	e7d8      	b.n	c0d059f8 <USBD_StdEPReq+0xb0>
c0d05a46:	4620      	mov	r0, r4
c0d05a48:	f000 fa2b 	bl	c0d05ea2 <USBD_CtlSendStatus>
c0d05a4c:	2000      	movs	r0, #0
}
c0d05a4e:	b002      	add	sp, #8
c0d05a50:	bdb0      	pop	{r4, r5, r7, pc}

c0d05a52 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d05a52:	780a      	ldrb	r2, [r1, #0]
c0d05a54:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d05a56:	784a      	ldrb	r2, [r1, #1]
c0d05a58:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d05a5a:	788a      	ldrb	r2, [r1, #2]
c0d05a5c:	78cb      	ldrb	r3, [r1, #3]
c0d05a5e:	021b      	lsls	r3, r3, #8
c0d05a60:	189a      	adds	r2, r3, r2
c0d05a62:	8042      	strh	r2, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d05a64:	790a      	ldrb	r2, [r1, #4]
c0d05a66:	794b      	ldrb	r3, [r1, #5]
c0d05a68:	021b      	lsls	r3, r3, #8
c0d05a6a:	189a      	adds	r2, r3, r2
c0d05a6c:	8082      	strh	r2, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d05a6e:	798a      	ldrb	r2, [r1, #6]
c0d05a70:	79c9      	ldrb	r1, [r1, #7]
c0d05a72:	0209      	lsls	r1, r1, #8
c0d05a74:	1889      	adds	r1, r1, r2
c0d05a76:	80c1      	strh	r1, [r0, #6]

}
c0d05a78:	4770      	bx	lr

c0d05a7a <USBD_CtlStall>:
* @param  pdev: device instance
* @param  req: usb request
* @retval None
*/
void USBD_CtlStall( USBD_HandleTypeDef *pdev)
{
c0d05a7a:	b510      	push	{r4, lr}
c0d05a7c:	4604      	mov	r4, r0
c0d05a7e:	2180      	movs	r1, #128	; 0x80
  USBD_LL_StallEP(pdev , 0x80);
c0d05a80:	f7ff fb52 	bl	c0d05128 <USBD_LL_StallEP>
c0d05a84:	2100      	movs	r1, #0
  USBD_LL_StallEP(pdev , 0);
c0d05a86:	4620      	mov	r0, r4
c0d05a88:	f7ff fb4e 	bl	c0d05128 <USBD_LL_StallEP>
}
c0d05a8c:	bd10      	pop	{r4, pc}

c0d05a8e <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d05a8e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05a90:	b083      	sub	sp, #12
c0d05a92:	460e      	mov	r6, r1
c0d05a94:	4605      	mov	r5, r0
c0d05a96:	a802      	add	r0, sp, #8
c0d05a98:	2400      	movs	r4, #0
  uint16_t len = 0;
c0d05a9a:	8004      	strh	r4, [r0, #0]
c0d05a9c:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d05a9e:	7004      	strb	r4, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d05aa0:	7809      	ldrb	r1, [r1, #0]
c0d05aa2:	2060      	movs	r0, #96	; 0x60
c0d05aa4:	4008      	ands	r0, r1
c0d05aa6:	d010      	beq.n	c0d05aca <USBD_HID_Setup+0x3c>
c0d05aa8:	2820      	cmp	r0, #32
c0d05aaa:	d137      	bne.n	c0d05b1c <USBD_HID_Setup+0x8e>
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d05aac:	7870      	ldrb	r0, [r6, #1]
c0d05aae:	4601      	mov	r1, r0
c0d05ab0:	390a      	subs	r1, #10
c0d05ab2:	2902      	cmp	r1, #2
c0d05ab4:	d332      	bcc.n	c0d05b1c <USBD_HID_Setup+0x8e>
c0d05ab6:	2802      	cmp	r0, #2
c0d05ab8:	d01b      	beq.n	c0d05af2 <USBD_HID_Setup+0x64>
c0d05aba:	2803      	cmp	r0, #3
c0d05abc:	d019      	beq.n	c0d05af2 <USBD_HID_Setup+0x64>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d05abe:	4628      	mov	r0, r5
c0d05ac0:	4631      	mov	r1, r6
c0d05ac2:	f000 f933 	bl	c0d05d2c <USBD_CtlError>
c0d05ac6:	2402      	movs	r4, #2
c0d05ac8:	e028      	b.n	c0d05b1c <USBD_HID_Setup+0x8e>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d05aca:	7870      	ldrb	r0, [r6, #1]
c0d05acc:	280b      	cmp	r0, #11
c0d05ace:	d013      	beq.n	c0d05af8 <USBD_HID_Setup+0x6a>
c0d05ad0:	280a      	cmp	r0, #10
c0d05ad2:	d00e      	beq.n	c0d05af2 <USBD_HID_Setup+0x64>
c0d05ad4:	2806      	cmp	r0, #6
c0d05ad6:	d121      	bne.n	c0d05b1c <USBD_HID_Setup+0x8e>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d05ad8:	78f0      	ldrb	r0, [r6, #3]
c0d05ada:	2400      	movs	r4, #0
c0d05adc:	2821      	cmp	r0, #33	; 0x21
c0d05ade:	d00f      	beq.n	c0d05b00 <USBD_HID_Setup+0x72>
c0d05ae0:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d05ae2:	4622      	mov	r2, r4
c0d05ae4:	4621      	mov	r1, r4
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d05ae6:	d116      	bne.n	c0d05b16 <USBD_HID_Setup+0x88>
c0d05ae8:	af02      	add	r7, sp, #8
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d05aea:	4638      	mov	r0, r7
c0d05aec:	f000 f84a 	bl	c0d05b84 <USBD_HID_GetReportDescriptor_impl>
c0d05af0:	e00a      	b.n	c0d05b08 <USBD_HID_Setup+0x7a>
c0d05af2:	a901      	add	r1, sp, #4
c0d05af4:	2201      	movs	r2, #1
c0d05af6:	e00e      	b.n	c0d05b16 <USBD_HID_Setup+0x88>
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d05af8:	4628      	mov	r0, r5
c0d05afa:	f000 f9d2 	bl	c0d05ea2 <USBD_CtlSendStatus>
c0d05afe:	e00d      	b.n	c0d05b1c <USBD_HID_Setup+0x8e>
c0d05b00:	af02      	add	r7, sp, #8
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d05b02:	4638      	mov	r0, r7
c0d05b04:	f000 f828 	bl	c0d05b58 <USBD_HID_GetHidDescriptor_impl>
c0d05b08:	4601      	mov	r1, r0
c0d05b0a:	883a      	ldrh	r2, [r7, #0]
c0d05b0c:	88f0      	ldrh	r0, [r6, #6]
c0d05b0e:	4282      	cmp	r2, r0
c0d05b10:	d300      	bcc.n	c0d05b14 <USBD_HID_Setup+0x86>
c0d05b12:	4602      	mov	r2, r0
c0d05b14:	803a      	strh	r2, [r7, #0]
c0d05b16:	4628      	mov	r0, r5
c0d05b18:	f000 f998 	bl	c0d05e4c <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d05b1c:	4620      	mov	r0, r4
c0d05b1e:	b003      	add	sp, #12
c0d05b20:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d05b22 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d05b22:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05b24:	b081      	sub	sp, #4
c0d05b26:	4604      	mov	r4, r0
c0d05b28:	2182      	movs	r1, #130	; 0x82
c0d05b2a:	2603      	movs	r6, #3
c0d05b2c:	2540      	movs	r5, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d05b2e:	4632      	mov	r2, r6
c0d05b30:	462b      	mov	r3, r5
c0d05b32:	f7ff fac9 	bl	c0d050c8 <USBD_LL_OpenEP>
c0d05b36:	2702      	movs	r7, #2
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d05b38:	4620      	mov	r0, r4
c0d05b3a:	4639      	mov	r1, r7
c0d05b3c:	4632      	mov	r2, r6
c0d05b3e:	462b      	mov	r3, r5
c0d05b40:	f7ff fac2 	bl	c0d050c8 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d05b44:	4620      	mov	r0, r4
c0d05b46:	4639      	mov	r1, r7
c0d05b48:	462a      	mov	r2, r5
c0d05b4a:	f7ff fb70 	bl	c0d0522e <USBD_LL_PrepareReceive>
c0d05b4e:	2000      	movs	r0, #0
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d05b50:	b001      	add	sp, #4
c0d05b52:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d05b54 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d05b54:	2000      	movs	r0, #0
  
  // /* Close HID EP OUT */
  // USBD_LL_CloseEP(pdev,
  //                 HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d05b56:	4770      	bx	lr

c0d05b58 <USBD_HID_GetHidDescriptor_impl>:
{
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
c0d05b58:	4601      	mov	r1, r0
c0d05b5a:	2043      	movs	r0, #67	; 0x43
c0d05b5c:	0080      	lsls	r0, r0, #2
  switch (USBD_Device.request.wIndex&0xFF) {
c0d05b5e:	4a07      	ldr	r2, [pc, #28]	; (c0d05b7c <USBD_HID_GetHidDescriptor_impl+0x24>)
c0d05b60:	5c12      	ldrb	r2, [r2, r0]
c0d05b62:	2000      	movs	r0, #0
c0d05b64:	2a00      	cmp	r2, #0
c0d05b66:	d001      	beq.n	c0d05b6c <USBD_HID_GetHidDescriptor_impl+0x14>
c0d05b68:	4603      	mov	r3, r0
c0d05b6a:	e000      	b.n	c0d05b6e <USBD_HID_GetHidDescriptor_impl+0x16>
c0d05b6c:	2309      	movs	r3, #9
c0d05b6e:	800b      	strh	r3, [r1, #0]
c0d05b70:	2a00      	cmp	r2, #0
c0d05b72:	d101      	bne.n	c0d05b78 <USBD_HID_GetHidDescriptor_impl+0x20>
c0d05b74:	4802      	ldr	r0, [pc, #8]	; (c0d05b80 <USBD_HID_GetHidDescriptor_impl+0x28>)
c0d05b76:	4478      	add	r0, pc
      return (uint8_t*)USBD_HID_Desc_kbd; 
#endif // HAVE_USB_HIDKBD
  }
  *len = 0;
  return 0;
}
c0d05b78:	4770      	bx	lr
c0d05b7a:	46c0      	nop			; (mov r8, r8)
c0d05b7c:	2000044c 	.word	0x2000044c
c0d05b80:	0000220a 	.word	0x0000220a

c0d05b84 <USBD_HID_GetReportDescriptor_impl>:

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
c0d05b84:	4601      	mov	r1, r0
c0d05b86:	2043      	movs	r0, #67	; 0x43
c0d05b88:	0080      	lsls	r0, r0, #2
  switch (USBD_Device.request.wIndex&0xFF) {
c0d05b8a:	4a07      	ldr	r2, [pc, #28]	; (c0d05ba8 <USBD_HID_GetReportDescriptor_impl+0x24>)
c0d05b8c:	5c12      	ldrb	r2, [r2, r0]
c0d05b8e:	2000      	movs	r0, #0
c0d05b90:	2a00      	cmp	r2, #0
c0d05b92:	d001      	beq.n	c0d05b98 <USBD_HID_GetReportDescriptor_impl+0x14>
c0d05b94:	4603      	mov	r3, r0
c0d05b96:	e000      	b.n	c0d05b9a <USBD_HID_GetReportDescriptor_impl+0x16>
c0d05b98:	2322      	movs	r3, #34	; 0x22
c0d05b9a:	800b      	strh	r3, [r1, #0]
c0d05b9c:	2a00      	cmp	r2, #0
c0d05b9e:	d101      	bne.n	c0d05ba4 <USBD_HID_GetReportDescriptor_impl+0x20>
c0d05ba0:	4802      	ldr	r0, [pc, #8]	; (c0d05bac <USBD_HID_GetReportDescriptor_impl+0x28>)
c0d05ba2:	4478      	add	r0, pc
    return (uint8_t*)HID_ReportDesc_kbd;
#endif // HAVE_USB_HIDKBD
  }
  *len = 0;
  return 0;
}
c0d05ba4:	4770      	bx	lr
c0d05ba6:	46c0      	nop			; (mov r8, r8)
c0d05ba8:	2000044c 	.word	0x2000044c
c0d05bac:	000021e7 	.word	0x000021e7

c0d05bb0 <USBD_HID_DataIn_impl>:
}
#endif // HAVE_IO_U2F

uint8_t  USBD_HID_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d05bb0:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d05bb2:	2902      	cmp	r1, #2
c0d05bb4:	d103      	bne.n	c0d05bbe <USBD_HID_DataIn_impl+0xe>
    // HID gen endpoint
    case (HID_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data);
c0d05bb6:	4803      	ldr	r0, [pc, #12]	; (c0d05bc4 <USBD_HID_DataIn_impl+0x14>)
c0d05bb8:	4478      	add	r0, pc
c0d05bba:	f7fc fa61 	bl	c0d02080 <io_usb_hid_sent>
c0d05bbe:	2000      	movs	r0, #0
      break;
  }

  return USBD_OK;
c0d05bc0:	bd80      	pop	{r7, pc}
c0d05bc2:	46c0      	nop			; (mov r8, r8)
c0d05bc4:	ffffbd4d 	.word	0xffffbd4d

c0d05bc8 <USBD_HID_DataOut_impl>:
}

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d05bc8:	b5b0      	push	{r4, r5, r7, lr}
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d05bca:	2902      	cmp	r1, #2
c0d05bcc:	d11a      	bne.n	c0d05c04 <USBD_HID_DataOut_impl+0x3c>
c0d05bce:	4614      	mov	r4, r2
c0d05bd0:	2102      	movs	r1, #2
c0d05bd2:	2240      	movs	r2, #64	; 0x40

  // HID gen endpoint
  case (HID_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d05bd4:	f7ff fb2b 	bl	c0d0522e <USBD_LL_PrepareReceive>

#ifndef HAVE_USB_HIDKBD
    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d05bd8:	4d0b      	ldr	r5, [pc, #44]	; (c0d05c08 <USBD_HID_DataOut_impl+0x40>)
c0d05bda:	79a8      	ldrb	r0, [r5, #6]
c0d05bdc:	2800      	cmp	r0, #0
c0d05bde:	d111      	bne.n	c0d05c04 <USBD_HID_DataOut_impl+0x3c>
c0d05be0:	2002      	movs	r0, #2
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d05be2:	f7fb fe2d 	bl	c0d01840 <io_seproxyhal_get_ep_rx_size>
c0d05be6:	4602      	mov	r2, r0
c0d05be8:	4809      	ldr	r0, [pc, #36]	; (c0d05c10 <USBD_HID_DataOut_impl+0x48>)
c0d05bea:	4478      	add	r0, pc
c0d05bec:	4621      	mov	r1, r4
c0d05bee:	f7fc f991 	bl	c0d01f14 <io_usb_hid_receive>
c0d05bf2:	2802      	cmp	r0, #2
c0d05bf4:	d106      	bne.n	c0d05c04 <USBD_HID_DataOut_impl+0x3c>
c0d05bf6:	2007      	movs	r0, #7
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
          G_io_app.apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d05bf8:	7028      	strb	r0, [r5, #0]
c0d05bfa:	2001      	movs	r0, #1
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d05bfc:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d05bfe:	4803      	ldr	r0, [pc, #12]	; (c0d05c0c <USBD_HID_DataOut_impl+0x44>)
c0d05c00:	6800      	ldr	r0, [r0, #0]
c0d05c02:	8068      	strh	r0, [r5, #2]
c0d05c04:	2000      	movs	r0, #0
    }
#endif // HAVE_USB_HIDKBD
    break;
  }

  return USBD_OK;
c0d05c06:	bdb0      	pop	{r4, r5, r7, pc}
c0d05c08:	200003b4 	.word	0x200003b4
c0d05c0c:	20000424 	.word	0x20000424
c0d05c10:	ffffbd1b 	.word	0xffffbd1b

c0d05c14 <USBD_WEBUSB_Init>:

#ifdef HAVE_WEBUSB

uint8_t  USBD_WEBUSB_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d05c14:	b570      	push	{r4, r5, r6, lr}
c0d05c16:	4604      	mov	r4, r0
c0d05c18:	2183      	movs	r1, #131	; 0x83
c0d05c1a:	2503      	movs	r5, #3
c0d05c1c:	2640      	movs	r6, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d05c1e:	462a      	mov	r2, r5
c0d05c20:	4633      	mov	r3, r6
c0d05c22:	f7ff fa51 	bl	c0d050c8 <USBD_LL_OpenEP>
                 WEBUSB_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d05c26:	4620      	mov	r0, r4
c0d05c28:	4629      	mov	r1, r5
c0d05c2a:	462a      	mov	r2, r5
c0d05c2c:	4633      	mov	r3, r6
c0d05c2e:	f7ff fa4b 	bl	c0d050c8 <USBD_LL_OpenEP>
                 WEBUSB_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d05c32:	4620      	mov	r0, r4
c0d05c34:	4629      	mov	r1, r5
c0d05c36:	4632      	mov	r2, r6
c0d05c38:	f7ff faf9 	bl	c0d0522e <USBD_LL_PrepareReceive>
c0d05c3c:	2000      	movs	r0, #0

  return USBD_OK;
c0d05c3e:	bd70      	pop	{r4, r5, r6, pc}

c0d05c40 <USBD_WEBUSB_DeInit>:
}

uint8_t  USBD_WEBUSB_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx) {
c0d05c40:	2000      	movs	r0, #0
  UNUSED(pdev);
  UNUSED(cfgidx);
  return USBD_OK;
c0d05c42:	4770      	bx	lr

c0d05c44 <USBD_WEBUSB_Setup>:
}

uint8_t  USBD_WEBUSB_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d05c44:	2000      	movs	r0, #0
  UNUSED(pdev);
  UNUSED(req);
  return USBD_OK;
c0d05c46:	4770      	bx	lr

c0d05c48 <USBD_WEBUSB_DataIn>:
}

uint8_t  USBD_WEBUSB_DataIn (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d05c48:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d05c4a:	2903      	cmp	r1, #3
c0d05c4c:	d103      	bne.n	c0d05c56 <USBD_WEBUSB_DataIn+0xe>
    // HID gen endpoint
    case (WEBUSB_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data_ep0x83);
c0d05c4e:	4803      	ldr	r0, [pc, #12]	; (c0d05c5c <USBD_WEBUSB_DataIn+0x14>)
c0d05c50:	4478      	add	r0, pc
c0d05c52:	f7fc fa15 	bl	c0d02080 <io_usb_hid_sent>
c0d05c56:	2000      	movs	r0, #0
      break;
  }
  return USBD_OK;
c0d05c58:	bd80      	pop	{r7, pc}
c0d05c5a:	46c0      	nop			; (mov r8, r8)
c0d05c5c:	ffffbcc5 	.word	0xffffbcc5

c0d05c60 <USBD_WEBUSB_DataOut>:
}

uint8_t USBD_WEBUSB_DataOut (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d05c60:	b5b0      	push	{r4, r5, r7, lr}
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d05c62:	2903      	cmp	r1, #3
c0d05c64:	d11a      	bne.n	c0d05c9c <USBD_WEBUSB_DataOut+0x3c>
c0d05c66:	4614      	mov	r4, r2
c0d05c68:	2103      	movs	r1, #3
c0d05c6a:	2240      	movs	r2, #64	; 0x40

  // HID gen endpoint
  case (WEBUSB_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d05c6c:	f7ff fadf 	bl	c0d0522e <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d05c70:	4d0b      	ldr	r5, [pc, #44]	; (c0d05ca0 <USBD_WEBUSB_DataOut+0x40>)
c0d05c72:	79a8      	ldrb	r0, [r5, #6]
c0d05c74:	2800      	cmp	r0, #0
c0d05c76:	d111      	bne.n	c0d05c9c <USBD_WEBUSB_DataOut+0x3c>
c0d05c78:	2003      	movs	r0, #3
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data_ep0x83, buffer, io_seproxyhal_get_ep_rx_size(WEBUSB_EPOUT_ADDR))) {
c0d05c7a:	f7fb fde1 	bl	c0d01840 <io_seproxyhal_get_ep_rx_size>
c0d05c7e:	4602      	mov	r2, r0
c0d05c80:	4809      	ldr	r0, [pc, #36]	; (c0d05ca8 <USBD_WEBUSB_DataOut+0x48>)
c0d05c82:	4478      	add	r0, pc
c0d05c84:	4621      	mov	r1, r4
c0d05c86:	f7fc f945 	bl	c0d01f14 <io_usb_hid_receive>
c0d05c8a:	2802      	cmp	r0, #2
c0d05c8c:	d106      	bne.n	c0d05c9c <USBD_WEBUSB_DataOut+0x3c>
c0d05c8e:	200b      	movs	r0, #11
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
          G_io_app.apdu_state = APDU_USB_WEBUSB; // for next call to io_exchange
c0d05c90:	7028      	strb	r0, [r5, #0]
c0d05c92:	2005      	movs	r0, #5
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
c0d05c94:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d05c96:	4803      	ldr	r0, [pc, #12]	; (c0d05ca4 <USBD_WEBUSB_DataOut+0x44>)
c0d05c98:	6800      	ldr	r0, [r0, #0]
c0d05c9a:	8068      	strh	r0, [r5, #2]
c0d05c9c:	2000      	movs	r0, #0
      }
    }
    break;
  }

  return USBD_OK;
c0d05c9e:	bdb0      	pop	{r4, r5, r7, pc}
c0d05ca0:	200003b4 	.word	0x200003b4
c0d05ca4:	20000424 	.word	0x20000424
c0d05ca8:	ffffbc93 	.word	0xffffbc93

c0d05cac <USBD_DeviceDescriptor>:
{
c0d05cac:	2012      	movs	r0, #18
  *length = sizeof(USBD_DeviceDesc);
c0d05cae:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d05cb0:	4801      	ldr	r0, [pc, #4]	; (c0d05cb8 <USBD_DeviceDescriptor+0xc>)
c0d05cb2:	4478      	add	r0, pc
c0d05cb4:	4770      	bx	lr
c0d05cb6:	46c0      	nop			; (mov r8, r8)
c0d05cb8:	0000231a 	.word	0x0000231a

c0d05cbc <USBD_LangIDStrDescriptor>:
{
c0d05cbc:	2004      	movs	r0, #4
  *length = sizeof(USBD_LangIDDesc);  
c0d05cbe:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d05cc0:	4801      	ldr	r0, [pc, #4]	; (c0d05cc8 <USBD_LangIDStrDescriptor+0xc>)
c0d05cc2:	4478      	add	r0, pc
c0d05cc4:	4770      	bx	lr
c0d05cc6:	46c0      	nop			; (mov r8, r8)
c0d05cc8:	0000231c 	.word	0x0000231c

c0d05ccc <USBD_ManufacturerStrDescriptor>:
{
c0d05ccc:	200e      	movs	r0, #14
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d05cce:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d05cd0:	4801      	ldr	r0, [pc, #4]	; (c0d05cd8 <USBD_ManufacturerStrDescriptor+0xc>)
c0d05cd2:	4478      	add	r0, pc
c0d05cd4:	4770      	bx	lr
c0d05cd6:	46c0      	nop			; (mov r8, r8)
c0d05cd8:	00002310 	.word	0x00002310

c0d05cdc <USBD_ProductStrDescriptor>:
{
c0d05cdc:	200e      	movs	r0, #14
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d05cde:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d05ce0:	4801      	ldr	r0, [pc, #4]	; (c0d05ce8 <USBD_ProductStrDescriptor+0xc>)
c0d05ce2:	4478      	add	r0, pc
c0d05ce4:	4770      	bx	lr
c0d05ce6:	46c0      	nop			; (mov r8, r8)
c0d05ce8:	0000230e 	.word	0x0000230e

c0d05cec <USBD_SerialStrDescriptor>:
{
c0d05cec:	200a      	movs	r0, #10
  *length = sizeof(USB_SERIAL_STRING);
c0d05cee:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d05cf0:	4801      	ldr	r0, [pc, #4]	; (c0d05cf8 <USBD_SerialStrDescriptor+0xc>)
c0d05cf2:	4478      	add	r0, pc
c0d05cf4:	4770      	bx	lr
c0d05cf6:	46c0      	nop			; (mov r8, r8)
c0d05cf8:	0000230c 	.word	0x0000230c

c0d05cfc <USBD_ConfigStrDescriptor>:
{
c0d05cfc:	200e      	movs	r0, #14
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d05cfe:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d05d00:	4801      	ldr	r0, [pc, #4]	; (c0d05d08 <USBD_ConfigStrDescriptor+0xc>)
c0d05d02:	4478      	add	r0, pc
c0d05d04:	4770      	bx	lr
c0d05d06:	46c0      	nop			; (mov r8, r8)
c0d05d08:	000022ee 	.word	0x000022ee

c0d05d0c <USBD_InterfaceStrDescriptor>:
{
c0d05d0c:	200e      	movs	r0, #14
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d05d0e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d05d10:	4801      	ldr	r0, [pc, #4]	; (c0d05d18 <USBD_InterfaceStrDescriptor+0xc>)
c0d05d12:	4478      	add	r0, pc
c0d05d14:	4770      	bx	lr
c0d05d16:	46c0      	nop			; (mov r8, r8)
c0d05d18:	000022de 	.word	0x000022de

c0d05d1c <USBD_BOSDescriptor>:
};

#endif // HAVE_WEBUSB

static uint8_t *USBD_BOSDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d05d1c:	2039      	movs	r0, #57	; 0x39
  UNUSED(speed);
#ifdef HAVE_WEBUSB
  *length = sizeof(C_usb_bos);
c0d05d1e:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)C_usb_bos;
c0d05d20:	4801      	ldr	r0, [pc, #4]	; (c0d05d28 <USBD_BOSDescriptor+0xc>)
c0d05d22:	4478      	add	r0, pc
c0d05d24:	4770      	bx	lr
c0d05d26:	46c0      	nop			; (mov r8, r8)
c0d05d28:	00002089 	.word	0x00002089

c0d05d2c <USBD_CtlError>:
  '4', 0x00, '6', 0x00, '7', 0x00, '6', 0x00, '5', 0x00, '7', 0x00,
  '2', 0x00, '}', 0x00, 0x00, 0x00, 0x00, 0x00 // propertyData, double unicode nul terminated
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
c0d05d2c:	b580      	push	{r7, lr}
    USBD_CtlSendData (pdev, (unsigned char*)C_webusb_url_descriptor, MIN(req->wLength, sizeof(C_webusb_url_descriptor)));
  }
  else 
#endif // WEBUSB_URL_SIZE_B
    // SETUP (LE): 0x80 0x06 0x03 0x77 0x00 0x00 0xXX 0xXX
    if ((req->bmRequest & 0x80) 
c0d05d2e:	780a      	ldrb	r2, [r1, #0]
c0d05d30:	b252      	sxtb	r2, r2
    && req->bRequest == USB_REQ_GET_DESCRIPTOR 
c0d05d32:	2a00      	cmp	r2, #0
c0d05d34:	d402      	bmi.n	c0d05d3c <USBD_CtlError+0x10>
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
c0d05d36:	f7ff fea0 	bl	c0d05a7a <USBD_CtlStall>
  }
}
c0d05d3a:	bd80      	pop	{r7, pc}
    && req->bRequest == USB_REQ_GET_DESCRIPTOR 
c0d05d3c:	784a      	ldrb	r2, [r1, #1]
    && (req->wValue>>8) == USB_DESC_TYPE_STRING 
c0d05d3e:	2a77      	cmp	r2, #119	; 0x77
c0d05d40:	d00c      	beq.n	c0d05d5c <USBD_CtlError+0x30>
c0d05d42:	2a06      	cmp	r2, #6
c0d05d44:	d1f7      	bne.n	c0d05d36 <USBD_CtlError+0xa>
c0d05d46:	884a      	ldrh	r2, [r1, #2]
c0d05d48:	4b14      	ldr	r3, [pc, #80]	; (c0d05d9c <USBD_CtlError+0x70>)
    && (req->wValue & 0xFF) == 0xEE) {
c0d05d4a:	429a      	cmp	r2, r3
c0d05d4c:	d1f3      	bne.n	c0d05d36 <USBD_CtlError+0xa>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
c0d05d4e:	88ca      	ldrh	r2, [r1, #6]
c0d05d50:	2a12      	cmp	r2, #18
c0d05d52:	d300      	bcc.n	c0d05d56 <USBD_CtlError+0x2a>
c0d05d54:	2212      	movs	r2, #18
c0d05d56:	4912      	ldr	r1, [pc, #72]	; (c0d05da0 <USBD_CtlError+0x74>)
c0d05d58:	4479      	add	r1, pc
c0d05d5a:	e01c      	b.n	c0d05d96 <USBD_CtlError+0x6a>
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
c0d05d5c:	888a      	ldrh	r2, [r1, #4]
  else if ((req->bmRequest & 0x80) 
c0d05d5e:	2a04      	cmp	r2, #4
c0d05d60:	d106      	bne.n	c0d05d70 <USBD_CtlError+0x44>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
c0d05d62:	88ca      	ldrh	r2, [r1, #6]
c0d05d64:	2a28      	cmp	r2, #40	; 0x28
c0d05d66:	d300      	bcc.n	c0d05d6a <USBD_CtlError+0x3e>
c0d05d68:	2228      	movs	r2, #40	; 0x28
c0d05d6a:	490e      	ldr	r1, [pc, #56]	; (c0d05da4 <USBD_CtlError+0x78>)
c0d05d6c:	4479      	add	r1, pc
c0d05d6e:	e012      	b.n	c0d05d96 <USBD_CtlError+0x6a>
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
c0d05d70:	888a      	ldrh	r2, [r1, #4]
  else if ((req->bmRequest & 0x80) 
c0d05d72:	2a05      	cmp	r2, #5
c0d05d74:	d106      	bne.n	c0d05d84 <USBD_CtlError+0x58>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
c0d05d76:	88ca      	ldrh	r2, [r1, #6]
c0d05d78:	2a92      	cmp	r2, #146	; 0x92
c0d05d7a:	d300      	bcc.n	c0d05d7e <USBD_CtlError+0x52>
c0d05d7c:	2292      	movs	r2, #146	; 0x92
c0d05d7e:	490a      	ldr	r1, [pc, #40]	; (c0d05da8 <USBD_CtlError+0x7c>)
c0d05d80:	4479      	add	r1, pc
c0d05d82:	e008      	b.n	c0d05d96 <USBD_CtlError+0x6a>
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
c0d05d84:	888a      	ldrh	r2, [r1, #4]
  else if ((req->bmRequest & 0x80)
c0d05d86:	2a07      	cmp	r2, #7
c0d05d88:	d1d5      	bne.n	c0d05d36 <USBD_CtlError+0xa>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
c0d05d8a:	88ca      	ldrh	r2, [r1, #6]
c0d05d8c:	2ab2      	cmp	r2, #178	; 0xb2
c0d05d8e:	d300      	bcc.n	c0d05d92 <USBD_CtlError+0x66>
c0d05d90:	22b2      	movs	r2, #178	; 0xb2
c0d05d92:	4906      	ldr	r1, [pc, #24]	; (c0d05dac <USBD_CtlError+0x80>)
c0d05d94:	4479      	add	r1, pc
c0d05d96:	f000 f859 	bl	c0d05e4c <USBD_CtlSendData>
}
c0d05d9a:	bd80      	pop	{r7, pc}
c0d05d9c:	000003ee 	.word	0x000003ee
c0d05da0:	000020ac 	.word	0x000020ac
c0d05da4:	0000229c 	.word	0x0000229c
c0d05da8:	00002096 	.word	0x00002096
c0d05dac:	00002114 	.word	0x00002114

c0d05db0 <USB_power>:
  // nothing to do ?
  return 0;
}
#endif // HAVE_USB_CLASS_CCID

void USB_power(unsigned char enabled) {
c0d05db0:	b5b0      	push	{r4, r5, r7, lr}
c0d05db2:	4604      	mov	r4, r0
c0d05db4:	204d      	movs	r0, #77	; 0x4d
c0d05db6:	0085      	lsls	r5, r0, #2
  memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d05db8:	4817      	ldr	r0, [pc, #92]	; (c0d05e18 <USB_power+0x68>)
c0d05dba:	4629      	mov	r1, r5
c0d05dbc:	f001 faa4 	bl	c0d07308 <__aeabi_memclr>

  // init timeouts and other global fields
  memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
c0d05dc0:	4816      	ldr	r0, [pc, #88]	; (c0d05e1c <USB_power+0x6c>)
c0d05dc2:	2100      	movs	r1, #0
c0d05dc4:	7481      	strb	r1, [r0, #18]
c0d05dc6:	8201      	strh	r1, [r0, #16]
c0d05dc8:	60c1      	str	r1, [r0, #12]
  memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d05dca:	6141      	str	r1, [r0, #20]
c0d05dcc:	6181      	str	r1, [r0, #24]
c0d05dce:	61c1      	str	r1, [r0, #28]
c0d05dd0:	8401      	strh	r1, [r0, #32]

  if (enabled) {
c0d05dd2:	2c00      	cmp	r4, #0
c0d05dd4:	d01b      	beq.n	c0d05e0e <USB_power+0x5e>
    memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d05dd6:	4c10      	ldr	r4, [pc, #64]	; (c0d05e18 <USB_power+0x68>)
c0d05dd8:	4620      	mov	r0, r4
c0d05dda:	4629      	mov	r1, r5
c0d05ddc:	f001 fa94 	bl	c0d07308 <__aeabi_memclr>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d05de0:	490f      	ldr	r1, [pc, #60]	; (c0d05e20 <USB_power+0x70>)
c0d05de2:	4479      	add	r1, pc
c0d05de4:	2500      	movs	r5, #0
c0d05de6:	4620      	mov	r0, r4
c0d05de8:	462a      	mov	r2, r5
c0d05dea:	f7ff fa33 	bl	c0d05254 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClassForInterface(HID_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d05dee:	4a0d      	ldr	r2, [pc, #52]	; (c0d05e24 <USB_power+0x74>)
c0d05df0:	447a      	add	r2, pc
c0d05df2:	4628      	mov	r0, r5
c0d05df4:	4621      	mov	r1, r4
c0d05df6:	f7ff fa68 	bl	c0d052ca <USBD_RegisterClassForInterface>
c0d05dfa:	2001      	movs	r0, #1
#ifdef HAVE_USB_CLASS_CCID
    USBD_RegisterClassForInterface(CCID_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_CCID);
#endif // HAVE_USB_CLASS_CCID

#ifdef HAVE_WEBUSB
    USBD_RegisterClassForInterface(WEBUSB_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_WEBUSB);
c0d05dfc:	4a0a      	ldr	r2, [pc, #40]	; (c0d05e28 <USB_power+0x78>)
c0d05dfe:	447a      	add	r2, pc
c0d05e00:	4621      	mov	r1, r4
c0d05e02:	f7ff fa62 	bl	c0d052ca <USBD_RegisterClassForInterface>
#endif // HAVE_WEBUSB

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d05e06:	4620      	mov	r0, r4
c0d05e08:	f7ff fa6d 	bl	c0d052e6 <USBD_Start>
  }
  else {
    USBD_DeInit(&USBD_Device);
  }
}
c0d05e0c:	bdb0      	pop	{r4, r5, r7, pc}
    USBD_DeInit(&USBD_Device);
c0d05e0e:	4802      	ldr	r0, [pc, #8]	; (c0d05e18 <USB_power+0x68>)
c0d05e10:	f7ff fa3c 	bl	c0d0528c <USBD_DeInit>
}
c0d05e14:	bdb0      	pop	{r4, r5, r7, pc}
c0d05e16:	46c0      	nop			; (mov r8, r8)
c0d05e18:	2000044c 	.word	0x2000044c
c0d05e1c:	200003b4 	.word	0x200003b4
c0d05e20:	00002002 	.word	0x00002002
c0d05e24:	0000216c 	.word	0x0000216c
c0d05e28:	00002196 	.word	0x00002196

c0d05e2c <USBD_GetCfgDesc_impl>:
{
c0d05e2c:	2140      	movs	r1, #64	; 0x40
  *length = sizeof (USBD_CfgDesc);
c0d05e2e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d05e30:	4801      	ldr	r0, [pc, #4]	; (c0d05e38 <USBD_GetCfgDesc_impl+0xc>)
c0d05e32:	4478      	add	r0, pc
c0d05e34:	4770      	bx	lr
c0d05e36:	46c0      	nop			; (mov r8, r8)
c0d05e38:	000021fe 	.word	0x000021fe

c0d05e3c <USBD_GetDeviceQualifierDesc_impl>:
{
c0d05e3c:	210a      	movs	r1, #10
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d05e3e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d05e40:	4801      	ldr	r0, [pc, #4]	; (c0d05e48 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d05e42:	4478      	add	r0, pc
c0d05e44:	4770      	bx	lr
c0d05e46:	46c0      	nop			; (mov r8, r8)
c0d05e48:	0000222e 	.word	0x0000222e

c0d05e4c <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d05e4c:	b5b0      	push	{r4, r5, r7, lr}
c0d05e4e:	460c      	mov	r4, r1
c0d05e50:	21f4      	movs	r1, #244	; 0xf4
c0d05e52:	2302      	movs	r3, #2
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d05e54:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d05e56:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d05e58:	61c2      	str	r2, [r0, #28]
c0d05e5a:	4601      	mov	r1, r0
c0d05e5c:	31f4      	adds	r1, #244	; 0xf4
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d05e5e:	63cc      	str	r4, [r1, #60]	; 0x3c
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d05e60:	6a01      	ldr	r1, [r0, #32]
c0d05e62:	4291      	cmp	r1, r2
c0d05e64:	d800      	bhi.n	c0d05e68 <USBD_CtlSendData+0x1c>
c0d05e66:	460a      	mov	r2, r1
c0d05e68:	b293      	uxth	r3, r2
c0d05e6a:	2500      	movs	r5, #0
c0d05e6c:	4629      	mov	r1, r5
c0d05e6e:	4622      	mov	r2, r4
c0d05e70:	f7ff f9c4 	bl	c0d051fc <USBD_LL_Transmit>
  
  return USBD_OK;
c0d05e74:	4628      	mov	r0, r5
c0d05e76:	bdb0      	pop	{r4, r5, r7, pc}

c0d05e78 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d05e78:	b5b0      	push	{r4, r5, r7, lr}
c0d05e7a:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d05e7c:	6a01      	ldr	r1, [r0, #32]
c0d05e7e:	4291      	cmp	r1, r2
c0d05e80:	d800      	bhi.n	c0d05e84 <USBD_CtlContinueSendData+0xc>
c0d05e82:	460a      	mov	r2, r1
c0d05e84:	b293      	uxth	r3, r2
c0d05e86:	2500      	movs	r5, #0
c0d05e88:	4629      	mov	r1, r5
c0d05e8a:	4622      	mov	r2, r4
c0d05e8c:	f7ff f9b6 	bl	c0d051fc <USBD_LL_Transmit>
  return USBD_OK;
c0d05e90:	4628      	mov	r0, r5
c0d05e92:	bdb0      	pop	{r4, r5, r7, pc}

c0d05e94 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d05e94:	b510      	push	{r4, lr}
c0d05e96:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d05e98:	4621      	mov	r1, r4
c0d05e9a:	f7ff f9c8 	bl	c0d0522e <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d05e9e:	4620      	mov	r0, r4
c0d05ea0:	bd10      	pop	{r4, pc}

c0d05ea2 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d05ea2:	b510      	push	{r4, lr}
c0d05ea4:	21f4      	movs	r1, #244	; 0xf4
c0d05ea6:	2204      	movs	r2, #4

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d05ea8:	5042      	str	r2, [r0, r1]
c0d05eaa:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d05eac:	4621      	mov	r1, r4
c0d05eae:	4622      	mov	r2, r4
c0d05eb0:	4623      	mov	r3, r4
c0d05eb2:	f7ff f9a3 	bl	c0d051fc <USBD_LL_Transmit>
  
  return USBD_OK;
c0d05eb6:	4620      	mov	r0, r4
c0d05eb8:	bd10      	pop	{r4, pc}

c0d05eba <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d05eba:	b510      	push	{r4, lr}
c0d05ebc:	21f4      	movs	r1, #244	; 0xf4
c0d05ebe:	2205      	movs	r2, #5
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d05ec0:	5042      	str	r2, [r0, r1]
c0d05ec2:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d05ec4:	4621      	mov	r1, r4
c0d05ec6:	4622      	mov	r2, r4
c0d05ec8:	f7ff f9b1 	bl	c0d0522e <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d05ecc:	4620      	mov	r0, r4
c0d05ece:	bd10      	pop	{r4, pc}

c0d05ed0 <ux_menu_element_preprocessor>:
    return ux_menu.menu_iterator(entry_idx);
  } 
  return &ux_menu.menu_entries[entry_idx];
} 

const bagl_element_t* ux_menu_element_preprocessor(const bagl_element_t* element) {
c0d05ed0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05ed2:	b083      	sub	sp, #12
c0d05ed4:	4606      	mov	r6, r0
  //todo avoid center alignment when text_x or icon_x AND text_x are not 0
  memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d05ed6:	4866      	ldr	r0, [pc, #408]	; (c0d06070 <ux_menu_element_preprocessor+0x1a0>)
c0d05ed8:	1d07      	adds	r7, r0, #4
c0d05eda:	2220      	movs	r2, #32
c0d05edc:	4638      	mov	r0, r7
c0d05ede:	4631      	mov	r1, r6
c0d05ee0:	f001 fa1c 	bl	c0d0731c <__aeabi_memmove>

  // ask the current entry first, to setup other entries
  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d05ee4:	4c63      	ldr	r4, [pc, #396]	; (c0d06074 <ux_menu_element_preprocessor+0x1a4>)
  if (ux_menu.menu_iterator) {
c0d05ee6:	6921      	ldr	r1, [r4, #16]
  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d05ee8:	68a0      	ldr	r0, [r4, #8]
  if (ux_menu.menu_iterator) {
c0d05eea:	2900      	cmp	r1, #0
c0d05eec:	d001      	beq.n	c0d05ef2 <ux_menu_element_preprocessor+0x22>
    return ux_menu.menu_iterator(entry_idx);
c0d05eee:	4788      	blx	r1
c0d05ef0:	e003      	b.n	c0d05efa <ux_menu_element_preprocessor+0x2a>
c0d05ef2:	211c      	movs	r1, #28
  return &ux_menu.menu_entries[entry_idx];
c0d05ef4:	4341      	muls	r1, r0
c0d05ef6:	6820      	ldr	r0, [r4, #0]
c0d05ef8:	1840      	adds	r0, r0, r1
  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d05efa:	f7fd fa41 	bl	c0d03380 <pic>
  if (current_entry == NULL) {
c0d05efe:	2800      	cmp	r0, #0
c0d05f00:	d100      	bne.n	c0d05f04 <ux_menu_element_preprocessor+0x34>
c0d05f02:	e0a9      	b.n	c0d06058 <ux_menu_element_preprocessor+0x188>
c0d05f04:	4605      	mov	r5, r0
c0d05f06:	9702      	str	r7, [sp, #8]
    return NULL;
  }
  const bagl_icon_details_t* current_entry_icon = (const bagl_icon_details_t*)PIC(current_entry->icon);
c0d05f08:	68c0      	ldr	r0, [r0, #12]
c0d05f0a:	f7fd fa39 	bl	c0d03380 <pic>
c0d05f0e:	9001      	str	r0, [sp, #4]

  const ux_menu_entry_t* previous_entry = NULL;
  if (ux_menu.current_entry) {
c0d05f10:	68a0      	ldr	r0, [r4, #8]
c0d05f12:	2700      	movs	r7, #0
c0d05f14:	2800      	cmp	r0, #0
c0d05f16:	d005      	beq.n	c0d05f24 <ux_menu_element_preprocessor+0x54>
  if (ux_menu.menu_iterator) {
c0d05f18:	6921      	ldr	r1, [r4, #16]
    previous_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry-1));
c0d05f1a:	1e40      	subs	r0, r0, #1
  if (ux_menu.menu_iterator) {
c0d05f1c:	2900      	cmp	r1, #0
c0d05f1e:	d004      	beq.n	c0d05f2a <ux_menu_element_preprocessor+0x5a>
    return ux_menu.menu_iterator(entry_idx);
c0d05f20:	4788      	blx	r1
c0d05f22:	e006      	b.n	c0d05f32 <ux_menu_element_preprocessor+0x62>
  }
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
c0d05f24:	4638      	mov	r0, r7
c0d05f26:	463a      	mov	r2, r7
c0d05f28:	e007      	b.n	c0d05f3a <ux_menu_element_preprocessor+0x6a>
c0d05f2a:	211c      	movs	r1, #28
  return &ux_menu.menu_entries[entry_idx];
c0d05f2c:	4341      	muls	r1, r0
c0d05f2e:	6820      	ldr	r0, [r4, #0]
c0d05f30:	1840      	adds	r0, r0, r1
    previous_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry-1));
c0d05f32:	f7fd fa25 	bl	c0d03380 <pic>
c0d05f36:	4602      	mov	r2, r0
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
c0d05f38:	68a0      	ldr	r0, [r4, #8]
c0d05f3a:	6861      	ldr	r1, [r4, #4]
c0d05f3c:	1e49      	subs	r1, r1, #1
c0d05f3e:	4288      	cmp	r0, r1
c0d05f40:	d211      	bcs.n	c0d05f66 <ux_menu_element_preprocessor+0x96>
c0d05f42:	4623      	mov	r3, r4
c0d05f44:	9200      	str	r2, [sp, #0]
  if (ux_menu.menu_iterator) {
c0d05f46:	6921      	ldr	r1, [r4, #16]
    next_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry+1));
c0d05f48:	1c40      	adds	r0, r0, #1
  if (ux_menu.menu_iterator) {
c0d05f4a:	2900      	cmp	r1, #0
c0d05f4c:	d002      	beq.n	c0d05f54 <ux_menu_element_preprocessor+0x84>
c0d05f4e:	461c      	mov	r4, r3
    return ux_menu.menu_iterator(entry_idx);
c0d05f50:	4788      	blx	r1
c0d05f52:	e004      	b.n	c0d05f5e <ux_menu_element_preprocessor+0x8e>
c0d05f54:	211c      	movs	r1, #28
  return &ux_menu.menu_entries[entry_idx];
c0d05f56:	4341      	muls	r1, r0
c0d05f58:	461c      	mov	r4, r3
c0d05f5a:	6818      	ldr	r0, [r3, #0]
c0d05f5c:	1840      	adds	r0, r0, r1
    next_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry+1));
c0d05f5e:	f7fd fa0f 	bl	c0d03380 <pic>
c0d05f62:	4607      	mov	r7, r0
c0d05f64:	9a00      	ldr	r2, [sp, #0]
  }

  switch(element->component.userid) {
c0d05f66:	7870      	ldrb	r0, [r6, #1]
c0d05f68:	2840      	cmp	r0, #64	; 0x40
c0d05f6a:	dc09      	bgt.n	c0d05f80 <ux_menu_element_preprocessor+0xb0>
c0d05f6c:	2820      	cmp	r0, #32
c0d05f6e:	dc21      	bgt.n	c0d05fb4 <ux_menu_element_preprocessor+0xe4>
c0d05f70:	2810      	cmp	r0, #16
c0d05f72:	d030      	beq.n	c0d05fd6 <ux_menu_element_preprocessor+0x106>
c0d05f74:	2820      	cmp	r0, #32
c0d05f76:	d171      	bne.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
      if (current_entry->icon_x) {
        G_ux.tmp_element.component.x = current_entry->icon_x;
      }
      break;
    case 0x20:
      if (current_entry->line2 != NULL) {
c0d05f78:	6968      	ldr	r0, [r5, #20]
c0d05f7a:	2800      	cmp	r0, #0
c0d05f7c:	d16c      	bne.n	c0d06058 <ux_menu_element_preprocessor+0x188>
c0d05f7e:	e051      	b.n	c0d06024 <ux_menu_element_preprocessor+0x154>
  switch(element->component.userid) {
c0d05f80:	2880      	cmp	r0, #128	; 0x80
c0d05f82:	dc20      	bgt.n	c0d05fc6 <ux_menu_element_preprocessor+0xf6>
c0d05f84:	2841      	cmp	r0, #65	; 0x41
c0d05f86:	d031      	beq.n	c0d05fec <ux_menu_element_preprocessor+0x11c>
c0d05f88:	2842      	cmp	r0, #66	; 0x42
c0d05f8a:	d167      	bne.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
      if (current_entry->line2 != NULL
c0d05f8c:	6969      	ldr	r1, [r5, #20]
c0d05f8e:	2000      	movs	r0, #0
        || current_entry->icon != NULL
c0d05f90:	2900      	cmp	r1, #0
c0d05f92:	d16b      	bne.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
c0d05f94:	68e9      	ldr	r1, [r5, #12]
        || ux_menu.current_entry == ux_menu.menu_entries_count-1
c0d05f96:	2900      	cmp	r1, #0
c0d05f98:	d168      	bne.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
        || ux_menu.menu_entries_count == 1
c0d05f9a:	2f00      	cmp	r7, #0
c0d05f9c:	d066      	beq.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
c0d05f9e:	6861      	ldr	r1, [r4, #4]
c0d05fa0:	1e49      	subs	r1, r1, #1
c0d05fa2:	d063      	beq.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
c0d05fa4:	68a2      	ldr	r2, [r4, #8]
c0d05fa6:	428a      	cmp	r2, r1
c0d05fa8:	d060      	beq.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
        || next_entry->icon != NULL) {
c0d05faa:	68f9      	ldr	r1, [r7, #12]
      if (current_entry->line2 != NULL
c0d05fac:	2900      	cmp	r1, #0
c0d05fae:	d15d      	bne.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
      G_ux.tmp_element.text = next_entry->line1;
c0d05fb0:	6938      	ldr	r0, [r7, #16]
c0d05fb2:	e031      	b.n	c0d06018 <ux_menu_element_preprocessor+0x148>
  switch(element->component.userid) {
c0d05fb4:	2821      	cmp	r0, #33	; 0x21
c0d05fb6:	d032      	beq.n	c0d0601e <ux_menu_element_preprocessor+0x14e>
c0d05fb8:	2822      	cmp	r0, #34	; 0x22
c0d05fba:	d14f      	bne.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
        return NULL;
      }
      G_ux.tmp_element.text = current_entry->line1;
      goto adjust_text_x;
    case 0x22:
      if (current_entry->line2 == NULL) {
c0d05fbc:	6968      	ldr	r0, [r5, #20]
c0d05fbe:	2800      	cmp	r0, #0
c0d05fc0:	4a2b      	ldr	r2, [pc, #172]	; (c0d06070 <ux_menu_element_preprocessor+0x1a0>)
c0d05fc2:	d131      	bne.n	c0d06028 <ux_menu_element_preprocessor+0x158>
c0d05fc4:	e048      	b.n	c0d06058 <ux_menu_element_preprocessor+0x188>
  switch(element->component.userid) {
c0d05fc6:	2882      	cmp	r0, #130	; 0x82
c0d05fc8:	d041      	beq.n	c0d0604e <ux_menu_element_preprocessor+0x17e>
c0d05fca:	2881      	cmp	r0, #129	; 0x81
c0d05fcc:	d146      	bne.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
      if (ux_menu.current_entry == 0) {
c0d05fce:	68a0      	ldr	r0, [r4, #8]
c0d05fd0:	2800      	cmp	r0, #0
c0d05fd2:	d143      	bne.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
c0d05fd4:	e040      	b.n	c0d06058 <ux_menu_element_preprocessor+0x188>
      if (current_entry->icon == NULL) {
c0d05fd6:	68e8      	ldr	r0, [r5, #12]
c0d05fd8:	2800      	cmp	r0, #0
c0d05fda:	d03d      	beq.n	c0d06058 <ux_menu_element_preprocessor+0x188>
      G_ux.tmp_element.text = (const char*)current_entry->icon;
c0d05fdc:	4924      	ldr	r1, [pc, #144]	; (c0d06070 <ux_menu_element_preprocessor+0x1a0>)
c0d05fde:	6208      	str	r0, [r1, #32]
      if (current_entry->icon_x) {
c0d05fe0:	7e68      	ldrb	r0, [r5, #25]
c0d05fe2:	2800      	cmp	r0, #0
c0d05fe4:	d03a      	beq.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
        G_ux.tmp_element.component.x = current_entry->icon_x;
c0d05fe6:	4922      	ldr	r1, [pc, #136]	; (c0d06070 <ux_menu_element_preprocessor+0x1a0>)
c0d05fe8:	80c8      	strh	r0, [r1, #6]
c0d05fea:	e037      	b.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
      if (current_entry->line2 != NULL
c0d05fec:	6969      	ldr	r1, [r5, #20]
c0d05fee:	2000      	movs	r0, #0
        || current_entry->icon != NULL
c0d05ff0:	2900      	cmp	r1, #0
c0d05ff2:	d13b      	bne.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
        || ux_menu.current_entry == 0
c0d05ff4:	2a00      	cmp	r2, #0
c0d05ff6:	d039      	beq.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
c0d05ff8:	68e9      	ldr	r1, [r5, #12]
c0d05ffa:	2900      	cmp	r1, #0
c0d05ffc:	d136      	bne.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
c0d05ffe:	68a1      	ldr	r1, [r4, #8]
c0d06000:	2900      	cmp	r1, #0
c0d06002:	d033      	beq.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
c0d06004:	6861      	ldr	r1, [r4, #4]
c0d06006:	2901      	cmp	r1, #1
c0d06008:	d030      	beq.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
        || previous_entry->icon != NULL
c0d0600a:	68d1      	ldr	r1, [r2, #12]
        || previous_entry->line2 != NULL) {
c0d0600c:	2900      	cmp	r1, #0
c0d0600e:	d12d      	bne.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
c0d06010:	6951      	ldr	r1, [r2, #20]
      if (current_entry->line2 != NULL
c0d06012:	2900      	cmp	r1, #0
c0d06014:	d12a      	bne.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
      G_ux.tmp_element.text = previous_entry->line1;
c0d06016:	6910      	ldr	r0, [r2, #16]
c0d06018:	4915      	ldr	r1, [pc, #84]	; (c0d06070 <ux_menu_element_preprocessor+0x1a0>)
c0d0601a:	6208      	str	r0, [r1, #32]
c0d0601c:	e01e      	b.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
      if (current_entry->line2 == NULL) {
c0d0601e:	6968      	ldr	r0, [r5, #20]
c0d06020:	2800      	cmp	r0, #0
c0d06022:	d019      	beq.n	c0d06058 <ux_menu_element_preprocessor+0x188>
c0d06024:	6928      	ldr	r0, [r5, #16]
c0d06026:	4a12      	ldr	r2, [pc, #72]	; (c0d06070 <ux_menu_element_preprocessor+0x1a0>)
c0d06028:	6210      	str	r0, [r2, #32]
c0d0602a:	9801      	ldr	r0, [sp, #4]
        return NULL;
      }
      G_ux.tmp_element.text = current_entry->line2;
    adjust_text_x:
      if (current_entry_icon) {
c0d0602c:	2800      	cmp	r0, #0
c0d0602e:	d006      	beq.n	c0d0603e <ux_menu_element_preprocessor+0x16e>
        G_ux.tmp_element.component.x += current_entry_icon->width;
c0d06030:	8800      	ldrh	r0, [r0, #0]
c0d06032:	88d1      	ldrh	r1, [r2, #6]
c0d06034:	1809      	adds	r1, r1, r0
c0d06036:	80d1      	strh	r1, [r2, #6]
        G_ux.tmp_element.component.width -= current_entry_icon->width;
c0d06038:	8951      	ldrh	r1, [r2, #10]
c0d0603a:	1a08      	subs	r0, r1, r0
c0d0603c:	8150      	strh	r0, [r2, #10]
      }
      if (current_entry->text_x) {
c0d0603e:	7e28      	ldrb	r0, [r5, #24]
c0d06040:	2800      	cmp	r0, #0
c0d06042:	d00b      	beq.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
c0d06044:	2108      	movs	r1, #8
c0d06046:	4a0a      	ldr	r2, [pc, #40]	; (c0d06070 <ux_menu_element_preprocessor+0x1a0>)
        G_ux.tmp_element.component.x = current_entry->text_x;
        // discard the 'center' flag
        G_ux.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_EXTRABOLD_11px;
c0d06048:	8391      	strh	r1, [r2, #28]
        G_ux.tmp_element.component.x = current_entry->text_x;
c0d0604a:	80d0      	strh	r0, [r2, #6]
c0d0604c:	e006      	b.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
      if (ux_menu.current_entry == ux_menu.menu_entries_count-1) {
c0d0604e:	6860      	ldr	r0, [r4, #4]
c0d06050:	68a1      	ldr	r1, [r4, #8]
c0d06052:	1e40      	subs	r0, r0, #1
c0d06054:	4281      	cmp	r1, r0
c0d06056:	d101      	bne.n	c0d0605c <ux_menu_element_preprocessor+0x18c>
c0d06058:	2000      	movs	r0, #0
c0d0605a:	e007      	b.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
      }
      break;
  }
  // ensure prepro agrees to the element to be displayed
  if (ux_menu.menu_entry_preprocessor) {
c0d0605c:	68e2      	ldr	r2, [r4, #12]
c0d0605e:	2a00      	cmp	r2, #0
c0d06060:	9802      	ldr	r0, [sp, #8]
c0d06062:	d003      	beq.n	c0d0606c <ux_menu_element_preprocessor+0x19c>
    // menu is denied by the menu entry preprocessor
    return ux_menu.menu_entry_preprocessor(current_entry, &G_ux.tmp_element);
c0d06064:	4802      	ldr	r0, [pc, #8]	; (c0d06070 <ux_menu_element_preprocessor+0x1a0>)
c0d06066:	1d01      	adds	r1, r0, #4
c0d06068:	4628      	mov	r0, r5
c0d0606a:	4790      	blx	r2
  }

  return &G_ux.tmp_element;
}
c0d0606c:	b003      	add	sp, #12
c0d0606e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d06070:	200005f0 	.word	0x200005f0
c0d06074:	20000580 	.word	0x20000580

c0d06078 <ux_menu_elements_button>:

unsigned int ux_menu_elements_button (unsigned int button_mask, unsigned int button_mask_counter) {
c0d06078:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0607a:	b081      	sub	sp, #4
c0d0607c:	4605      	mov	r5, r0
  UNUSED(button_mask_counter);

  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d0607e:	4f41      	ldr	r7, [pc, #260]	; (c0d06184 <ux_menu_elements_button+0x10c>)
  if (ux_menu.menu_iterator) {
c0d06080:	6939      	ldr	r1, [r7, #16]
  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d06082:	68b8      	ldr	r0, [r7, #8]
  if (ux_menu.menu_iterator) {
c0d06084:	2900      	cmp	r1, #0
c0d06086:	d001      	beq.n	c0d0608c <ux_menu_elements_button+0x14>
    return ux_menu.menu_iterator(entry_idx);
c0d06088:	4788      	blx	r1
c0d0608a:	e003      	b.n	c0d06094 <ux_menu_elements_button+0x1c>
c0d0608c:	211c      	movs	r1, #28
  return &ux_menu.menu_entries[entry_idx];
c0d0608e:	4341      	muls	r1, r0
c0d06090:	6838      	ldr	r0, [r7, #0]
c0d06092:	1840      	adds	r0, r0, r1
  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d06094:	f7fd f974 	bl	c0d03380 <pic>
c0d06098:	2401      	movs	r4, #1
  if (current_entry == NULL) {
c0d0609a:	2800      	cmp	r0, #0
c0d0609c:	d06f      	beq.n	c0d0617e <ux_menu_elements_button+0x106>
c0d0609e:	4606      	mov	r6, r0
c0d060a0:	4839      	ldr	r0, [pc, #228]	; (c0d06188 <ux_menu_elements_button+0x110>)
    return 1;
  }

  switch (button_mask) {
c0d060a2:	4285      	cmp	r5, r0
c0d060a4:	dd14      	ble.n	c0d060d0 <ux_menu_elements_button+0x58>
c0d060a6:	4839      	ldr	r0, [pc, #228]	; (c0d0618c <ux_menu_elements_button+0x114>)
c0d060a8:	4285      	cmp	r5, r0
c0d060aa:	d016      	beq.n	c0d060da <ux_menu_elements_button+0x62>
c0d060ac:	4838      	ldr	r0, [pc, #224]	; (c0d06190 <ux_menu_elements_button+0x118>)
c0d060ae:	4285      	cmp	r5, r0
c0d060b0:	d01a      	beq.n	c0d060e8 <ux_menu_elements_button+0x70>
c0d060b2:	4838      	ldr	r0, [pc, #224]	; (c0d06194 <ux_menu_elements_button+0x11c>)
c0d060b4:	4285      	cmp	r5, r0
c0d060b6:	d162      	bne.n	c0d0617e <ux_menu_elements_button+0x106>
    // enter menu or exit menu
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      // menu is priority 1
      if (current_entry->menu) {
c0d060b8:	6830      	ldr	r0, [r6, #0]
c0d060ba:	2800      	cmp	r0, #0
c0d060bc:	d056      	beq.n	c0d0616c <ux_menu_elements_button+0xf4>
        // use userid as the pointer to current entry in the parent menu
        UX_MENU_DISPLAY(current_entry->userid, (const ux_menu_entry_t*)PIC(current_entry->menu), ux_menu.menu_entry_preprocessor);
c0d060be:	68b4      	ldr	r4, [r6, #8]
c0d060c0:	f7fd f95e 	bl	c0d03380 <pic>
c0d060c4:	4601      	mov	r1, r0
c0d060c6:	68fa      	ldr	r2, [r7, #12]
c0d060c8:	4620      	mov	r0, r4
c0d060ca:	f000 f869 	bl	c0d061a0 <ux_menu_display>
c0d060ce:	e055      	b.n	c0d0617c <ux_menu_elements_button+0x104>
c0d060d0:	4931      	ldr	r1, [pc, #196]	; (c0d06198 <ux_menu_elements_button+0x120>)
  switch (button_mask) {
c0d060d2:	428d      	cmp	r5, r1
c0d060d4:	d008      	beq.n	c0d060e8 <ux_menu_elements_button+0x70>
c0d060d6:	4285      	cmp	r5, r0
c0d060d8:	d151      	bne.n	c0d0617e <ux_menu_elements_button+0x106>
      goto redraw;

    case BUTTON_EVT_FAST|BUTTON_RIGHT:
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      // entry 0 is the number of entries in the menu list
      if (ux_menu.current_entry >= ux_menu.menu_entries_count-1) {
c0d060da:	6879      	ldr	r1, [r7, #4]
c0d060dc:	68b8      	ldr	r0, [r7, #8]
c0d060de:	1e49      	subs	r1, r1, #1
c0d060e0:	4288      	cmp	r0, r1
c0d060e2:	d24b      	bcs.n	c0d0617c <ux_menu_elements_button+0x104>
        return 0;
      }
      ux_menu.current_entry++;
c0d060e4:	1c40      	adds	r0, r0, #1
c0d060e6:	e003      	b.n	c0d060f0 <ux_menu_elements_button+0x78>
      if (ux_menu.current_entry == 0) {
c0d060e8:	68b8      	ldr	r0, [r7, #8]
c0d060ea:	2800      	cmp	r0, #0
c0d060ec:	d046      	beq.n	c0d0617c <ux_menu_elements_button+0x104>
      ux_menu.current_entry--;
c0d060ee:	1e40      	subs	r0, r0, #1
c0d060f0:	60b8      	str	r0, [r7, #8]
    redraw:
#ifdef HAVE_BOLOS_UX
      ux_stack_display(0);
#else
      UX_REDISPLAY();
c0d060f2:	f7fb fc8d 	bl	c0d01a10 <io_seproxyhal_init_ux>
c0d060f6:	f7fb fc8d 	bl	c0d01a14 <io_seproxyhal_init_button>
c0d060fa:	4d28      	ldr	r5, [pc, #160]	; (c0d0619c <ux_menu_elements_button+0x124>)
c0d060fc:	2400      	movs	r4, #0
c0d060fe:	84ec      	strh	r4, [r5, #38]	; 0x26
c0d06100:	2004      	movs	r0, #4
c0d06102:	f7fe fefb 	bl	c0d04efc <os_sched_last_status>
c0d06106:	64a8      	str	r0, [r5, #72]	; 0x48
c0d06108:	2800      	cmp	r0, #0
c0d0610a:	d038      	beq.n	c0d0617e <ux_menu_elements_button+0x106>
c0d0610c:	2897      	cmp	r0, #151	; 0x97
c0d0610e:	d036      	beq.n	c0d0617e <ux_menu_elements_button+0x106>
c0d06110:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d06112:	2800      	cmp	r0, #0
c0d06114:	d033      	beq.n	c0d0617e <ux_menu_elements_button+0x106>
c0d06116:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d06118:	212c      	movs	r1, #44	; 0x2c
c0d0611a:	5c69      	ldrb	r1, [r5, r1]
c0d0611c:	b280      	uxth	r0, r0
c0d0611e:	4288      	cmp	r0, r1
c0d06120:	d22d      	bcs.n	c0d0617e <ux_menu_elements_button+0x106>
c0d06122:	f7fe feb7 	bl	c0d04e94 <io_seph_is_status_sent>
c0d06126:	2800      	cmp	r0, #0
c0d06128:	d129      	bne.n	c0d0617e <ux_menu_elements_button+0x106>
c0d0612a:	f7fe fe1d 	bl	c0d04d68 <os_perso_isonboarded>
c0d0612e:	28aa      	cmp	r0, #170	; 0xaa
c0d06130:	d103      	bne.n	c0d0613a <ux_menu_elements_button+0xc2>
c0d06132:	f7fe fe49 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d06136:	28aa      	cmp	r0, #170	; 0xaa
c0d06138:	d121      	bne.n	c0d0617e <ux_menu_elements_button+0x106>
c0d0613a:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d0613c:	8cea      	ldrh	r2, [r5, #38]	; 0x26
c0d0613e:	0150      	lsls	r0, r2, #5
c0d06140:	1808      	adds	r0, r1, r0
c0d06142:	6b2b      	ldr	r3, [r5, #48]	; 0x30
c0d06144:	2b00      	cmp	r3, #0
c0d06146:	d004      	beq.n	c0d06152 <ux_menu_elements_button+0xda>
c0d06148:	4798      	blx	r3
c0d0614a:	2800      	cmp	r0, #0
c0d0614c:	d007      	beq.n	c0d0615e <ux_menu_elements_button+0xe6>
c0d0614e:	8cea      	ldrh	r2, [r5, #38]	; 0x26
c0d06150:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d06152:	2801      	cmp	r0, #1
c0d06154:	d101      	bne.n	c0d0615a <ux_menu_elements_button+0xe2>
c0d06156:	0150      	lsls	r0, r2, #5
c0d06158:	1808      	adds	r0, r1, r0
c0d0615a:	f000 f95d 	bl	c0d06418 <io_seproxyhal_display>
c0d0615e:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d06160:	1c40      	adds	r0, r0, #1
c0d06162:	84e8      	strh	r0, [r5, #38]	; 0x26
c0d06164:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d06166:	2900      	cmp	r1, #0
c0d06168:	d1d6      	bne.n	c0d06118 <ux_menu_elements_button+0xa0>
c0d0616a:	e008      	b.n	c0d0617e <ux_menu_elements_button+0x106>
      else if (current_entry->callback) {
c0d0616c:	6870      	ldr	r0, [r6, #4]
c0d0616e:	2800      	cmp	r0, #0
c0d06170:	d005      	beq.n	c0d0617e <ux_menu_elements_button+0x106>
        ((ux_menu_callback_t)PIC(current_entry->callback))(current_entry->userid);
c0d06172:	f7fd f905 	bl	c0d03380 <pic>
c0d06176:	4601      	mov	r1, r0
c0d06178:	68b0      	ldr	r0, [r6, #8]
c0d0617a:	4788      	blx	r1
c0d0617c:	2400      	movs	r4, #0
#endif
      return 0;
  }
  return 1;
}
c0d0617e:	4620      	mov	r0, r4
c0d06180:	b001      	add	sp, #4
c0d06182:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d06184:	20000580 	.word	0x20000580
c0d06188:	80000002 	.word	0x80000002
c0d0618c:	40000002 	.word	0x40000002
c0d06190:	40000001 	.word	0x40000001
c0d06194:	80000003 	.word	0x80000003
c0d06198:	80000001 	.word	0x80000001
c0d0619c:	200005f0 	.word	0x200005f0

c0d061a0 <ux_menu_display>:

const ux_menu_entry_t UX_MENU_END_ENTRY = UX_MENU_END;

void ux_menu_display(unsigned int current_entry, 
                     const ux_menu_entry_t* menu_entries,
                     ux_menu_preprocessor_t menu_entry_preprocessor) {
c0d061a0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d061a2:	b083      	sub	sp, #12
c0d061a4:	9201      	str	r2, [sp, #4]
c0d061a6:	9000      	str	r0, [sp, #0]
  // reset to first entry
  ux_menu.menu_entries_count = 0;
c0d061a8:	4c41      	ldr	r4, [pc, #260]	; (c0d062b0 <ux_menu_display+0x110>)
c0d061aa:	2600      	movs	r6, #0
c0d061ac:	6066      	str	r6, [r4, #4]

  // count entries
  if (menu_entries) {
c0d061ae:	2900      	cmp	r1, #0
c0d061b0:	9102      	str	r1, [sp, #8]
c0d061b2:	d017      	beq.n	c0d061e4 <ux_menu_display+0x44>
c0d061b4:	460b      	mov	r3, r1
    for(;;) {
      if (memcmp(&menu_entries[ux_menu.menu_entries_count], &UX_MENU_END_ENTRY, sizeof(ux_menu_entry_t)) == 0) {
c0d061b6:	4940      	ldr	r1, [pc, #256]	; (c0d062b8 <ux_menu_display+0x118>)
c0d061b8:	4479      	add	r1, pc
c0d061ba:	221c      	movs	r2, #28
c0d061bc:	4618      	mov	r0, r3
c0d061be:	f001 f8bd 	bl	c0d0733c <memcmp>
c0d061c2:	2800      	cmp	r0, #0
c0d061c4:	d00e      	beq.n	c0d061e4 <ux_menu_display+0x44>
    for(;;) {
c0d061c6:	9f02      	ldr	r7, [sp, #8]
c0d061c8:	371c      	adds	r7, #28
c0d061ca:	2600      	movs	r6, #0
c0d061cc:	4d3b      	ldr	r5, [pc, #236]	; (c0d062bc <ux_menu_display+0x11c>)
c0d061ce:	447d      	add	r5, pc
        break;
      }
      ux_menu.menu_entries_count++;
c0d061d0:	1c76      	adds	r6, r6, #1
c0d061d2:	6066      	str	r6, [r4, #4]
c0d061d4:	221c      	movs	r2, #28
      if (memcmp(&menu_entries[ux_menu.menu_entries_count], &UX_MENU_END_ENTRY, sizeof(ux_menu_entry_t)) == 0) {
c0d061d6:	4638      	mov	r0, r7
c0d061d8:	4629      	mov	r1, r5
c0d061da:	f001 f8af 	bl	c0d0733c <memcmp>
c0d061de:	371c      	adds	r7, #28
c0d061e0:	2800      	cmp	r0, #0
c0d061e2:	d1f5      	bne.n	c0d061d0 <ux_menu_display+0x30>
c0d061e4:	9900      	ldr	r1, [sp, #0]
    }
  }

  if (current_entry != UX_MENU_UNCHANGED_ENTRY) {
c0d061e6:	1c48      	adds	r0, r1, #1
c0d061e8:	d003      	beq.n	c0d061f2 <ux_menu_display+0x52>
    ux_menu.current_entry = current_entry;
    if (ux_menu.current_entry > ux_menu.menu_entries_count) {
c0d061ea:	428e      	cmp	r6, r1
c0d061ec:	d200      	bcs.n	c0d061f0 <ux_menu_display+0x50>
c0d061ee:	2100      	movs	r1, #0
c0d061f0:	60a1      	str	r1, [r4, #8]
c0d061f2:	212c      	movs	r1, #44	; 0x2c
  G_ux.stack[0].button_push_callback = ux_menu_elements_button;

  ux_stack_display(0);
#else
  // display the menu current entry
  UX_DISPLAY(ux_menu_elements, ux_menu_element_preprocessor);
c0d061f4:	9100      	str	r1, [sp, #0]
c0d061f6:	4f2f      	ldr	r7, [pc, #188]	; (c0d062b4 <ux_menu_display+0x114>)
c0d061f8:	2009      	movs	r0, #9
c0d061fa:	5478      	strb	r0, [r7, r1]
c0d061fc:	2044      	movs	r0, #68	; 0x44
c0d061fe:	2103      	movs	r1, #3
c0d06200:	5439      	strb	r1, [r7, r0]
c0d06202:	2600      	movs	r6, #0
  ux_menu.menu_entry_preprocessor = menu_entry_preprocessor;
c0d06204:	9801      	ldr	r0, [sp, #4]
c0d06206:	60e0      	str	r0, [r4, #12]
  ux_menu.menu_iterator = NULL;
c0d06208:	6126      	str	r6, [r4, #16]
  ux_menu.menu_entries = menu_entries;
c0d0620a:	9802      	ldr	r0, [sp, #8]
c0d0620c:	6020      	str	r0, [r4, #0]
  UX_DISPLAY(ux_menu_elements, ux_menu_element_preprocessor);
c0d0620e:	482c      	ldr	r0, [pc, #176]	; (c0d062c0 <ux_menu_display+0x120>)
c0d06210:	4478      	add	r0, pc
c0d06212:	492c      	ldr	r1, [pc, #176]	; (c0d062c4 <ux_menu_display+0x124>)
c0d06214:	4479      	add	r1, pc
c0d06216:	62b9      	str	r1, [r7, #40]	; 0x28
c0d06218:	492b      	ldr	r1, [pc, #172]	; (c0d062c8 <ux_menu_display+0x128>)
c0d0621a:	4479      	add	r1, pc
c0d0621c:	6339      	str	r1, [r7, #48]	; 0x30
c0d0621e:	6378      	str	r0, [r7, #52]	; 0x34
c0d06220:	463c      	mov	r4, r7
c0d06222:	3444      	adds	r4, #68	; 0x44
c0d06224:	6066      	str	r6, [r4, #4]
c0d06226:	4620      	mov	r0, r4
c0d06228:	f7fe fddc 	bl	c0d04de4 <os_ux>
c0d0622c:	2504      	movs	r5, #4
c0d0622e:	4628      	mov	r0, r5
c0d06230:	f7fe fe64 	bl	c0d04efc <os_sched_last_status>
c0d06234:	6060      	str	r0, [r4, #4]
c0d06236:	f7fb fbeb 	bl	c0d01a10 <io_seproxyhal_init_ux>
c0d0623a:	f7fb fbeb 	bl	c0d01a14 <io_seproxyhal_init_button>
c0d0623e:	84fe      	strh	r6, [r7, #38]	; 0x26
c0d06240:	4628      	mov	r0, r5
c0d06242:	f7fe fe5b 	bl	c0d04efc <os_sched_last_status>
c0d06246:	6060      	str	r0, [r4, #4]
c0d06248:	9c00      	ldr	r4, [sp, #0]
c0d0624a:	2800      	cmp	r0, #0
c0d0624c:	d02d      	beq.n	c0d062aa <ux_menu_display+0x10a>
c0d0624e:	2897      	cmp	r0, #151	; 0x97
c0d06250:	d02b      	beq.n	c0d062aa <ux_menu_display+0x10a>
c0d06252:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d06254:	2800      	cmp	r0, #0
c0d06256:	d028      	beq.n	c0d062aa <ux_menu_display+0x10a>
c0d06258:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d0625a:	5d39      	ldrb	r1, [r7, r4]
c0d0625c:	b280      	uxth	r0, r0
c0d0625e:	4288      	cmp	r0, r1
c0d06260:	d223      	bcs.n	c0d062aa <ux_menu_display+0x10a>
c0d06262:	f7fe fe17 	bl	c0d04e94 <io_seph_is_status_sent>
c0d06266:	2800      	cmp	r0, #0
c0d06268:	d11f      	bne.n	c0d062aa <ux_menu_display+0x10a>
c0d0626a:	f7fe fd7d 	bl	c0d04d68 <os_perso_isonboarded>
c0d0626e:	28aa      	cmp	r0, #170	; 0xaa
c0d06270:	d103      	bne.n	c0d0627a <ux_menu_display+0xda>
c0d06272:	f7fe fda9 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d06276:	28aa      	cmp	r0, #170	; 0xaa
c0d06278:	d117      	bne.n	c0d062aa <ux_menu_display+0x10a>
c0d0627a:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d0627c:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
c0d0627e:	0150      	lsls	r0, r2, #5
c0d06280:	1808      	adds	r0, r1, r0
c0d06282:	6b3b      	ldr	r3, [r7, #48]	; 0x30
c0d06284:	2b00      	cmp	r3, #0
c0d06286:	d004      	beq.n	c0d06292 <ux_menu_display+0xf2>
c0d06288:	4798      	blx	r3
c0d0628a:	2800      	cmp	r0, #0
c0d0628c:	d007      	beq.n	c0d0629e <ux_menu_display+0xfe>
c0d0628e:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
c0d06290:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d06292:	2801      	cmp	r0, #1
c0d06294:	d101      	bne.n	c0d0629a <ux_menu_display+0xfa>
c0d06296:	0150      	lsls	r0, r2, #5
c0d06298:	1808      	adds	r0, r1, r0
c0d0629a:	f000 f8bd 	bl	c0d06418 <io_seproxyhal_display>
c0d0629e:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d062a0:	1c40      	adds	r0, r0, #1
c0d062a2:	84f8      	strh	r0, [r7, #38]	; 0x26
c0d062a4:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d062a6:	2900      	cmp	r1, #0
c0d062a8:	d1d7      	bne.n	c0d0625a <ux_menu_display+0xba>
#endif
}
c0d062aa:	b003      	add	sp, #12
c0d062ac:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d062ae:	46c0      	nop			; (mov r8, r8)
c0d062b0:	20000580 	.word	0x20000580
c0d062b4:	200005f0 	.word	0x200005f0
c0d062b8:	00001fe4 	.word	0x00001fe4
c0d062bc:	00001fce 	.word	0x00001fce
c0d062c0:	fffffe65 	.word	0xfffffe65
c0d062c4:	00001e68 	.word	0x00001e68
c0d062c8:	fffffcb3 	.word	0xfffffcb3

c0d062cc <ux_stack_push>:
  }

  return 0;
}

unsigned int ux_stack_push(void) {
c0d062cc:	b510      	push	{r4, lr}
  // only push if an available slot exists
  if (G_ux.stack_count < ARRAYLEN(G_ux.stack)) {
c0d062ce:	4c06      	ldr	r4, [pc, #24]	; (c0d062e8 <ux_stack_push+0x1c>)
c0d062d0:	7820      	ldrb	r0, [r4, #0]
c0d062d2:	2800      	cmp	r0, #0
c0d062d4:	d106      	bne.n	c0d062e4 <ux_stack_push+0x18>
    memset(&G_ux.stack[G_ux.stack_count], 0, sizeof(G_ux.stack[0]));
c0d062d6:	4620      	mov	r0, r4
c0d062d8:	3024      	adds	r0, #36	; 0x24
c0d062da:	2120      	movs	r1, #32
c0d062dc:	f001 f814 	bl	c0d07308 <__aeabi_memclr>
c0d062e0:	2001      	movs	r0, #1
#ifdef HAVE_UX_FLOW
    memset(&G_ux.flow_stack[G_ux.stack_count], 0, sizeof(G_ux.flow_stack[0]));
#endif // HAVE_UX_FLOW
    G_ux.stack_count++;
c0d062e2:	7020      	strb	r0, [r4, #0]
  }
  // return the stack top index
  return G_ux.stack_count - 1;
c0d062e4:	1e40      	subs	r0, r0, #1
c0d062e6:	bd10      	pop	{r4, pc}
c0d062e8:	200005f0 	.word	0x200005f0

c0d062ec <ux_stack_pop>:
}

unsigned int ux_stack_pop(void) {
c0d062ec:	b5b0      	push	{r4, r5, r7, lr}
  unsigned int exit_code = BOLOS_UX_OK;
  // only pop if more than two stack entry (0 and 1,top is an index not a count)
  if (G_ux.stack_count > 0) {
c0d062ee:	4c0e      	ldr	r4, [pc, #56]	; (c0d06328 <ux_stack_pop+0x3c>)
c0d062f0:	7820      	ldrb	r0, [r4, #0]
c0d062f2:	2800      	cmp	r0, #0
c0d062f4:	d00a      	beq.n	c0d0630c <ux_stack_pop+0x20>
    G_ux.stack_count--;
c0d062f6:	1e40      	subs	r0, r0, #1
c0d062f8:	7020      	strb	r0, [r4, #0]
    if (G_ux.stack_count < UX_STACK_SLOT_COUNT) {
c0d062fa:	0601      	lsls	r1, r0, #24
c0d062fc:	d008      	beq.n	c0d06310 <ux_stack_pop+0x24>
#endif // HAVE_UX_FLOW
    }
  }

  // prepare output code when popping the last stack screen
  if (G_ux.stack_count == 0) {
c0d062fe:	b2c0      	uxtb	r0, r0
  }
  // ask for a complete redraw (optimisation due to blink must be avoided as we're returning from a modal, and within
  // the bolos ux screen stack)
  else {
    // prepare to redraw the slot when asked
    G_ux.stack[G_ux.stack_count - 1].element_index = 0;
c0d06300:	1e40      	subs	r0, r0, #1
c0d06302:	0141      	lsls	r1, r0, #5
c0d06304:	1861      	adds	r1, r4, r1
c0d06306:	2200      	movs	r2, #0
c0d06308:	84ca      	strh	r2, [r1, #38]	; 0x26
  }
  // return the stack top index (or -1 if no top)
  return G_ux.stack_count - 1;
c0d0630a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0630c:	25aa      	movs	r5, #170	; 0xaa
c0d0630e:	e006      	b.n	c0d0631e <ux_stack_pop+0x32>
c0d06310:	2024      	movs	r0, #36	; 0x24
      exit_code = G_ux.stack[G_ux.stack_count].exit_code_after_elements_displayed;
c0d06312:	5c25      	ldrb	r5, [r4, r0]
c0d06314:	4620      	mov	r0, r4
c0d06316:	3024      	adds	r0, #36	; 0x24
c0d06318:	2120      	movs	r1, #32
      memset(&G_ux.stack[G_ux.stack_count], 0, sizeof(G_ux.stack[0]));
c0d0631a:	f000 fff5 	bl	c0d07308 <__aeabi_memclr>
    G_ux.exit_code = exit_code;
c0d0631e:	7065      	strb	r5, [r4, #1]
c0d06320:	2000      	movs	r0, #0
c0d06322:	43c0      	mvns	r0, r0
  return G_ux.stack_count - 1;
c0d06324:	bdb0      	pop	{r4, r5, r7, pc}
c0d06326:	46c0      	nop			; (mov r8, r8)
c0d06328:	200005f0 	.word	0x200005f0

c0d0632c <ux_stack_init>:
  // wipe last slot
  ux_stack_pop();
}

// common code for all screens
void ux_stack_init(unsigned int stack_slot) {
c0d0632c:	b510      	push	{r4, lr}
c0d0632e:	4604      	mov	r4, r0
  // reinit ux behavior (previous touched element, button push state)
  io_seproxyhal_init_ux(); // glitch upon ux_stack_display for a button being pressed in a previous screen
c0d06330:	f7fb fb6e 	bl	c0d01a10 <io_seproxyhal_init_ux>
  if (G_ux.stack_count<stack_slot+1) {
    reset();
  }
  */

  if (stack_slot < UX_STACK_SLOT_COUNT) {
c0d06334:	2c00      	cmp	r4, #0
c0d06336:	d000      	beq.n	c0d0633a <ux_stack_init+0xe>
#endif // HAVE_UX_STACK_INIT_KEEP_TICKER

    // init current screen state
    G_ux.stack[stack_slot].exit_code_after_elements_displayed = BOLOS_UX_CONTINUE;
  }
}
c0d06338:	bd10      	pop	{r4, pc}
    G_ux.stack[stack_slot].exit_code_after_elements_displayed = BOLOS_UX_CONTINUE;
c0d0633a:	4803      	ldr	r0, [pc, #12]	; (c0d06348 <ux_stack_init+0x1c>)
c0d0633c:	3024      	adds	r0, #36	; 0x24
c0d0633e:	2120      	movs	r1, #32
c0d06340:	f000 ffe2 	bl	c0d07308 <__aeabi_memclr>
}
c0d06344:	bd10      	pop	{r4, pc}
c0d06346:	46c0      	nop			; (mov r8, r8)
c0d06348:	200005f0 	.word	0x200005f0

c0d0634c <h_approve>:
#include <stdio.h>
#include <stdbool.h>

view_t viewdata;

void h_approve(unsigned int _) {
c0d0634c:	b570      	push	{r4, r5, r6, lr}
    zemu_log_stack("h_approve");
c0d0634e:	482f      	ldr	r0, [pc, #188]	; (c0d0640c <h_approve+0xc0>)
c0d06350:	4478      	add	r0, pc
c0d06352:	f000 fe45 	bl	c0d06fe0 <zemu_log_stack>
c0d06356:	2000      	movs	r0, #0
    viewdata.secret_click_count = 0;
#endif
}

void view_idle_show(uint8_t item_idx, char *statusString) {
    view_idle_show_impl(item_idx, statusString);
c0d06358:	4601      	mov	r1, r0
c0d0635a:	f000 fc23 	bl	c0d06ba4 <view_idle_show_impl>
c0d0635e:	252c      	movs	r5, #44	; 0x2c
    UX_WAIT();
c0d06360:	4e27      	ldr	r6, [pc, #156]	; (c0d06400 <h_approve+0xb4>)
c0d06362:	5d70      	ldrb	r0, [r6, r5]
c0d06364:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d06366:	4281      	cmp	r1, r0
c0d06368:	d235      	bcs.n	c0d063d6 <h_approve+0x8a>
c0d0636a:	4c26      	ldr	r4, [pc, #152]	; (c0d06404 <h_approve+0xb8>)
c0d0636c:	2180      	movs	r1, #128	; 0x80
c0d0636e:	2200      	movs	r2, #0
c0d06370:	4620      	mov	r0, r4
c0d06372:	f7fe fd9b 	bl	c0d04eac <io_seph_recv>
c0d06376:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d06378:	2800      	cmp	r0, #0
c0d0637a:	d028      	beq.n	c0d063ce <h_approve+0x82>
c0d0637c:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d0637e:	5d71      	ldrb	r1, [r6, r5]
c0d06380:	b280      	uxth	r0, r0
c0d06382:	4288      	cmp	r0, r1
c0d06384:	d223      	bcs.n	c0d063ce <h_approve+0x82>
c0d06386:	f7fe fd85 	bl	c0d04e94 <io_seph_is_status_sent>
c0d0638a:	2800      	cmp	r0, #0
c0d0638c:	d11f      	bne.n	c0d063ce <h_approve+0x82>
c0d0638e:	f7fe fceb 	bl	c0d04d68 <os_perso_isonboarded>
c0d06392:	28aa      	cmp	r0, #170	; 0xaa
c0d06394:	d103      	bne.n	c0d0639e <h_approve+0x52>
c0d06396:	f7fe fd17 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d0639a:	28aa      	cmp	r0, #170	; 0xaa
c0d0639c:	d117      	bne.n	c0d063ce <h_approve+0x82>
c0d0639e:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d063a0:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d063a2:	0150      	lsls	r0, r2, #5
c0d063a4:	1808      	adds	r0, r1, r0
c0d063a6:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d063a8:	2b00      	cmp	r3, #0
c0d063aa:	d004      	beq.n	c0d063b6 <h_approve+0x6a>
c0d063ac:	4798      	blx	r3
c0d063ae:	2800      	cmp	r0, #0
c0d063b0:	d007      	beq.n	c0d063c2 <h_approve+0x76>
c0d063b2:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d063b4:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d063b6:	2801      	cmp	r0, #1
c0d063b8:	d101      	bne.n	c0d063be <h_approve+0x72>
c0d063ba:	0150      	lsls	r0, r2, #5
c0d063bc:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d063be:	f7fb fb81 	bl	c0d01ac4 <io_seproxyhal_display_default>
    UX_WAIT();
c0d063c2:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d063c4:	1c40      	adds	r0, r0, #1
c0d063c6:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d063c8:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d063ca:	2900      	cmp	r1, #0
c0d063cc:	d1d7      	bne.n	c0d0637e <h_approve+0x32>
c0d063ce:	5d70      	ldrb	r0, [r6, r5]
c0d063d0:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d063d2:	4281      	cmp	r1, r0
c0d063d4:	d3ca      	bcc.n	c0d0636c <h_approve+0x20>
c0d063d6:	4c0b      	ldr	r4, [pc, #44]	; (c0d06404 <h_approve+0xb8>)
c0d063d8:	2580      	movs	r5, #128	; 0x80
c0d063da:	2600      	movs	r6, #0
c0d063dc:	4620      	mov	r0, r4
c0d063de:	4629      	mov	r1, r5
c0d063e0:	4632      	mov	r2, r6
c0d063e2:	f7fe fd63 	bl	c0d04eac <io_seph_recv>
c0d063e6:	f7fb f9e9 	bl	c0d017bc <io_seproxyhal_general_status>
c0d063ea:	4620      	mov	r0, r4
c0d063ec:	4629      	mov	r1, r5
c0d063ee:	4632      	mov	r2, r6
c0d063f0:	f7fe fd5c 	bl	c0d04eac <io_seph_recv>
    if (viewdata.viewfuncAccept != NULL) {
c0d063f4:	4804      	ldr	r0, [pc, #16]	; (c0d06408 <h_approve+0xbc>)
c0d063f6:	6d00      	ldr	r0, [r0, #80]	; 0x50
c0d063f8:	2800      	cmp	r0, #0
c0d063fa:	d000      	beq.n	c0d063fe <h_approve+0xb2>
        viewdata.viewfuncAccept();
c0d063fc:	4780      	blx	r0
}
c0d063fe:	bd70      	pop	{r4, r5, r6, pc}
c0d06400:	200005f0 	.word	0x200005f0
c0d06404:	20000202 	.word	0x20000202
c0d06408:	20000594 	.word	0x20000594
c0d0640c:	00001e68 	.word	0x00001e68

c0d06410 <view_idle_show>:
void view_idle_show(uint8_t item_idx, char *statusString) {
c0d06410:	b580      	push	{r7, lr}
    view_idle_show_impl(item_idx, statusString);
c0d06412:	f000 fbc7 	bl	c0d06ba4 <view_idle_show_impl>
}
c0d06416:	bd80      	pop	{r7, pc}

c0d06418 <io_seproxyhal_display>:
void io_seproxyhal_display(const bagl_element_t *element) {
c0d06418:	b580      	push	{r7, lr}
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d0641a:	f7fb fb53 	bl	c0d01ac4 <io_seproxyhal_display_default>
}
c0d0641e:	bd80      	pop	{r7, pc}

c0d06420 <h_reject>:
void h_reject(unsigned int _) {
c0d06420:	b570      	push	{r4, r5, r6, lr}
    zemu_log_stack("h_reject");
c0d06422:	4831      	ldr	r0, [pc, #196]	; (c0d064e8 <h_reject+0xc8>)
c0d06424:	4478      	add	r0, pc
c0d06426:	f000 fddb 	bl	c0d06fe0 <zemu_log_stack>
c0d0642a:	2000      	movs	r0, #0
    view_idle_show_impl(item_idx, statusString);
c0d0642c:	4601      	mov	r1, r0
c0d0642e:	f000 fbb9 	bl	c0d06ba4 <view_idle_show_impl>
c0d06432:	252c      	movs	r5, #44	; 0x2c
    UX_WAIT();
c0d06434:	4e29      	ldr	r6, [pc, #164]	; (c0d064dc <h_reject+0xbc>)
c0d06436:	5d70      	ldrb	r0, [r6, r5]
c0d06438:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d0643a:	4281      	cmp	r1, r0
c0d0643c:	d235      	bcs.n	c0d064aa <h_reject+0x8a>
c0d0643e:	4c28      	ldr	r4, [pc, #160]	; (c0d064e0 <h_reject+0xc0>)
c0d06440:	2180      	movs	r1, #128	; 0x80
c0d06442:	2200      	movs	r2, #0
c0d06444:	4620      	mov	r0, r4
c0d06446:	f7fe fd31 	bl	c0d04eac <io_seph_recv>
c0d0644a:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d0644c:	2800      	cmp	r0, #0
c0d0644e:	d028      	beq.n	c0d064a2 <h_reject+0x82>
c0d06450:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d06452:	5d71      	ldrb	r1, [r6, r5]
c0d06454:	b280      	uxth	r0, r0
c0d06456:	4288      	cmp	r0, r1
c0d06458:	d223      	bcs.n	c0d064a2 <h_reject+0x82>
c0d0645a:	f7fe fd1b 	bl	c0d04e94 <io_seph_is_status_sent>
c0d0645e:	2800      	cmp	r0, #0
c0d06460:	d11f      	bne.n	c0d064a2 <h_reject+0x82>
c0d06462:	f7fe fc81 	bl	c0d04d68 <os_perso_isonboarded>
c0d06466:	28aa      	cmp	r0, #170	; 0xaa
c0d06468:	d103      	bne.n	c0d06472 <h_reject+0x52>
c0d0646a:	f7fe fcad 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d0646e:	28aa      	cmp	r0, #170	; 0xaa
c0d06470:	d117      	bne.n	c0d064a2 <h_reject+0x82>
c0d06472:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d06474:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d06476:	0150      	lsls	r0, r2, #5
c0d06478:	1808      	adds	r0, r1, r0
c0d0647a:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d0647c:	2b00      	cmp	r3, #0
c0d0647e:	d004      	beq.n	c0d0648a <h_reject+0x6a>
c0d06480:	4798      	blx	r3
c0d06482:	2800      	cmp	r0, #0
c0d06484:	d007      	beq.n	c0d06496 <h_reject+0x76>
c0d06486:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d06488:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d0648a:	2801      	cmp	r0, #1
c0d0648c:	d101      	bne.n	c0d06492 <h_reject+0x72>
c0d0648e:	0150      	lsls	r0, r2, #5
c0d06490:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d06492:	f7fb fb17 	bl	c0d01ac4 <io_seproxyhal_display_default>
    UX_WAIT();
c0d06496:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d06498:	1c40      	adds	r0, r0, #1
c0d0649a:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d0649c:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d0649e:	2900      	cmp	r1, #0
c0d064a0:	d1d7      	bne.n	c0d06452 <h_reject+0x32>
c0d064a2:	5d70      	ldrb	r0, [r6, r5]
c0d064a4:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d064a6:	4281      	cmp	r1, r0
c0d064a8:	d3ca      	bcc.n	c0d06440 <h_reject+0x20>
c0d064aa:	4c0d      	ldr	r4, [pc, #52]	; (c0d064e0 <h_reject+0xc0>)
c0d064ac:	2580      	movs	r5, #128	; 0x80
c0d064ae:	2600      	movs	r6, #0
c0d064b0:	4620      	mov	r0, r4
c0d064b2:	4629      	mov	r1, r5
c0d064b4:	4632      	mov	r2, r6
c0d064b6:	f7fe fcf9 	bl	c0d04eac <io_seph_recv>
c0d064ba:	f7fb f97f 	bl	c0d017bc <io_seproxyhal_general_status>
c0d064be:	4620      	mov	r0, r4
c0d064c0:	4629      	mov	r1, r5
c0d064c2:	4632      	mov	r2, r6
c0d064c4:	f7fe fcf2 	bl	c0d04eac <io_seph_recv>
c0d064c8:	4806      	ldr	r0, [pc, #24]	; (c0d064e4 <h_reject+0xc4>)
c0d064ca:	2186      	movs	r1, #134	; 0x86
    *(buffer + offset + 1) = (uint8_t) (value & 0xFF);
c0d064cc:	7041      	strb	r1, [r0, #1]
c0d064ce:	2169      	movs	r1, #105	; 0x69
    *(buffer + offset) = (uint8_t) (value >> 8);
c0d064d0:	7001      	strb	r1, [r0, #0]
c0d064d2:	2020      	movs	r0, #32
c0d064d4:	2102      	movs	r1, #2
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d064d6:	f7fb fbc7 	bl	c0d01c68 <io_exchange>
}
c0d064da:	bd70      	pop	{r4, r5, r6, pc}
c0d064dc:	200005f0 	.word	0x200005f0
c0d064e0:	20000202 	.word	0x20000202
c0d064e4:	200002b0 	.word	0x200002b0
c0d064e8:	00001d9e 	.word	0x00001d9e

c0d064ec <h_error_accept>:
void h_error_accept(unsigned int _) {
c0d064ec:	b570      	push	{r4, r5, r6, lr}
c0d064ee:	2000      	movs	r0, #0
    view_idle_show_impl(item_idx, statusString);
c0d064f0:	4601      	mov	r1, r0
c0d064f2:	f000 fb57 	bl	c0d06ba4 <view_idle_show_impl>
c0d064f6:	252c      	movs	r5, #44	; 0x2c
    UX_WAIT();
c0d064f8:	4e29      	ldr	r6, [pc, #164]	; (c0d065a0 <h_error_accept+0xb4>)
c0d064fa:	5d70      	ldrb	r0, [r6, r5]
c0d064fc:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d064fe:	4281      	cmp	r1, r0
c0d06500:	d235      	bcs.n	c0d0656e <h_error_accept+0x82>
c0d06502:	4c28      	ldr	r4, [pc, #160]	; (c0d065a4 <h_error_accept+0xb8>)
c0d06504:	2180      	movs	r1, #128	; 0x80
c0d06506:	2200      	movs	r2, #0
c0d06508:	4620      	mov	r0, r4
c0d0650a:	f7fe fccf 	bl	c0d04eac <io_seph_recv>
c0d0650e:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d06510:	2800      	cmp	r0, #0
c0d06512:	d028      	beq.n	c0d06566 <h_error_accept+0x7a>
c0d06514:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d06516:	5d71      	ldrb	r1, [r6, r5]
c0d06518:	b280      	uxth	r0, r0
c0d0651a:	4288      	cmp	r0, r1
c0d0651c:	d223      	bcs.n	c0d06566 <h_error_accept+0x7a>
c0d0651e:	f7fe fcb9 	bl	c0d04e94 <io_seph_is_status_sent>
c0d06522:	2800      	cmp	r0, #0
c0d06524:	d11f      	bne.n	c0d06566 <h_error_accept+0x7a>
c0d06526:	f7fe fc1f 	bl	c0d04d68 <os_perso_isonboarded>
c0d0652a:	28aa      	cmp	r0, #170	; 0xaa
c0d0652c:	d103      	bne.n	c0d06536 <h_error_accept+0x4a>
c0d0652e:	f7fe fc4b 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d06532:	28aa      	cmp	r0, #170	; 0xaa
c0d06534:	d117      	bne.n	c0d06566 <h_error_accept+0x7a>
c0d06536:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d06538:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d0653a:	0150      	lsls	r0, r2, #5
c0d0653c:	1808      	adds	r0, r1, r0
c0d0653e:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d06540:	2b00      	cmp	r3, #0
c0d06542:	d004      	beq.n	c0d0654e <h_error_accept+0x62>
c0d06544:	4798      	blx	r3
c0d06546:	2800      	cmp	r0, #0
c0d06548:	d007      	beq.n	c0d0655a <h_error_accept+0x6e>
c0d0654a:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d0654c:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d0654e:	2801      	cmp	r0, #1
c0d06550:	d101      	bne.n	c0d06556 <h_error_accept+0x6a>
c0d06552:	0150      	lsls	r0, r2, #5
c0d06554:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d06556:	f7fb fab5 	bl	c0d01ac4 <io_seproxyhal_display_default>
    UX_WAIT();
c0d0655a:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d0655c:	1c40      	adds	r0, r0, #1
c0d0655e:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d06560:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d06562:	2900      	cmp	r1, #0
c0d06564:	d1d7      	bne.n	c0d06516 <h_error_accept+0x2a>
c0d06566:	5d70      	ldrb	r0, [r6, r5]
c0d06568:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d0656a:	4281      	cmp	r1, r0
c0d0656c:	d3ca      	bcc.n	c0d06504 <h_error_accept+0x18>
c0d0656e:	4c0d      	ldr	r4, [pc, #52]	; (c0d065a4 <h_error_accept+0xb8>)
c0d06570:	2580      	movs	r5, #128	; 0x80
c0d06572:	2600      	movs	r6, #0
c0d06574:	4620      	mov	r0, r4
c0d06576:	4629      	mov	r1, r5
c0d06578:	4632      	mov	r2, r6
c0d0657a:	f7fe fc97 	bl	c0d04eac <io_seph_recv>
c0d0657e:	f7fb f91d 	bl	c0d017bc <io_seproxyhal_general_status>
c0d06582:	4620      	mov	r0, r4
c0d06584:	4629      	mov	r1, r5
c0d06586:	4632      	mov	r2, r6
c0d06588:	f7fe fc90 	bl	c0d04eac <io_seph_recv>
c0d0658c:	4806      	ldr	r0, [pc, #24]	; (c0d065a8 <h_error_accept+0xbc>)
c0d0658e:	2184      	movs	r1, #132	; 0x84
    *(buffer + offset + 1) = (uint8_t) (value & 0xFF);
c0d06590:	7041      	strb	r1, [r0, #1]
c0d06592:	2169      	movs	r1, #105	; 0x69
    *(buffer + offset) = (uint8_t) (value >> 8);
c0d06594:	7001      	strb	r1, [r0, #0]
c0d06596:	2020      	movs	r0, #32
c0d06598:	2102      	movs	r1, #2
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d0659a:	f7fb fb65 	bl	c0d01c68 <io_exchange>
}
c0d0659e:	bd70      	pop	{r4, r5, r6, pc}
c0d065a0:	200005f0 	.word	0x200005f0
c0d065a4:	20000202 	.word	0x20000202
c0d065a8:	200002b0 	.word	0x200002b0

c0d065ac <h_paging_init>:
void h_paging_init() {
c0d065ac:	b580      	push	{r7, lr}
    zemu_log_stack("h_paging_init");
c0d065ae:	4808      	ldr	r0, [pc, #32]	; (c0d065d0 <h_paging_init+0x24>)
c0d065b0:	4478      	add	r0, pc
c0d065b2:	f000 fd15 	bl	c0d06fe0 <zemu_log_stack>
c0d065b6:	2058      	movs	r0, #88	; 0x58
    viewdata.itemIdx = 0;
c0d065b8:	4904      	ldr	r1, [pc, #16]	; (c0d065cc <h_paging_init+0x20>)
c0d065ba:	2201      	movs	r2, #1
    viewdata.pageCount = 1;
c0d065bc:	540a      	strb	r2, [r1, r0]
c0d065be:	2055      	movs	r0, #85	; 0x55
c0d065c0:	2200      	movs	r2, #0
    viewdata.itemIdx = 0;
c0d065c2:	540a      	strb	r2, [r1, r0]
c0d065c4:	2056      	movs	r0, #86	; 0x56
c0d065c6:	22ff      	movs	r2, #255	; 0xff
    viewdata.itemCount = 0xFF;
c0d065c8:	520a      	strh	r2, [r1, r0]
}
c0d065ca:	bd80      	pop	{r7, pc}
c0d065cc:	20000594 	.word	0x20000594
c0d065d0:	00001c1b 	.word	0x00001c1b

c0d065d4 <h_paging_can_increase>:
bool h_paging_can_increase() {
c0d065d4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d065d6:	b081      	sub	sp, #4
c0d065d8:	2056      	movs	r0, #86	; 0x56
    if (viewdata.pageIdx + 1 < viewdata.pageCount) {
c0d065da:	4910      	ldr	r1, [pc, #64]	; (c0d0661c <h_paging_can_increase+0x48>)
c0d065dc:	5c0c      	ldrb	r4, [r1, r0]
c0d065de:	2055      	movs	r0, #85	; 0x55
c0d065e0:	5c0d      	ldrb	r5, [r1, r0]
c0d065e2:	480f      	ldr	r0, [pc, #60]	; (c0d06620 <h_paging_can_increase+0x4c>)
c0d065e4:	4478      	add	r0, pc
c0d065e6:	42a5      	cmp	r5, r4
c0d065e8:	4602      	mov	r2, r0
c0d065ea:	d301      	bcc.n	c0d065f0 <h_paging_can_increase+0x1c>
c0d065ec:	4a0d      	ldr	r2, [pc, #52]	; (c0d06624 <h_paging_can_increase+0x50>)
c0d065ee:	447a      	add	r2, pc
c0d065f0:	2358      	movs	r3, #88	; 0x58
c0d065f2:	5cce      	ldrb	r6, [r1, r3]
c0d065f4:	2357      	movs	r3, #87	; 0x57
c0d065f6:	5cc9      	ldrb	r1, [r1, r3]
c0d065f8:	1c4f      	adds	r7, r1, #1
c0d065fa:	42b7      	cmp	r7, r6
c0d065fc:	d300      	bcc.n	c0d06600 <h_paging_can_increase+0x2c>
c0d065fe:	4610      	mov	r0, r2
c0d06600:	f000 fcee 	bl	c0d06fe0 <zemu_log_stack>
c0d06604:	2001      	movs	r0, #1
c0d06606:	2200      	movs	r2, #0
c0d06608:	42a5      	cmp	r5, r4
c0d0660a:	4601      	mov	r1, r0
c0d0660c:	d300      	bcc.n	c0d06610 <h_paging_can_increase+0x3c>
c0d0660e:	4611      	mov	r1, r2
c0d06610:	42b7      	cmp	r7, r6
c0d06612:	d300      	bcc.n	c0d06616 <h_paging_can_increase+0x42>
c0d06614:	4610      	mov	r0, r2
c0d06616:	4308      	orrs	r0, r1
}
c0d06618:	b001      	add	sp, #4
c0d0661a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0661c:	20000594 	.word	0x20000594
c0d06620:	00001bf5 	.word	0x00001bf5
c0d06624:	00001c01 	.word	0x00001c01

c0d06628 <h_paging_increase>:
void h_paging_increase() {
c0d06628:	b510      	push	{r4, lr}
    zemu_log_stack("h_paging_increase");
c0d0662a:	480c      	ldr	r0, [pc, #48]	; (c0d0665c <h_paging_increase+0x34>)
c0d0662c:	4478      	add	r0, pc
c0d0662e:	f000 fcd7 	bl	c0d06fe0 <zemu_log_stack>
c0d06632:	2158      	movs	r1, #88	; 0x58
    if (viewdata.pageIdx + 1 < viewdata.pageCount) {
c0d06634:	4808      	ldr	r0, [pc, #32]	; (c0d06658 <h_paging_increase+0x30>)
c0d06636:	5c43      	ldrb	r3, [r0, r1]
c0d06638:	2157      	movs	r1, #87	; 0x57
c0d0663a:	5c42      	ldrb	r2, [r0, r1]
c0d0663c:	1c52      	adds	r2, r2, #1
c0d0663e:	429a      	cmp	r2, r3
c0d06640:	d308      	bcc.n	c0d06654 <h_paging_increase+0x2c>
c0d06642:	2255      	movs	r2, #85	; 0x55
c0d06644:	5c83      	ldrb	r3, [r0, r2]
c0d06646:	2456      	movs	r4, #86	; 0x56
    if (viewdata.itemCount > 0 && viewdata.itemIdx < (viewdata.itemCount - 1 + INCLUDE_ACTIONS_COUNT)) {
c0d06648:	5d04      	ldrb	r4, [r0, r4]
c0d0664a:	42a3      	cmp	r3, r4
c0d0664c:	d203      	bcs.n	c0d06656 <h_paging_increase+0x2e>
        viewdata.itemIdx++;
c0d0664e:	1c5b      	adds	r3, r3, #1
c0d06650:	5483      	strb	r3, [r0, r2]
c0d06652:	2200      	movs	r2, #0
c0d06654:	5442      	strb	r2, [r0, r1]
}
c0d06656:	bd10      	pop	{r4, pc}
c0d06658:	20000594 	.word	0x20000594
c0d0665c:	00001bdc 	.word	0x00001bdc

c0d06660 <h_paging_can_decrease>:
bool h_paging_can_decrease() {
c0d06660:	b510      	push	{r4, lr}
c0d06662:	2055      	movs	r0, #85	; 0x55
    if (viewdata.pageIdx != 0) {
c0d06664:	4908      	ldr	r1, [pc, #32]	; (c0d06688 <h_paging_can_decrease+0x28>)
c0d06666:	5c08      	ldrb	r0, [r1, r0]
c0d06668:	2257      	movs	r2, #87	; 0x57
c0d0666a:	5c8c      	ldrb	r4, [r1, r2]
c0d0666c:	4304      	orrs	r4, r0
c0d0666e:	d002      	beq.n	c0d06676 <h_paging_can_decrease+0x16>
c0d06670:	4807      	ldr	r0, [pc, #28]	; (c0d06690 <h_paging_can_decrease+0x30>)
c0d06672:	4478      	add	r0, pc
c0d06674:	e001      	b.n	c0d0667a <h_paging_can_decrease+0x1a>
c0d06676:	4805      	ldr	r0, [pc, #20]	; (c0d0668c <h_paging_can_decrease+0x2c>)
c0d06678:	4478      	add	r0, pc
c0d0667a:	f000 fcb1 	bl	c0d06fe0 <zemu_log_stack>
c0d0667e:	1e60      	subs	r0, r4, #1
c0d06680:	4184      	sbcs	r4, r0
}
c0d06682:	4620      	mov	r0, r4
c0d06684:	bd10      	pop	{r4, pc}
c0d06686:	46c0      	nop			; (mov r8, r8)
c0d06688:	20000594 	.word	0x20000594
c0d0668c:	00001bb8 	.word	0x00001bb8
c0d06690:	00001ba8 	.word	0x00001ba8

c0d06694 <h_paging_decrease>:
void h_paging_decrease() {
c0d06694:	b570      	push	{r4, r5, r6, lr}
c0d06696:	b08e      	sub	sp, #56	; 0x38
c0d06698:	2655      	movs	r6, #85	; 0x55
    snprintf(buffer, sizeof(buffer), "h_paging_decrease Idx %d", viewdata.itemIdx);
c0d0669a:	4d12      	ldr	r5, [pc, #72]	; (c0d066e4 <h_paging_decrease+0x50>)
c0d0669c:	5dab      	ldrb	r3, [r5, r6]
c0d0669e:	ac01      	add	r4, sp, #4
c0d066a0:	2132      	movs	r1, #50	; 0x32
c0d066a2:	4a11      	ldr	r2, [pc, #68]	; (c0d066e8 <h_paging_decrease+0x54>)
c0d066a4:	447a      	add	r2, pc
c0d066a6:	4620      	mov	r0, r4
c0d066a8:	f7fb fd62 	bl	c0d02170 <snprintf>
    zemu_log_stack(buffer);
c0d066ac:	4620      	mov	r0, r4
c0d066ae:	f000 fc97 	bl	c0d06fe0 <zemu_log_stack>
c0d066b2:	2457      	movs	r4, #87	; 0x57
    if (viewdata.pageIdx != 0) {
c0d066b4:	5d28      	ldrb	r0, [r5, r4]
c0d066b6:	2800      	cmp	r0, #0
c0d066b8:	d006      	beq.n	c0d066c8 <h_paging_decrease+0x34>
        viewdata.pageIdx--;
c0d066ba:	1e40      	subs	r0, r0, #1
c0d066bc:	5528      	strb	r0, [r5, r4]
        zemu_log_stack("page--");
c0d066be:	480b      	ldr	r0, [pc, #44]	; (c0d066ec <h_paging_decrease+0x58>)
c0d066c0:	4478      	add	r0, pc
c0d066c2:	f000 fc8d 	bl	c0d06fe0 <zemu_log_stack>
c0d066c6:	e00a      	b.n	c0d066de <h_paging_decrease+0x4a>
    if (viewdata.itemIdx > 0) {
c0d066c8:	5da8      	ldrb	r0, [r5, r6]
c0d066ca:	2800      	cmp	r0, #0
c0d066cc:	d007      	beq.n	c0d066de <h_paging_decrease+0x4a>
        viewdata.itemIdx--;
c0d066ce:	1e40      	subs	r0, r0, #1
c0d066d0:	55a8      	strb	r0, [r5, r6]
        zemu_log_stack("item--");
c0d066d2:	4807      	ldr	r0, [pc, #28]	; (c0d066f0 <h_paging_decrease+0x5c>)
c0d066d4:	4478      	add	r0, pc
c0d066d6:	f000 fc83 	bl	c0d06fe0 <zemu_log_stack>
c0d066da:	20ff      	movs	r0, #255	; 0xff
        viewdata.pageIdx = 255;
c0d066dc:	5528      	strb	r0, [r5, r4]
}
c0d066de:	b00e      	add	sp, #56	; 0x38
c0d066e0:	bd70      	pop	{r4, r5, r6, pc}
c0d066e2:	46c0      	nop			; (mov r8, r8)
c0d066e4:	20000594 	.word	0x20000594
c0d066e8:	00001ba5 	.word	0x00001ba5
c0d066ec:	00001ba2 	.word	0x00001ba2
c0d066f0:	00001b95 	.word	0x00001b95

c0d066f4 <h_review_action>:
void h_review_action() {
c0d066f4:	b570      	push	{r4, r5, r6, lr}
c0d066f6:	2455      	movs	r4, #85	; 0x55
    return viewdata.itemIdx == viewdata.itemCount - 1;
c0d066f8:	4d13      	ldr	r5, [pc, #76]	; (c0d06748 <h_review_action+0x54>)
c0d066fa:	5d28      	ldrb	r0, [r5, r4]
c0d066fc:	2656      	movs	r6, #86	; 0x56
c0d066fe:	5da9      	ldrb	r1, [r5, r6]
c0d06700:	1e4a      	subs	r2, r1, #1
    if( is_accept_item() ){
c0d06702:	4282      	cmp	r2, r0
c0d06704:	d106      	bne.n	c0d06714 <h_review_action+0x20>
        zemu_log_stack("action_accept");
c0d06706:	4811      	ldr	r0, [pc, #68]	; (c0d0674c <h_review_action+0x58>)
c0d06708:	4478      	add	r0, pc
c0d0670a:	f000 fc69 	bl	c0d06fe0 <zemu_log_stack>
        h_approve(1);
c0d0670e:	f7ff fe1d 	bl	c0d0634c <h_approve>
};
c0d06712:	bd70      	pop	{r4, r5, r6, pc}
    if( is_reject_item() ){
c0d06714:	4288      	cmp	r0, r1
c0d06716:	d106      	bne.n	c0d06726 <h_review_action+0x32>
        zemu_log_stack("action_reject");
c0d06718:	480d      	ldr	r0, [pc, #52]	; (c0d06750 <h_review_action+0x5c>)
c0d0671a:	4478      	add	r0, pc
c0d0671c:	f000 fc60 	bl	c0d06fe0 <zemu_log_stack>
        h_reject(1);
c0d06720:	f7ff fe7e 	bl	c0d06420 <h_reject>
};
c0d06724:	bd70      	pop	{r4, r5, r6, pc}
    zemu_log_stack("quick accept");
c0d06726:	480b      	ldr	r0, [pc, #44]	; (c0d06754 <h_review_action+0x60>)
c0d06728:	4478      	add	r0, pc
c0d0672a:	f000 fc59 	bl	c0d06fe0 <zemu_log_stack>
    if (app_mode_expert()) {
c0d0672e:	f7fa faf1 	bl	c0d00d14 <app_mode_expert>
c0d06732:	2800      	cmp	r0, #0
c0d06734:	d007      	beq.n	c0d06746 <h_review_action+0x52>
c0d06736:	2057      	movs	r0, #87	; 0x57
c0d06738:	2100      	movs	r1, #0
    viewdata.pageIdx = 0;
c0d0673a:	5429      	strb	r1, [r5, r0]
    viewdata.itemIdx = viewdata.itemCount - 1;
c0d0673c:	5da8      	ldrb	r0, [r5, r6]
c0d0673e:	1e40      	subs	r0, r0, #1
c0d06740:	5528      	strb	r0, [r5, r4]
        h_review_update();
c0d06742:	f000 f92d 	bl	c0d069a0 <h_review_update>
};
c0d06746:	bd70      	pop	{r4, r5, r6, pc}
c0d06748:	20000594 	.word	0x20000594
c0d0674c:	00001b68 	.word	0x00001b68
c0d06750:	00001b64 	.word	0x00001b64
c0d06754:	00001b64 	.word	0x00001b64

c0d06758 <h_review_update_data>:
zxerr_t h_review_update_data() {
c0d06758:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0675a:	b08f      	sub	sp, #60	; 0x3c
    if (viewdata.viewfuncGetNumItems == NULL) {
c0d0675c:	4c53      	ldr	r4, [pc, #332]	; (c0d068ac <h_review_update_data+0x154>)
c0d0675e:	6ce0      	ldr	r0, [r4, #76]	; 0x4c
c0d06760:	2800      	cmp	r0, #0
c0d06762:	d02a      	beq.n	c0d067ba <h_review_update_data+0x62>
c0d06764:	2755      	movs	r7, #85	; 0x55
    snprintf(buffer, sizeof(buffer), "update Idx %d/%d", viewdata.itemIdx, viewdata.pageIdx);
c0d06766:	5de3      	ldrb	r3, [r4, r7]
c0d06768:	2657      	movs	r6, #87	; 0x57
c0d0676a:	5da0      	ldrb	r0, [r4, r6]
c0d0676c:	9000      	str	r0, [sp, #0]
c0d0676e:	ad0a      	add	r5, sp, #40	; 0x28
c0d06770:	2114      	movs	r1, #20
c0d06772:	4a53      	ldr	r2, [pc, #332]	; (c0d068c0 <h_review_update_data+0x168>)
c0d06774:	447a      	add	r2, pc
c0d06776:	4628      	mov	r0, r5
c0d06778:	f7fb fcfa 	bl	c0d02170 <snprintf>
    zemu_log_stack(buffer);
c0d0677c:	4628      	mov	r0, r5
c0d0677e:	f000 fc2f 	bl	c0d06fe0 <zemu_log_stack>
c0d06782:	2058      	movs	r0, #88	; 0x58
c0d06784:	2101      	movs	r1, #1
c0d06786:	9009      	str	r0, [sp, #36]	; 0x24
c0d06788:	9104      	str	r1, [sp, #16]
    viewdata.pageCount = 1;
c0d0678a:	5421      	strb	r1, [r4, r0]
c0d0678c:	9708      	str	r7, [sp, #32]
    return viewdata.itemIdx == viewdata.itemCount - 1;
c0d0678e:	5de0      	ldrb	r0, [r4, r7]
c0d06790:	2156      	movs	r1, #86	; 0x56
c0d06792:	9103      	str	r1, [sp, #12]
c0d06794:	5c61      	ldrb	r1, [r4, r1]
c0d06796:	1e4a      	subs	r2, r1, #1
    if( is_accept_item() ){
c0d06798:	4282      	cmp	r2, r0
c0d0679a:	d114      	bne.n	c0d067c6 <h_review_update_data+0x6e>
c0d0679c:	2045      	movs	r0, #69	; 0x45
        snprintf(viewdata.value, MAX_CHARS_PER_VALUE1_LINE, "%s", APPROVE_LABEL);
c0d0679e:	8320      	strh	r0, [r4, #24]
c0d067a0:	4843      	ldr	r0, [pc, #268]	; (c0d068b0 <h_review_update_data+0x158>)
c0d067a2:	82e0      	strh	r0, [r4, #22]
c0d067a4:	4843      	ldr	r0, [pc, #268]	; (c0d068b4 <h_review_update_data+0x15c>)
c0d067a6:	82a0      	strh	r0, [r4, #20]
c0d067a8:	4843      	ldr	r0, [pc, #268]	; (c0d068b8 <h_review_update_data+0x160>)
c0d067aa:	8260      	strh	r0, [r4, #18]
c0d067ac:	2500      	movs	r5, #0
        snprintf(viewdata.key, MAX_CHARS_PER_KEY_LINE, "%s","");
c0d067ae:	7025      	strb	r5, [r4, #0]
        splitValueField();
c0d067b0:	f000 f9dc 	bl	c0d06b6c <splitValueField>
        zemu_log_stack("show_accept_action - accept item");
c0d067b4:	4843      	ldr	r0, [pc, #268]	; (c0d068c4 <h_review_update_data+0x16c>)
c0d067b6:	4478      	add	r0, pc
c0d067b8:	e014      	b.n	c0d067e4 <h_review_update_data+0x8c>
        zemu_log_stack("h_review_update_data - GetNumItems==NULL");
c0d067ba:	4840      	ldr	r0, [pc, #256]	; (c0d068bc <h_review_update_data+0x164>)
c0d067bc:	4478      	add	r0, pc
c0d067be:	f000 fc0f 	bl	c0d06fe0 <zemu_log_stack>
c0d067c2:	2005      	movs	r0, #5
c0d067c4:	e012      	b.n	c0d067ec <h_review_update_data+0x94>
    if( is_reject_item() ){
c0d067c6:	4288      	cmp	r0, r1
c0d067c8:	d112      	bne.n	c0d067f0 <h_review_update_data+0x98>
c0d067ca:	2500      	movs	r5, #0
        snprintf(viewdata.key, MAX_CHARS_PER_KEY_LINE, "%s", "");
c0d067cc:	7025      	strb	r5, [r4, #0]
        snprintf(viewdata.value, MAX_CHARS_PER_VALUE1_LINE, "%s", REJECT_LABEL);
c0d067ce:	4620      	mov	r0, r4
c0d067d0:	3012      	adds	r0, #18
c0d067d2:	493e      	ldr	r1, [pc, #248]	; (c0d068cc <h_review_update_data+0x174>)
c0d067d4:	4479      	add	r1, pc
c0d067d6:	2207      	movs	r2, #7
c0d067d8:	f000 fd9c 	bl	c0d07314 <__aeabi_memcpy>
        splitValueField();
c0d067dc:	f000 f9c6 	bl	c0d06b6c <splitValueField>
        zemu_log_stack("show_reject_action - reject item");
c0d067e0:	483b      	ldr	r0, [pc, #236]	; (c0d068d0 <h_review_update_data+0x178>)
c0d067e2:	4478      	add	r0, pc
c0d067e4:	f000 fbfc 	bl	c0d06fe0 <zemu_log_stack>
c0d067e8:	55a5      	strb	r5, [r4, r6]
c0d067ea:	2003      	movs	r0, #3
}
c0d067ec:	b00f      	add	sp, #60	; 0x3c
c0d067ee:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d067f0:	9607      	str	r6, [sp, #28]
c0d067f2:	9f09      	ldr	r7, [sp, #36]	; 0x24
        viewdata.pageCount = 1;
c0d067f4:	9804      	ldr	r0, [sp, #16]
c0d067f6:	55e0      	strb	r0, [r4, r7]
        CHECK_ZXERR(viewdata.viewfuncGetNumItems(&viewdata.itemCount))
c0d067f8:	6ce1      	ldr	r1, [r4, #76]	; 0x4c
c0d067fa:	4620      	mov	r0, r4
c0d067fc:	3056      	adds	r0, #86	; 0x56
c0d067fe:	4788      	blx	r1
c0d06800:	2803      	cmp	r0, #3
c0d06802:	d1f3      	bne.n	c0d067ec <h_review_update_data+0x94>
        CHECK_ZXERR(viewdata.viewfuncGetItem(
c0d06804:	9808      	ldr	r0, [sp, #32]
c0d06806:	5620      	ldrsb	r0, [r4, r0]
c0d06808:	6ca1      	ldr	r1, [r4, #72]	; 0x48
c0d0680a:	9106      	str	r1, [sp, #24]
c0d0680c:	4626      	mov	r6, r4
c0d0680e:	3658      	adds	r6, #88	; 0x58
c0d06810:	2100      	movs	r1, #0
c0d06812:	2223      	movs	r2, #35	; 0x23
c0d06814:	9205      	str	r2, [sp, #20]
c0d06816:	9200      	str	r2, [sp, #0]
c0d06818:	9101      	str	r1, [sp, #4]
c0d0681a:	9602      	str	r6, [sp, #8]
c0d0681c:	4625      	mov	r5, r4
c0d0681e:	3512      	adds	r5, #18
c0d06820:	2212      	movs	r2, #18
c0d06822:	4621      	mov	r1, r4
c0d06824:	462b      	mov	r3, r5
c0d06826:	4627      	mov	r7, r4
c0d06828:	9c06      	ldr	r4, [sp, #24]
c0d0682a:	47a0      	blx	r4
c0d0682c:	2803      	cmp	r0, #3
c0d0682e:	d1dd      	bne.n	c0d067ec <h_review_update_data+0x94>
c0d06830:	9807      	ldr	r0, [sp, #28]
c0d06832:	5c39      	ldrb	r1, [r7, r0]
        if (viewdata.pageCount != 0 && viewdata.pageIdx > viewdata.pageCount) {
c0d06834:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d06836:	5c38      	ldrb	r0, [r7, r0]
c0d06838:	2800      	cmp	r0, #0
c0d0683a:	463c      	mov	r4, r7
c0d0683c:	d004      	beq.n	c0d06848 <h_review_update_data+0xf0>
c0d0683e:	4281      	cmp	r1, r0
c0d06840:	d902      	bls.n	c0d06848 <h_review_update_data+0xf0>
            viewdata.pageIdx = viewdata.pageCount - 1;
c0d06842:	1e41      	subs	r1, r0, #1
c0d06844:	9807      	ldr	r0, [sp, #28]
c0d06846:	5421      	strb	r1, [r4, r0]
        CHECK_ZXERR(viewdata.viewfuncGetItem(
c0d06848:	9808      	ldr	r0, [sp, #32]
c0d0684a:	5620      	ldrsb	r0, [r4, r0]
c0d0684c:	6ca7      	ldr	r7, [r4, #72]	; 0x48
c0d0684e:	b2c9      	uxtb	r1, r1
c0d06850:	9a05      	ldr	r2, [sp, #20]
c0d06852:	9200      	str	r2, [sp, #0]
c0d06854:	9101      	str	r1, [sp, #4]
c0d06856:	9602      	str	r6, [sp, #8]
c0d06858:	2612      	movs	r6, #18
c0d0685a:	4621      	mov	r1, r4
c0d0685c:	4632      	mov	r2, r6
c0d0685e:	462b      	mov	r3, r5
c0d06860:	47b8      	blx	r7
c0d06862:	2803      	cmp	r0, #3
c0d06864:	d1c2      	bne.n	c0d067ec <h_review_update_data+0x94>
c0d06866:	9903      	ldr	r1, [sp, #12]
        viewdata.itemCount++;
c0d06868:	5c60      	ldrb	r0, [r4, r1]
c0d0686a:	1c40      	adds	r0, r0, #1
c0d0686c:	5460      	strb	r0, [r4, r1]
c0d0686e:	9f09      	ldr	r7, [sp, #36]	; 0x24
        if (viewdata.pageCount > 1) {
c0d06870:	5de5      	ldrb	r5, [r4, r7]
c0d06872:	2d02      	cmp	r5, #2
c0d06874:	d310      	bcc.n	c0d06898 <h_review_update_data+0x140>
            uint8_t keyLen = strlen(viewdata.key);
c0d06876:	4620      	mov	r0, r4
c0d06878:	f000 feec 	bl	c0d07654 <strlen>
            if (keyLen < MAX_CHARS_PER_KEY_LINE) {
c0d0687c:	b2c1      	uxtb	r1, r0
c0d0687e:	2911      	cmp	r1, #17
c0d06880:	d811      	bhi.n	c0d068a6 <h_review_update_data+0x14e>
                         viewdata.pageIdx + 1,
c0d06882:	9807      	ldr	r0, [sp, #28]
c0d06884:	5c22      	ldrb	r2, [r4, r0]
                snprintf(viewdata.key + keyLen,
c0d06886:	9500      	str	r5, [sp, #0]
c0d06888:	1860      	adds	r0, r4, r1
                         MAX_CHARS_PER_KEY_LINE - keyLen,
c0d0688a:	1a71      	subs	r1, r6, r1
                         viewdata.pageIdx + 1,
c0d0688c:	1c53      	adds	r3, r2, #1
                snprintf(viewdata.key + keyLen,
c0d0688e:	4a0e      	ldr	r2, [pc, #56]	; (c0d068c8 <h_review_update_data+0x170>)
c0d06890:	447a      	add	r2, pc
c0d06892:	f7fb fc6d 	bl	c0d02170 <snprintf>
        if (viewdata.pageCount == 0) {
c0d06896:	5de5      	ldrb	r5, [r4, r7]
c0d06898:	2d00      	cmp	r5, #0
c0d0689a:	d104      	bne.n	c0d068a6 <h_review_update_data+0x14e>
            h_paging_increase();
c0d0689c:	f7ff fec4 	bl	c0d06628 <h_paging_increase>
    } while (viewdata.pageCount == 0);
c0d068a0:	5de0      	ldrb	r0, [r4, r7]
c0d068a2:	2800      	cmp	r0, #0
c0d068a4:	d0a6      	beq.n	c0d067f4 <h_review_update_data+0x9c>
    splitValueField();
c0d068a6:	f000 f961 	bl	c0d06b6c <splitValueField>
c0d068aa:	e79e      	b.n	c0d067ea <h_review_update_data+0x92>
c0d068ac:	20000594 	.word	0x20000594
c0d068b0:	0000564f 	.word	0x0000564f
c0d068b4:	00005250 	.word	0x00005250
c0d068b8:	00005041 	.word	0x00005041
c0d068bc:	00001add 	.word	0x00001add
c0d068c0:	00001b4e 	.word	0x00001b4e
c0d068c4:	00001b1d 	.word	0x00001b1d
c0d068c8:	00001a8c 	.word	0x00001a8c
c0d068cc:	00001b20 	.word	0x00001b20
c0d068d0:	00001b19 	.word	0x00001b19

c0d068d4 <view_init>:
void view_init(void) {
c0d068d4:	b580      	push	{r7, lr}
    UX_INIT();
c0d068d6:	4805      	ldr	r0, [pc, #20]	; (c0d068ec <view_init+0x18>)
c0d068d8:	2150      	movs	r1, #80	; 0x50
c0d068da:	f000 fd15 	bl	c0d07308 <__aeabi_memclr>
c0d068de:	f7ff fcf5 	bl	c0d062cc <ux_stack_push>
c0d068e2:	2054      	movs	r0, #84	; 0x54
    viewdata.secret_click_count = 0;
c0d068e4:	4902      	ldr	r1, [pc, #8]	; (c0d068f0 <view_init+0x1c>)
c0d068e6:	2200      	movs	r2, #0
c0d068e8:	540a      	strb	r2, [r1, r0]
}
c0d068ea:	bd80      	pop	{r7, pc}
c0d068ec:	200005f0 	.word	0x200005f0
c0d068f0:	20000594 	.word	0x20000594

c0d068f4 <view_review_init>:
}

void view_review_init(viewfunc_getItem_t viewfuncGetItem,
                      viewfunc_getNumItems_t viewfuncGetNumItems,
                      viewfunc_accept_t viewfuncAccept) {
    viewdata.viewfuncGetItem = viewfuncGetItem;
c0d068f4:	4b01      	ldr	r3, [pc, #4]	; (c0d068fc <view_review_init+0x8>)
c0d068f6:	3348      	adds	r3, #72	; 0x48
c0d068f8:	c307      	stmia	r3!, {r0, r1, r2}
    viewdata.viewfuncGetNumItems = viewfuncGetNumItems;
    viewdata.viewfuncAccept = viewfuncAccept;
}
c0d068fa:	4770      	bx	lr
c0d068fc:	20000594 	.word	0x20000594

c0d06900 <view_review_show>:

void view_review_show() {
c0d06900:	b580      	push	{r7, lr}
    view_review_show_impl();
c0d06902:	f000 fa31 	bl	c0d06d68 <view_review_show_impl>
}
c0d06906:	bd80      	pop	{r7, pc}

c0d06908 <view_error_show>:

void view_error_show() {
c0d06908:	b510      	push	{r4, lr}
    snprintf(viewdata.key, MAX_CHARS_PER_KEY_LINE, "ERROR");
c0d0690a:	4c09      	ldr	r4, [pc, #36]	; (c0d06930 <view_error_show+0x28>)
c0d0690c:	4909      	ldr	r1, [pc, #36]	; (c0d06934 <view_error_show+0x2c>)
c0d0690e:	4479      	add	r1, pc
c0d06910:	2206      	movs	r2, #6
c0d06912:	4620      	mov	r0, r4
c0d06914:	f000 fcfe 	bl	c0d07314 <__aeabi_memcpy>
    snprintf(viewdata.value, MAX_CHARS_PER_VALUE1_LINE, "SHOWING DATA");
c0d06918:	3412      	adds	r4, #18
c0d0691a:	4907      	ldr	r1, [pc, #28]	; (c0d06938 <view_error_show+0x30>)
c0d0691c:	4479      	add	r1, pc
c0d0691e:	220d      	movs	r2, #13
c0d06920:	4620      	mov	r0, r4
c0d06922:	f000 fcf7 	bl	c0d07314 <__aeabi_memcpy>
    splitValueField();
c0d06926:	f000 f921 	bl	c0d06b6c <splitValueField>
    view_error_show_impl();
c0d0692a:	f000 f985 	bl	c0d06c38 <view_error_show_impl>
}
c0d0692e:	bd10      	pop	{r4, pc}
c0d06930:	20000594 	.word	0x20000594
c0d06934:	00000e04 	.word	0x00000e04
c0d06938:	00001a0c 	.word	0x00001a0c

c0d0693c <os_exit>:
void h_secret_click();
#endif

ux_state_t ux;

void os_exit(uint32_t id) {
c0d0693c:	b580      	push	{r7, lr}
c0d0693e:	2000      	movs	r0, #0
    (void)id;
    os_sched_exit(0);
c0d06940:	f7fe fa8e 	bl	c0d04e60 <os_sched_exit>
}
c0d06944:	bd80      	pop	{r7, pc}
	...

c0d06948 <view_prepro>:
            break;
    }
    return 0;
}

const bagl_element_t *view_prepro(const bagl_element_t *element) {
c0d06948:	b5b0      	push	{r4, r5, r7, lr}
c0d0694a:	4604      	mov	r4, r0
    switch (element->component.userid) {
c0d0694c:	7840      	ldrb	r0, [r0, #1]
c0d0694e:	2871      	cmp	r0, #113	; 0x71
c0d06950:	d00f      	beq.n	c0d06972 <view_prepro+0x2a>
c0d06952:	2811      	cmp	r0, #17
c0d06954:	d004      	beq.n	c0d06960 <view_prepro+0x18>
c0d06956:	2810      	cmp	r0, #16
c0d06958:	d11c      	bne.n	c0d06994 <view_prepro+0x4c>
        case UIID_ICONLEFT:
            if (!h_paging_can_decrease()){
c0d0695a:	f7ff fe81 	bl	c0d06660 <h_paging_can_decrease>
c0d0695e:	e001      	b.n	c0d06964 <view_prepro+0x1c>
                return NULL;
            }
            UX_CALLBACK_SET_INTERVAL(2000);
            break;
        case UIID_ICONRIGHT:
            if (!h_paging_can_increase()){
c0d06960:	f7ff fe38 	bl	c0d065d4 <h_paging_can_increase>
c0d06964:	2800      	cmp	r0, #0
c0d06966:	d002      	beq.n	c0d0696e <view_prepro+0x26>
c0d06968:	207d      	movs	r0, #125	; 0x7d
c0d0696a:	0100      	lsls	r0, r0, #4
c0d0696c:	e010      	b.n	c0d06990 <view_prepro+0x48>
c0d0696e:	2400      	movs	r4, #0
c0d06970:	e010      	b.n	c0d06994 <view_prepro+0x4c>
c0d06972:	2107      	movs	r1, #7
                return NULL;
            }
            UX_CALLBACK_SET_INTERVAL(2000);
            break;
        case UIID_LABELSCROLL:
            UX_CALLBACK_SET_INTERVAL(
c0d06974:	4620      	mov	r0, r4
c0d06976:	f7fb f8ed 	bl	c0d01b54 <bagl_label_roundtrip_duration_ms>
c0d0697a:	217d      	movs	r1, #125	; 0x7d
c0d0697c:	00cd      	lsls	r5, r1, #3
c0d0697e:	1941      	adds	r1, r0, r5
c0d06980:	4805      	ldr	r0, [pc, #20]	; (c0d06998 <view_prepro+0x50>)
c0d06982:	4281      	cmp	r1, r0
c0d06984:	d304      	bcc.n	c0d06990 <view_prepro+0x48>
c0d06986:	2107      	movs	r1, #7
c0d06988:	4620      	mov	r0, r4
c0d0698a:	f7fb f8e3 	bl	c0d01b54 <bagl_label_roundtrip_duration_ms>
c0d0698e:	1940      	adds	r0, r0, r5
c0d06990:	4902      	ldr	r1, [pc, #8]	; (c0d0699c <view_prepro+0x54>)
c0d06992:	63c8      	str	r0, [r1, #60]	; 0x3c
                MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7))
            );
            break;
    }
    return element;
}
c0d06994:	4620      	mov	r0, r4
c0d06996:	bdb0      	pop	{r4, r5, r7, pc}
c0d06998:	00000bb8 	.word	0x00000bb8
c0d0699c:	200005f0 	.word	0x200005f0

c0d069a0 <h_review_update>:
            return NULL;
    }
    return element;
}

void h_review_update() {
c0d069a0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d069a2:	b081      	sub	sp, #4
    zxerr_t err = h_review_update_data();
c0d069a4:	f7ff fed8 	bl	c0d06758 <h_review_update_data>
    switch(err) {
c0d069a8:	2803      	cmp	r0, #3
c0d069aa:	d157      	bne.n	c0d06a5c <h_review_update+0xbc>
c0d069ac:	212c      	movs	r1, #44	; 0x2c
        case zxerr_ok:
            UX_DISPLAY(view_review, view_prepro);
c0d069ae:	9100      	str	r1, [sp, #0]
c0d069b0:	4f52      	ldr	r7, [pc, #328]	; (c0d06afc <h_review_update+0x15c>)
c0d069b2:	2006      	movs	r0, #6
c0d069b4:	5478      	strb	r0, [r7, r1]
c0d069b6:	2044      	movs	r0, #68	; 0x44
c0d069b8:	2103      	movs	r1, #3
c0d069ba:	5439      	strb	r1, [r7, r0]
c0d069bc:	4851      	ldr	r0, [pc, #324]	; (c0d06b04 <h_review_update+0x164>)
c0d069be:	4478      	add	r0, pc
c0d069c0:	4951      	ldr	r1, [pc, #324]	; (c0d06b08 <h_review_update+0x168>)
c0d069c2:	4479      	add	r1, pc
c0d069c4:	62b9      	str	r1, [r7, #40]	; 0x28
c0d069c6:	4951      	ldr	r1, [pc, #324]	; (c0d06b0c <h_review_update+0x16c>)
c0d069c8:	4479      	add	r1, pc
c0d069ca:	6339      	str	r1, [r7, #48]	; 0x30
c0d069cc:	6378      	str	r0, [r7, #52]	; 0x34
c0d069ce:	463c      	mov	r4, r7
c0d069d0:	3444      	adds	r4, #68	; 0x44
c0d069d2:	2600      	movs	r6, #0
c0d069d4:	6066      	str	r6, [r4, #4]
c0d069d6:	4620      	mov	r0, r4
c0d069d8:	f7fe fa04 	bl	c0d04de4 <os_ux>
c0d069dc:	2504      	movs	r5, #4
c0d069de:	4628      	mov	r0, r5
c0d069e0:	f7fe fa8c 	bl	c0d04efc <os_sched_last_status>
c0d069e4:	6060      	str	r0, [r4, #4]
c0d069e6:	f7fb f813 	bl	c0d01a10 <io_seproxyhal_init_ux>
c0d069ea:	f7fb f813 	bl	c0d01a14 <io_seproxyhal_init_button>
c0d069ee:	84fe      	strh	r6, [r7, #38]	; 0x26
c0d069f0:	4628      	mov	r0, r5
c0d069f2:	f7fe fa83 	bl	c0d04efc <os_sched_last_status>
c0d069f6:	6060      	str	r0, [r4, #4]
c0d069f8:	9c00      	ldr	r4, [sp, #0]
c0d069fa:	2800      	cmp	r0, #0
c0d069fc:	d07b      	beq.n	c0d06af6 <h_review_update+0x156>
c0d069fe:	2897      	cmp	r0, #151	; 0x97
c0d06a00:	d079      	beq.n	c0d06af6 <h_review_update+0x156>
c0d06a02:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d06a04:	2800      	cmp	r0, #0
c0d06a06:	d076      	beq.n	c0d06af6 <h_review_update+0x156>
c0d06a08:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d06a0a:	5d39      	ldrb	r1, [r7, r4]
c0d06a0c:	b280      	uxth	r0, r0
c0d06a0e:	4288      	cmp	r0, r1
c0d06a10:	d271      	bcs.n	c0d06af6 <h_review_update+0x156>
c0d06a12:	f7fe fa3f 	bl	c0d04e94 <io_seph_is_status_sent>
c0d06a16:	2800      	cmp	r0, #0
c0d06a18:	d16d      	bne.n	c0d06af6 <h_review_update+0x156>
c0d06a1a:	f7fe f9a5 	bl	c0d04d68 <os_perso_isonboarded>
c0d06a1e:	28aa      	cmp	r0, #170	; 0xaa
c0d06a20:	d103      	bne.n	c0d06a2a <h_review_update+0x8a>
c0d06a22:	f7fe f9d1 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d06a26:	28aa      	cmp	r0, #170	; 0xaa
c0d06a28:	d165      	bne.n	c0d06af6 <h_review_update+0x156>
c0d06a2a:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d06a2c:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
c0d06a2e:	0150      	lsls	r0, r2, #5
c0d06a30:	1808      	adds	r0, r1, r0
c0d06a32:	6b3b      	ldr	r3, [r7, #48]	; 0x30
c0d06a34:	2b00      	cmp	r3, #0
c0d06a36:	d004      	beq.n	c0d06a42 <h_review_update+0xa2>
c0d06a38:	4798      	blx	r3
c0d06a3a:	2800      	cmp	r0, #0
c0d06a3c:	d007      	beq.n	c0d06a4e <h_review_update+0xae>
c0d06a3e:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
c0d06a40:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d06a42:	2801      	cmp	r0, #1
c0d06a44:	d101      	bne.n	c0d06a4a <h_review_update+0xaa>
c0d06a46:	0150      	lsls	r0, r2, #5
c0d06a48:	1808      	adds	r0, r1, r0
c0d06a4a:	f7ff fce5 	bl	c0d06418 <io_seproxyhal_display>
c0d06a4e:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d06a50:	1c40      	adds	r0, r0, #1
c0d06a52:	84f8      	strh	r0, [r7, #38]	; 0x26
c0d06a54:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d06a56:	2900      	cmp	r1, #0
c0d06a58:	d1d7      	bne.n	c0d06a0a <h_review_update+0x6a>
c0d06a5a:	e04c      	b.n	c0d06af6 <h_review_update+0x156>
            break;
        default:
            view_error_show();
c0d06a5c:	f7ff ff54 	bl	c0d06908 <view_error_show>
c0d06a60:	252c      	movs	r5, #44	; 0x2c
            UX_WAIT();
c0d06a62:	4e26      	ldr	r6, [pc, #152]	; (c0d06afc <h_review_update+0x15c>)
c0d06a64:	5d70      	ldrb	r0, [r6, r5]
c0d06a66:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d06a68:	4281      	cmp	r1, r0
c0d06a6a:	d235      	bcs.n	c0d06ad8 <h_review_update+0x138>
c0d06a6c:	4c24      	ldr	r4, [pc, #144]	; (c0d06b00 <h_review_update+0x160>)
c0d06a6e:	2180      	movs	r1, #128	; 0x80
c0d06a70:	2200      	movs	r2, #0
c0d06a72:	4620      	mov	r0, r4
c0d06a74:	f7fe fa1a 	bl	c0d04eac <io_seph_recv>
c0d06a78:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d06a7a:	2800      	cmp	r0, #0
c0d06a7c:	d028      	beq.n	c0d06ad0 <h_review_update+0x130>
c0d06a7e:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d06a80:	5d71      	ldrb	r1, [r6, r5]
c0d06a82:	b280      	uxth	r0, r0
c0d06a84:	4288      	cmp	r0, r1
c0d06a86:	d223      	bcs.n	c0d06ad0 <h_review_update+0x130>
c0d06a88:	f7fe fa04 	bl	c0d04e94 <io_seph_is_status_sent>
c0d06a8c:	2800      	cmp	r0, #0
c0d06a8e:	d11f      	bne.n	c0d06ad0 <h_review_update+0x130>
c0d06a90:	f7fe f96a 	bl	c0d04d68 <os_perso_isonboarded>
c0d06a94:	28aa      	cmp	r0, #170	; 0xaa
c0d06a96:	d103      	bne.n	c0d06aa0 <h_review_update+0x100>
c0d06a98:	f7fe f996 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d06a9c:	28aa      	cmp	r0, #170	; 0xaa
c0d06a9e:	d117      	bne.n	c0d06ad0 <h_review_update+0x130>
c0d06aa0:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d06aa2:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d06aa4:	0150      	lsls	r0, r2, #5
c0d06aa6:	1808      	adds	r0, r1, r0
c0d06aa8:	6b33      	ldr	r3, [r6, #48]	; 0x30
c0d06aaa:	2b00      	cmp	r3, #0
c0d06aac:	d004      	beq.n	c0d06ab8 <h_review_update+0x118>
c0d06aae:	4798      	blx	r3
c0d06ab0:	2800      	cmp	r0, #0
c0d06ab2:	d007      	beq.n	c0d06ac4 <h_review_update+0x124>
c0d06ab4:	8cf2      	ldrh	r2, [r6, #38]	; 0x26
c0d06ab6:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d06ab8:	2801      	cmp	r0, #1
c0d06aba:	d101      	bne.n	c0d06ac0 <h_review_update+0x120>
c0d06abc:	0150      	lsls	r0, r2, #5
c0d06abe:	1808      	adds	r0, r1, r0
c0d06ac0:	f7ff fcaa 	bl	c0d06418 <io_seproxyhal_display>
c0d06ac4:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d06ac6:	1c40      	adds	r0, r0, #1
c0d06ac8:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d06aca:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d06acc:	2900      	cmp	r1, #0
c0d06ace:	d1d7      	bne.n	c0d06a80 <h_review_update+0xe0>
c0d06ad0:	5d70      	ldrb	r0, [r6, r5]
c0d06ad2:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d06ad4:	4281      	cmp	r1, r0
c0d06ad6:	d3ca      	bcc.n	c0d06a6e <h_review_update+0xce>
c0d06ad8:	4c09      	ldr	r4, [pc, #36]	; (c0d06b00 <h_review_update+0x160>)
c0d06ada:	2580      	movs	r5, #128	; 0x80
c0d06adc:	2600      	movs	r6, #0
c0d06ade:	4620      	mov	r0, r4
c0d06ae0:	4629      	mov	r1, r5
c0d06ae2:	4632      	mov	r2, r6
c0d06ae4:	f7fe f9e2 	bl	c0d04eac <io_seph_recv>
c0d06ae8:	f7fa fe68 	bl	c0d017bc <io_seproxyhal_general_status>
c0d06aec:	4620      	mov	r0, r4
c0d06aee:	4629      	mov	r1, r5
c0d06af0:	4632      	mov	r2, r6
c0d06af2:	f7fe f9db 	bl	c0d04eac <io_seph_recv>
            break;
    }
}
c0d06af6:	b001      	add	sp, #4
c0d06af8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d06afa:	46c0      	nop			; (mov r8, r8)
c0d06afc:	200005f0 	.word	0x200005f0
c0d06b00:	20000202 	.word	0x20000202
c0d06b04:	0000014f 	.word	0x0000014f
c0d06b08:	00001ad6 	.word	0x00001ad6
c0d06b0c:	ffffff7d 	.word	0xffffff7d

c0d06b10 <view_review_button>:
static unsigned int view_review_button(unsigned int button_mask, unsigned int button_mask_counter) {
c0d06b10:	b580      	push	{r7, lr}
c0d06b12:	4910      	ldr	r1, [pc, #64]	; (c0d06b54 <view_review_button+0x44>)
    switch (button_mask) {
c0d06b14:	4288      	cmp	r0, r1
c0d06b16:	d00c      	beq.n	c0d06b32 <view_review_button+0x22>
c0d06b18:	490f      	ldr	r1, [pc, #60]	; (c0d06b58 <view_review_button+0x48>)
c0d06b1a:	4288      	cmp	r0, r1
c0d06b1c:	d010      	beq.n	c0d06b40 <view_review_button+0x30>
c0d06b1e:	490f      	ldr	r1, [pc, #60]	; (c0d06b5c <view_review_button+0x4c>)
c0d06b20:	4288      	cmp	r0, r1
c0d06b22:	d115      	bne.n	c0d06b50 <view_review_button+0x40>
    h_paging_increase();
    h_review_update();
}

void h_review_button_both() {
    zemu_log_stack("h_review_button_left");
c0d06b24:	480e      	ldr	r0, [pc, #56]	; (c0d06b60 <view_review_button+0x50>)
c0d06b26:	4478      	add	r0, pc
c0d06b28:	f000 fa5a 	bl	c0d06fe0 <zemu_log_stack>
    h_review_action();
c0d06b2c:	f7ff fde2 	bl	c0d066f4 <h_review_action>
c0d06b30:	e00e      	b.n	c0d06b50 <view_review_button+0x40>
    zemu_log_stack("h_review_button_left");
c0d06b32:	480c      	ldr	r0, [pc, #48]	; (c0d06b64 <view_review_button+0x54>)
c0d06b34:	4478      	add	r0, pc
c0d06b36:	f000 fa53 	bl	c0d06fe0 <zemu_log_stack>
    h_paging_decrease();
c0d06b3a:	f7ff fdab 	bl	c0d06694 <h_paging_decrease>
c0d06b3e:	e005      	b.n	c0d06b4c <view_review_button+0x3c>
    zemu_log_stack("h_review_button_right");
c0d06b40:	4809      	ldr	r0, [pc, #36]	; (c0d06b68 <view_review_button+0x58>)
c0d06b42:	4478      	add	r0, pc
c0d06b44:	f000 fa4c 	bl	c0d06fe0 <zemu_log_stack>
    h_paging_increase();
c0d06b48:	f7ff fd6e 	bl	c0d06628 <h_paging_increase>
c0d06b4c:	f7ff ff28 	bl	c0d069a0 <h_review_update>
c0d06b50:	2000      	movs	r0, #0
    return 0;
c0d06b52:	bd80      	pop	{r7, pc}
c0d06b54:	80000001 	.word	0x80000001
c0d06b58:	80000002 	.word	0x80000002
c0d06b5c:	80000003 	.word	0x80000003
c0d06b60:	00001856 	.word	0x00001856
c0d06b64:	00001848 	.word	0x00001848
c0d06b68:	0000184f 	.word	0x0000184f

c0d06b6c <splitValueField>:
}

void splitValueField() {
c0d06b6c:	b5b0      	push	{r4, r5, r7, lr}
c0d06b6e:	2035      	movs	r0, #53	; 0x35
    print_value2("");
c0d06b70:	4c0a      	ldr	r4, [pc, #40]	; (c0d06b9c <splitValueField+0x30>)
c0d06b72:	2500      	movs	r5, #0
c0d06b74:	5425      	strb	r5, [r4, r0]
    uint16_t vlen = strlen(viewdata.value);
c0d06b76:	4620      	mov	r0, r4
c0d06b78:	3012      	adds	r0, #18
c0d06b7a:	f000 fd6b 	bl	c0d07654 <strlen>
c0d06b7e:	4908      	ldr	r1, [pc, #32]	; (c0d06ba0 <splitValueField+0x34>)
    if (vlen > MAX_CHARS_PER_VALUE2_LINE - 1) {
c0d06b80:	4001      	ands	r1, r0
c0d06b82:	2912      	cmp	r1, #18
c0d06b84:	d308      	bcc.n	c0d06b98 <splitValueField+0x2c>
        strlcpy(viewdata.value2, viewdata.value + MAX_CHARS_PER_VALUE_LINE, MAX_CHARS_PER_VALUE2_LINE);
c0d06b86:	4620      	mov	r0, r4
c0d06b88:	3035      	adds	r0, #53	; 0x35
c0d06b8a:	4621      	mov	r1, r4
c0d06b8c:	3123      	adds	r1, #35	; 0x23
c0d06b8e:	2212      	movs	r2, #18
c0d06b90:	f000 fd38 	bl	c0d07604 <strlcpy>
c0d06b94:	2023      	movs	r0, #35	; 0x23
        viewdata.value[MAX_CHARS_PER_VALUE_LINE] = 0;
c0d06b96:	5425      	strb	r5, [r4, r0]
    }
}
c0d06b98:	bdb0      	pop	{r4, r5, r7, pc}
c0d06b9a:	46c0      	nop			; (mov r8, r8)
c0d06b9c:	20000594 	.word	0x20000594
c0d06ba0:	0000fffe 	.word	0x0000fffe

c0d06ba4 <view_idle_show_impl>:
//////////////////////////
//////////////////////////
//////////////////////////
//////////////////////////

void view_idle_show_impl(uint8_t item_idx, char *statusString) {
c0d06ba4:	b5b0      	push	{r4, r5, r7, lr}
c0d06ba6:	4604      	mov	r4, r0
    if (statusString == NULL ) {
c0d06ba8:	2900      	cmp	r1, #0
c0d06baa:	d007      	beq.n	c0d06bbc <view_idle_show_impl+0x18>
c0d06bac:	460b      	mov	r3, r1
        if (app_mode_secret()) {
            snprintf(viewdata.key, MAX_CHARS_PER_VALUE_LINE, "%s", MENU_MAIN_APP_LINE2_SECRET);
        }
#endif
    } else {
        snprintf(viewdata.key, MAX_CHARS_PER_VALUE_LINE, "%s", statusString);
c0d06bae:	4819      	ldr	r0, [pc, #100]	; (c0d06c14 <view_idle_show_impl+0x70>)
c0d06bb0:	2111      	movs	r1, #17
c0d06bb2:	4a1e      	ldr	r2, [pc, #120]	; (c0d06c2c <view_idle_show_impl+0x88>)
c0d06bb4:	447a      	add	r2, pc
c0d06bb6:	f7fb fadb 	bl	c0d02170 <snprintf>
c0d06bba:	e010      	b.n	c0d06bde <view_idle_show_impl+0x3a>
        snprintf(viewdata.key, MAX_CHARS_PER_VALUE_LINE, "%s", MENU_MAIN_APP_LINE2);
c0d06bbc:	4d15      	ldr	r5, [pc, #84]	; (c0d06c14 <view_idle_show_impl+0x70>)
c0d06bbe:	4919      	ldr	r1, [pc, #100]	; (c0d06c24 <view_idle_show_impl+0x80>)
c0d06bc0:	4479      	add	r1, pc
c0d06bc2:	2206      	movs	r2, #6
c0d06bc4:	4628      	mov	r0, r5
c0d06bc6:	f000 fba5 	bl	c0d07314 <__aeabi_memcpy>
        if (app_mode_secret()) {
c0d06bca:	f7fa f8bd 	bl	c0d00d48 <app_mode_secret>
c0d06bce:	2800      	cmp	r0, #0
c0d06bd0:	d005      	beq.n	c0d06bde <view_idle_show_impl+0x3a>
            snprintf(viewdata.key, MAX_CHARS_PER_VALUE_LINE, "%s", MENU_MAIN_APP_LINE2_SECRET);
c0d06bd2:	4815      	ldr	r0, [pc, #84]	; (c0d06c28 <view_idle_show_impl+0x84>)
c0d06bd4:	4478      	add	r0, pc
c0d06bd6:	c80e      	ldmia	r0!, {r1, r2, r3}
c0d06bd8:	c50e      	stmia	r5!, {r1, r2, r3}
c0d06bda:	8800      	ldrh	r0, [r0, #0]
c0d06bdc:	8028      	strh	r0, [r5, #0]
    }
}
#endif

void h_expert_update() {
    snprintf(viewdata.value, MAX_CHARS_PER_VALUE_LINE, "disabled");
c0d06bde:	4d0d      	ldr	r5, [pc, #52]	; (c0d06c14 <view_idle_show_impl+0x70>)
c0d06be0:	4628      	mov	r0, r5
c0d06be2:	3012      	adds	r0, #18
c0d06be4:	4912      	ldr	r1, [pc, #72]	; (c0d06c30 <view_idle_show_impl+0x8c>)
c0d06be6:	4479      	add	r1, pc
c0d06be8:	2209      	movs	r2, #9
c0d06bea:	f000 fb93 	bl	c0d07314 <__aeabi_memcpy>
    if (app_mode_expert()) {
c0d06bee:	f7fa f891 	bl	c0d00d14 <app_mode_expert>
c0d06bf2:	2800      	cmp	r0, #0
c0d06bf4:	d007      	beq.n	c0d06c06 <view_idle_show_impl+0x62>
c0d06bf6:	2064      	movs	r0, #100	; 0x64
        snprintf(viewdata.value, MAX_CHARS_PER_VALUE_LINE, "enabled");
c0d06bf8:	8328      	strh	r0, [r5, #24]
c0d06bfa:	4807      	ldr	r0, [pc, #28]	; (c0d06c18 <view_idle_show_impl+0x74>)
c0d06bfc:	82e8      	strh	r0, [r5, #22]
c0d06bfe:	4807      	ldr	r0, [pc, #28]	; (c0d06c1c <view_idle_show_impl+0x78>)
c0d06c00:	82a8      	strh	r0, [r5, #20]
c0d06c02:	4807      	ldr	r0, [pc, #28]	; (c0d06c20 <view_idle_show_impl+0x7c>)
c0d06c04:	8268      	strh	r0, [r5, #18]
    UX_MENU_DISPLAY(item_idx, menu_main, NULL);
c0d06c06:	490b      	ldr	r1, [pc, #44]	; (c0d06c34 <view_idle_show_impl+0x90>)
c0d06c08:	4479      	add	r1, pc
c0d06c0a:	2200      	movs	r2, #0
c0d06c0c:	4620      	mov	r0, r4
c0d06c0e:	f7ff fac7 	bl	c0d061a0 <ux_menu_display>
}
c0d06c12:	bdb0      	pop	{r4, r5, r7, pc}
c0d06c14:	20000594 	.word	0x20000594
c0d06c18:	0000656c 	.word	0x0000656c
c0d06c1c:	00006261 	.word	0x00006261
c0d06c20:	00006e65 	.word	0x00006e65
c0d06c24:	000017e7 	.word	0x000017e7
c0d06c28:	00001984 	.word	0x00001984
c0d06c2c:	00000cd6 	.word	0x00000cd6
c0d06c30:	00001982 	.word	0x00001982
c0d06c34:	000017cc 	.word	0x000017cc

c0d06c38 <view_error_show_impl>:
void view_error_show_impl() {
c0d06c38:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d06c3a:	b081      	sub	sp, #4
c0d06c3c:	212c      	movs	r1, #44	; 0x2c
    UX_DISPLAY(view_error, view_prepro);
c0d06c3e:	9100      	str	r1, [sp, #0]
c0d06c40:	4f2b      	ldr	r7, [pc, #172]	; (c0d06cf0 <view_error_show_impl+0xb8>)
c0d06c42:	2005      	movs	r0, #5
c0d06c44:	5478      	strb	r0, [r7, r1]
c0d06c46:	2044      	movs	r0, #68	; 0x44
c0d06c48:	2103      	movs	r1, #3
c0d06c4a:	5439      	strb	r1, [r7, r0]
c0d06c4c:	4829      	ldr	r0, [pc, #164]	; (c0d06cf4 <view_error_show_impl+0xbc>)
c0d06c4e:	4478      	add	r0, pc
c0d06c50:	4929      	ldr	r1, [pc, #164]	; (c0d06cf8 <view_error_show_impl+0xc0>)
c0d06c52:	4479      	add	r1, pc
c0d06c54:	62b9      	str	r1, [r7, #40]	; 0x28
c0d06c56:	4929      	ldr	r1, [pc, #164]	; (c0d06cfc <view_error_show_impl+0xc4>)
c0d06c58:	4479      	add	r1, pc
c0d06c5a:	6339      	str	r1, [r7, #48]	; 0x30
c0d06c5c:	6378      	str	r0, [r7, #52]	; 0x34
c0d06c5e:	463c      	mov	r4, r7
c0d06c60:	3444      	adds	r4, #68	; 0x44
c0d06c62:	2600      	movs	r6, #0
c0d06c64:	6066      	str	r6, [r4, #4]
c0d06c66:	4620      	mov	r0, r4
c0d06c68:	f7fe f8bc 	bl	c0d04de4 <os_ux>
c0d06c6c:	2504      	movs	r5, #4
c0d06c6e:	4628      	mov	r0, r5
c0d06c70:	f7fe f944 	bl	c0d04efc <os_sched_last_status>
c0d06c74:	6060      	str	r0, [r4, #4]
c0d06c76:	f7fa fecb 	bl	c0d01a10 <io_seproxyhal_init_ux>
c0d06c7a:	f7fa fecb 	bl	c0d01a14 <io_seproxyhal_init_button>
c0d06c7e:	84fe      	strh	r6, [r7, #38]	; 0x26
c0d06c80:	4628      	mov	r0, r5
c0d06c82:	f7fe f93b 	bl	c0d04efc <os_sched_last_status>
c0d06c86:	6060      	str	r0, [r4, #4]
c0d06c88:	9c00      	ldr	r4, [sp, #0]
c0d06c8a:	2800      	cmp	r0, #0
c0d06c8c:	d02d      	beq.n	c0d06cea <view_error_show_impl+0xb2>
c0d06c8e:	2897      	cmp	r0, #151	; 0x97
c0d06c90:	d02b      	beq.n	c0d06cea <view_error_show_impl+0xb2>
c0d06c92:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d06c94:	2800      	cmp	r0, #0
c0d06c96:	d028      	beq.n	c0d06cea <view_error_show_impl+0xb2>
c0d06c98:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d06c9a:	5d39      	ldrb	r1, [r7, r4]
c0d06c9c:	b280      	uxth	r0, r0
c0d06c9e:	4288      	cmp	r0, r1
c0d06ca0:	d223      	bcs.n	c0d06cea <view_error_show_impl+0xb2>
c0d06ca2:	f7fe f8f7 	bl	c0d04e94 <io_seph_is_status_sent>
c0d06ca6:	2800      	cmp	r0, #0
c0d06ca8:	d11f      	bne.n	c0d06cea <view_error_show_impl+0xb2>
c0d06caa:	f7fe f85d 	bl	c0d04d68 <os_perso_isonboarded>
c0d06cae:	28aa      	cmp	r0, #170	; 0xaa
c0d06cb0:	d103      	bne.n	c0d06cba <view_error_show_impl+0x82>
c0d06cb2:	f7fe f889 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d06cb6:	28aa      	cmp	r0, #170	; 0xaa
c0d06cb8:	d117      	bne.n	c0d06cea <view_error_show_impl+0xb2>
c0d06cba:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d06cbc:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
c0d06cbe:	0150      	lsls	r0, r2, #5
c0d06cc0:	1808      	adds	r0, r1, r0
c0d06cc2:	6b3b      	ldr	r3, [r7, #48]	; 0x30
c0d06cc4:	2b00      	cmp	r3, #0
c0d06cc6:	d004      	beq.n	c0d06cd2 <view_error_show_impl+0x9a>
c0d06cc8:	4798      	blx	r3
c0d06cca:	2800      	cmp	r0, #0
c0d06ccc:	d007      	beq.n	c0d06cde <view_error_show_impl+0xa6>
c0d06cce:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
c0d06cd0:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d06cd2:	2801      	cmp	r0, #1
c0d06cd4:	d101      	bne.n	c0d06cda <view_error_show_impl+0xa2>
c0d06cd6:	0150      	lsls	r0, r2, #5
c0d06cd8:	1808      	adds	r0, r1, r0
c0d06cda:	f7ff fb9d 	bl	c0d06418 <io_seproxyhal_display>
c0d06cde:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d06ce0:	1c40      	adds	r0, r0, #1
c0d06ce2:	84f8      	strh	r0, [r7, #38]	; 0x26
c0d06ce4:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d06ce6:	2900      	cmp	r1, #0
c0d06ce8:	d1d7      	bne.n	c0d06c9a <view_error_show_impl+0x62>
}
c0d06cea:	b001      	add	sp, #4
c0d06cec:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d06cee:	46c0      	nop			; (mov r8, r8)
c0d06cf0:	200005f0 	.word	0x200005f0
c0d06cf4:	000000af 	.word	0x000000af
c0d06cf8:	00001922 	.word	0x00001922
c0d06cfc:	fffffced 	.word	0xfffffced

c0d06d00 <view_error_button>:
static unsigned int view_error_button(unsigned int button_mask, unsigned int button_mask_counter) {
c0d06d00:	b580      	push	{r7, lr}
c0d06d02:	4904      	ldr	r1, [pc, #16]	; (c0d06d14 <view_error_button+0x14>)
    switch (button_mask) {
c0d06d04:	4288      	cmp	r0, r1
c0d06d06:	d102      	bne.n	c0d06d0e <view_error_button+0xe>
c0d06d08:	2000      	movs	r0, #0
            h_error_accept(0);
c0d06d0a:	f7ff fbef 	bl	c0d064ec <h_error_accept>
c0d06d0e:	2000      	movs	r0, #0
    return 0;
c0d06d10:	bd80      	pop	{r7, pc}
c0d06d12:	46c0      	nop			; (mov r8, r8)
c0d06d14:	80000002 	.word	0x80000002

c0d06d18 <h_expert_toggle>:
void h_expert_toggle() {
c0d06d18:	b510      	push	{r4, lr}
    app_mode_set_expert(!app_mode_expert());
c0d06d1a:	f7f9 fffb 	bl	c0d00d14 <app_mode_expert>
c0d06d1e:	2401      	movs	r4, #1
c0d06d20:	4060      	eors	r0, r4
c0d06d22:	f7fa f801 	bl	c0d00d28 <app_mode_set_expert>
c0d06d26:	2100      	movs	r1, #0
    view_idle_show(1, NULL);
c0d06d28:	4620      	mov	r0, r4
c0d06d2a:	f7ff fb71 	bl	c0d06410 <view_idle_show>
}
c0d06d2e:	bd10      	pop	{r4, pc}

c0d06d30 <h_secret_click>:
void h_secret_click() {
c0d06d30:	b5b0      	push	{r4, r5, r7, lr}
c0d06d32:	b08e      	sub	sp, #56	; 0x38
c0d06d34:	2454      	movs	r4, #84	; 0x54
    viewdata.secret_click_count++;
c0d06d36:	4d0a      	ldr	r5, [pc, #40]	; (c0d06d60 <h_secret_click+0x30>)
c0d06d38:	5d28      	ldrb	r0, [r5, r4]
c0d06d3a:	1c40      	adds	r0, r0, #1
c0d06d3c:	5528      	strb	r0, [r5, r4]
    snprintf(buffer, sizeof(buffer), "secret click %d\n", viewdata.secret_click_count);
c0d06d3e:	b2c3      	uxtb	r3, r0
c0d06d40:	a801      	add	r0, sp, #4
c0d06d42:	2132      	movs	r1, #50	; 0x32
c0d06d44:	4a07      	ldr	r2, [pc, #28]	; (c0d06d64 <h_secret_click+0x34>)
c0d06d46:	447a      	add	r2, pc
c0d06d48:	f7fb fa12 	bl	c0d02170 <snprintf>
    if (viewdata.secret_click_count >= COIN_SECRET_REQUIRED_CLICKS) {
c0d06d4c:	5d28      	ldrb	r0, [r5, r4]
c0d06d4e:	280a      	cmp	r0, #10
c0d06d50:	d303      	bcc.n	c0d06d5a <h_secret_click+0x2a>
        secret_enabled();
c0d06d52:	f7fc fb89 	bl	c0d03468 <secret_enabled>
c0d06d56:	2000      	movs	r0, #0
        viewdata.secret_click_count = 0;
c0d06d58:	5528      	strb	r0, [r5, r4]
}
c0d06d5a:	b00e      	add	sp, #56	; 0x38
c0d06d5c:	bdb0      	pop	{r4, r5, r7, pc}
c0d06d5e:	46c0      	nop			; (mov r8, r8)
c0d06d60:	20000594 	.word	0x20000594
c0d06d64:	00001667 	.word	0x00001667

c0d06d68 <view_review_show_impl>:
    }
}

void view_review_show_impl() {
c0d06d68:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d06d6a:	b081      	sub	sp, #4
    zemu_log_stack("view_review_show_impl");
c0d06d6c:	4833      	ldr	r0, [pc, #204]	; (c0d06e3c <view_review_show_impl+0xd4>)
c0d06d6e:	4478      	add	r0, pc
c0d06d70:	f000 f936 	bl	c0d06fe0 <zemu_log_stack>

    h_paging_init();
c0d06d74:	f7ff fc1a 	bl	c0d065ac <h_paging_init>

    zxerr_t err = h_review_update_data();
c0d06d78:	f7ff fcee 	bl	c0d06758 <h_review_update_data>
    switch(err) {
c0d06d7c:	2803      	cmp	r0, #3
c0d06d7e:	d157      	bne.n	c0d06e30 <view_review_show_impl+0xc8>
c0d06d80:	212c      	movs	r1, #44	; 0x2c
        case zxerr_ok:
            UX_DISPLAY(view_review, view_prepro);
c0d06d82:	9100      	str	r1, [sp, #0]
c0d06d84:	4f2c      	ldr	r7, [pc, #176]	; (c0d06e38 <view_review_show_impl+0xd0>)
c0d06d86:	2006      	movs	r0, #6
c0d06d88:	5478      	strb	r0, [r7, r1]
c0d06d8a:	2044      	movs	r0, #68	; 0x44
c0d06d8c:	2103      	movs	r1, #3
c0d06d8e:	5439      	strb	r1, [r7, r0]
c0d06d90:	482b      	ldr	r0, [pc, #172]	; (c0d06e40 <view_review_show_impl+0xd8>)
c0d06d92:	4478      	add	r0, pc
c0d06d94:	492b      	ldr	r1, [pc, #172]	; (c0d06e44 <view_review_show_impl+0xdc>)
c0d06d96:	4479      	add	r1, pc
c0d06d98:	62b9      	str	r1, [r7, #40]	; 0x28
c0d06d9a:	492b      	ldr	r1, [pc, #172]	; (c0d06e48 <view_review_show_impl+0xe0>)
c0d06d9c:	4479      	add	r1, pc
c0d06d9e:	6339      	str	r1, [r7, #48]	; 0x30
c0d06da0:	6378      	str	r0, [r7, #52]	; 0x34
c0d06da2:	463c      	mov	r4, r7
c0d06da4:	3444      	adds	r4, #68	; 0x44
c0d06da6:	2600      	movs	r6, #0
c0d06da8:	6066      	str	r6, [r4, #4]
c0d06daa:	4620      	mov	r0, r4
c0d06dac:	f7fe f81a 	bl	c0d04de4 <os_ux>
c0d06db0:	2504      	movs	r5, #4
c0d06db2:	4628      	mov	r0, r5
c0d06db4:	f7fe f8a2 	bl	c0d04efc <os_sched_last_status>
c0d06db8:	6060      	str	r0, [r4, #4]
c0d06dba:	f7fa fe29 	bl	c0d01a10 <io_seproxyhal_init_ux>
c0d06dbe:	f7fa fe29 	bl	c0d01a14 <io_seproxyhal_init_button>
c0d06dc2:	84fe      	strh	r6, [r7, #38]	; 0x26
c0d06dc4:	4628      	mov	r0, r5
c0d06dc6:	f7fe f899 	bl	c0d04efc <os_sched_last_status>
c0d06dca:	6060      	str	r0, [r4, #4]
c0d06dcc:	9c00      	ldr	r4, [sp, #0]
c0d06dce:	2800      	cmp	r0, #0
c0d06dd0:	d030      	beq.n	c0d06e34 <view_review_show_impl+0xcc>
c0d06dd2:	2897      	cmp	r0, #151	; 0x97
c0d06dd4:	d02e      	beq.n	c0d06e34 <view_review_show_impl+0xcc>
c0d06dd6:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d06dd8:	2800      	cmp	r0, #0
c0d06dda:	d02b      	beq.n	c0d06e34 <view_review_show_impl+0xcc>
c0d06ddc:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d06dde:	5d39      	ldrb	r1, [r7, r4]
c0d06de0:	b280      	uxth	r0, r0
c0d06de2:	4288      	cmp	r0, r1
c0d06de4:	d226      	bcs.n	c0d06e34 <view_review_show_impl+0xcc>
c0d06de6:	f7fe f855 	bl	c0d04e94 <io_seph_is_status_sent>
c0d06dea:	2800      	cmp	r0, #0
c0d06dec:	d122      	bne.n	c0d06e34 <view_review_show_impl+0xcc>
c0d06dee:	f7fd ffbb 	bl	c0d04d68 <os_perso_isonboarded>
c0d06df2:	28aa      	cmp	r0, #170	; 0xaa
c0d06df4:	d103      	bne.n	c0d06dfe <view_review_show_impl+0x96>
c0d06df6:	f7fd ffe7 	bl	c0d04dc8 <os_global_pin_is_validated>
c0d06dfa:	28aa      	cmp	r0, #170	; 0xaa
c0d06dfc:	d11a      	bne.n	c0d06e34 <view_review_show_impl+0xcc>
c0d06dfe:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d06e00:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
c0d06e02:	0150      	lsls	r0, r2, #5
c0d06e04:	1808      	adds	r0, r1, r0
c0d06e06:	6b3b      	ldr	r3, [r7, #48]	; 0x30
c0d06e08:	2b00      	cmp	r3, #0
c0d06e0a:	d004      	beq.n	c0d06e16 <view_review_show_impl+0xae>
c0d06e0c:	4798      	blx	r3
c0d06e0e:	2800      	cmp	r0, #0
c0d06e10:	d007      	beq.n	c0d06e22 <view_review_show_impl+0xba>
c0d06e12:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
c0d06e14:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d06e16:	2801      	cmp	r0, #1
c0d06e18:	d101      	bne.n	c0d06e1e <view_review_show_impl+0xb6>
c0d06e1a:	0150      	lsls	r0, r2, #5
c0d06e1c:	1808      	adds	r0, r1, r0
c0d06e1e:	f7ff fafb 	bl	c0d06418 <io_seproxyhal_display>
c0d06e22:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d06e24:	1c40      	adds	r0, r0, #1
c0d06e26:	84f8      	strh	r0, [r7, #38]	; 0x26
c0d06e28:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d06e2a:	2900      	cmp	r1, #0
c0d06e2c:	d1d7      	bne.n	c0d06dde <view_review_show_impl+0x76>
c0d06e2e:	e001      	b.n	c0d06e34 <view_review_show_impl+0xcc>
            break;
        default:
            view_error_show();
c0d06e30:	f7ff fd6a 	bl	c0d06908 <view_error_show>
            break;
    }
}
c0d06e34:	b001      	add	sp, #4
c0d06e36:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d06e38:	200005f0 	.word	0x200005f0
c0d06e3c:	00001650 	.word	0x00001650
c0d06e40:	fffffd7b 	.word	0xfffffd7b
c0d06e44:	00001702 	.word	0x00001702
c0d06e48:	fffffba9 	.word	0xfffffba9

c0d06e4c <zb_get>:

zbuffer_t zbuffer_internal;

#define CANARY_EXPECTED 0x987def82u

zbuffer_error_e zb_get(uint8_t **buffer) {
c0d06e4c:	b510      	push	{r4, lr}
c0d06e4e:	2100      	movs	r1, #0
#if defined (TARGET_NANOS) || defined(TARGET_NANOX) || defined(TARGET_NANOS2)
    *buffer = NULL;
c0d06e50:	6001      	str	r1, [r0, #0]
    if (zbuffer_internal.size == 0 || zbuffer_internal.ptr == NULL) {
c0d06e52:	4a07      	ldr	r2, [pc, #28]	; (c0d06e70 <zb_get+0x24>)
c0d06e54:	8893      	ldrh	r3, [r2, #4]
c0d06e56:	425c      	negs	r4, r3
c0d06e58:	415c      	adcs	r4, r3
c0d06e5a:	6813      	ldr	r3, [r2, #0]
c0d06e5c:	425a      	negs	r2, r3
c0d06e5e:	415a      	adcs	r2, r3
c0d06e60:	4322      	orrs	r2, r4
c0d06e62:	d100      	bne.n	c0d06e66 <zb_get+0x1a>
c0d06e64:	4619      	mov	r1, r3
c0d06e66:	6001      	str	r1, [r0, #0]
        return zb_not_allocated;
    }
    *buffer = zbuffer_internal.ptr;
#endif
    return zb_no_error;
}
c0d06e68:	1e50      	subs	r0, r2, #1
c0d06e6a:	4182      	sbcs	r2, r0
c0d06e6c:	0050      	lsls	r0, r2, #1
c0d06e6e:	bd10      	pop	{r4, pc}
c0d06e70:	20000640 	.word	0x20000640

c0d06e74 <zb_allocate>:
#if defined (TARGET_NANOS) || defined(TARGET_NANOX) || defined(TARGET_NANOS2)
    if (size % 4 != 0) {
        size += size % 4;
    }
    zbuffer_internal.size = size;
    zbuffer_internal.ptr = (uint8_t * )(&app_stack_canary + 4);
c0d06e74:	4906      	ldr	r1, [pc, #24]	; (c0d06e90 <zb_allocate+0x1c>)
c0d06e76:	3110      	adds	r1, #16
    zbuffer_internal.size = size;
c0d06e78:	4a06      	ldr	r2, [pc, #24]	; (c0d06e94 <zb_allocate+0x20>)
    zbuffer_internal.ptr = (uint8_t * )(&app_stack_canary + 4);
c0d06e7a:	6011      	str	r1, [r2, #0]
c0d06e7c:	2303      	movs	r3, #3
    if (size % 4 != 0) {
c0d06e7e:	4003      	ands	r3, r0
c0d06e80:	1818      	adds	r0, r3, r0
    zbuffer_internal.size = size;
c0d06e82:	8090      	strh	r0, [r2, #4]

    uint32_t *zb_canary = (uint32_t * )(zbuffer_internal.ptr + zbuffer_internal.size + 4);
c0d06e84:	b280      	uxth	r0, r0
c0d06e86:	1808      	adds	r0, r1, r0
c0d06e88:	4903      	ldr	r1, [pc, #12]	; (c0d06e98 <zb_allocate+0x24>)
    *zb_canary = CANARY_EXPECTED;
c0d06e8a:	6041      	str	r1, [r0, #4]
c0d06e8c:	2000      	movs	r0, #0
#endif
    return zb_no_error;
c0d06e8e:	4770      	bx	lr
c0d06e90:	20000648 	.word	0x20000648
c0d06e94:	20000640 	.word	0x20000640
c0d06e98:	987def82 	.word	0x987def82

c0d06e9c <zb_check_canary>:
    zb_init();
#endif
    return zb_no_error;
}

zbuffer_error_e zb_check_canary() {
c0d06e9c:	b580      	push	{r7, lr}
#if defined (TARGET_NANOS) || defined(TARGET_NANOX) || defined(TARGET_NANOS2)
    CHECK_APP_CANARY();
c0d06e9e:	f000 f891 	bl	c0d06fc4 <check_app_canary>
    if (zbuffer_internal.size != 0) {
c0d06ea2:	4907      	ldr	r1, [pc, #28]	; (c0d06ec0 <zb_check_canary+0x24>)
c0d06ea4:	8888      	ldrh	r0, [r1, #4]
c0d06ea6:	2800      	cmp	r0, #0
c0d06ea8:	d007      	beq.n	c0d06eba <zb_check_canary+0x1e>
        // allocated
        uint32_t *zb_canary = (uint32_t * )(zbuffer_internal.ptr + zbuffer_internal.size + 4);
c0d06eaa:	6809      	ldr	r1, [r1, #0]
c0d06eac:	1808      	adds	r0, r1, r0
        if (*zb_canary != CANARY_EXPECTED) {
c0d06eae:	6840      	ldr	r0, [r0, #4]
c0d06eb0:	4904      	ldr	r1, [pc, #16]	; (c0d06ec4 <zb_check_canary+0x28>)
c0d06eb2:	4288      	cmp	r0, r1
c0d06eb4:	d001      	beq.n	c0d06eba <zb_check_canary+0x1e>
            handle_stack_overflow();
c0d06eb6:	f000 f881 	bl	c0d06fbc <handle_stack_overflow>
c0d06eba:	2000      	movs	r0, #0
        }
    }
#endif
    return zb_no_error;
c0d06ebc:	bd80      	pop	{r7, pc}
c0d06ebe:	46c0      	nop			; (mov r8, r8)
c0d06ec0:	20000640 	.word	0x20000640
c0d06ec4:	987def82 	.word	0x987def82

c0d06ec8 <intstr_to_fpstr_inplace>:
*  See the License for the specific language governing permissions and
*  limitations under the License.
********************************************************************************/
#include "zxformat.h"

uint8_t intstr_to_fpstr_inplace(char *number, size_t number_max_size, uint8_t decimalPlaces) {
c0d06ec8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d06eca:	b081      	sub	sp, #4
c0d06ecc:	9200      	str	r2, [sp, #0]
c0d06ece:	460f      	mov	r7, r1
c0d06ed0:	4604      	mov	r4, r0
    uint16_t numChars = strnlen(number, number_max_size);
c0d06ed2:	f000 fbed 	bl	c0d076b0 <strnlen>
c0d06ed6:	4605      	mov	r5, r0
    MEMZERO(number + numChars, number_max_size - numChars);
c0d06ed8:	b286      	uxth	r6, r0
c0d06eda:	19a0      	adds	r0, r4, r6
c0d06edc:	1bb9      	subs	r1, r7, r6
c0d06ede:	f000 fa29 	bl	c0d07334 <explicit_bzero>

    if (number_max_size < 1) {
c0d06ee2:	42b7      	cmp	r7, r6
c0d06ee4:	d930      	bls.n	c0d06f48 <intstr_to_fpstr_inplace+0x80>
    if (number_max_size <= numChars) {
        // No space to do anything
        return 0;
    }

    if (numChars == 0) {
c0d06ee6:	2e00      	cmp	r6, #0
c0d06ee8:	d001      	beq.n	c0d06eee <intstr_to_fpstr_inplace+0x26>
        numChars = 1;
    }

    // Check all are numbers
    uint16_t firstDigit = numChars;
    for (int i = 0; i < numChars; i++) {
c0d06eea:	d108      	bne.n	c0d06efe <intstr_to_fpstr_inplace+0x36>
c0d06eec:	e01e      	b.n	c0d06f2c <intstr_to_fpstr_inplace+0x64>
        snprintf(number, number_max_size, "0");
c0d06eee:	4a30      	ldr	r2, [pc, #192]	; (c0d06fb0 <intstr_to_fpstr_inplace+0xe8>)
c0d06ef0:	447a      	add	r2, pc
c0d06ef2:	4620      	mov	r0, r4
c0d06ef4:	4639      	mov	r1, r7
c0d06ef6:	f7fb f93b 	bl	c0d02170 <snprintf>
c0d06efa:	2601      	movs	r6, #1
c0d06efc:	4635      	mov	r5, r6
c0d06efe:	2000      	movs	r0, #0
c0d06f00:	4629      	mov	r1, r5
        if (number[i] < '0' || number[i] > '9') {
c0d06f02:	5c22      	ldrb	r2, [r4, r0]
c0d06f04:	4613      	mov	r3, r2
c0d06f06:	3b30      	subs	r3, #48	; 0x30
c0d06f08:	2b0a      	cmp	r3, #10
c0d06f0a:	d217      	bcs.n	c0d06f3c <intstr_to_fpstr_inplace+0x74>
            snprintf(number, number_max_size, "ERR");
            return 0;
        }
        if (number[i] != '0' && firstDigit > i) {
c0d06f0c:	2a30      	cmp	r2, #48	; 0x30
c0d06f0e:	4602      	mov	r2, r0
c0d06f10:	d100      	bne.n	c0d06f14 <intstr_to_fpstr_inplace+0x4c>
c0d06f12:	460a      	mov	r2, r1
c0d06f14:	b28b      	uxth	r3, r1
c0d06f16:	4298      	cmp	r0, r3
c0d06f18:	d300      	bcc.n	c0d06f1c <intstr_to_fpstr_inplace+0x54>
c0d06f1a:	460a      	mov	r2, r1
    for (int i = 0; i < numChars; i++) {
c0d06f1c:	1c40      	adds	r0, r0, #1
c0d06f1e:	4286      	cmp	r6, r0
c0d06f20:	4611      	mov	r1, r2
c0d06f22:	d1ee      	bne.n	c0d06f02 <intstr_to_fpstr_inplace+0x3a>
            firstDigit = i;
        }
    }

    // Trim any incorrect leading zeros
    if (firstDigit == numChars) {
c0d06f24:	b291      	uxth	r1, r2
c0d06f26:	b2a8      	uxth	r0, r5
c0d06f28:	4288      	cmp	r0, r1
c0d06f2a:	d10f      	bne.n	c0d06f4c <intstr_to_fpstr_inplace+0x84>
        snprintf(number, number_max_size, "0");
c0d06f2c:	4a22      	ldr	r2, [pc, #136]	; (c0d06fb8 <intstr_to_fpstr_inplace+0xf0>)
c0d06f2e:	447a      	add	r2, pc
c0d06f30:	4620      	mov	r0, r4
c0d06f32:	4639      	mov	r1, r7
c0d06f34:	f7fb f91c 	bl	c0d02170 <snprintf>
c0d06f38:	2501      	movs	r5, #1
c0d06f3a:	e012      	b.n	c0d06f62 <intstr_to_fpstr_inplace+0x9a>
            snprintf(number, number_max_size, "ERR");
c0d06f3c:	4a1d      	ldr	r2, [pc, #116]	; (c0d06fb4 <intstr_to_fpstr_inplace+0xec>)
c0d06f3e:	447a      	add	r2, pc
c0d06f40:	4620      	mov	r0, r4
c0d06f42:	4639      	mov	r1, r7
c0d06f44:	f7fb f914 	bl	c0d02170 <snprintf>
c0d06f48:	2500      	movs	r5, #0
c0d06f4a:	e02d      	b.n	c0d06fa8 <intstr_to_fpstr_inplace+0xe0>
c0d06f4c:	460f      	mov	r7, r1
        numChars = 1;
    } else {
        // Trim leading zeros
        MEMCPY(number, number + firstDigit, numChars - firstDigit);
c0d06f4e:	1861      	adds	r1, r4, r1
c0d06f50:	1bf2      	subs	r2, r6, r7
c0d06f52:	4620      	mov	r0, r4
c0d06f54:	f000 f9de 	bl	c0d07314 <__aeabi_memcpy>
        MEMZERO(number + numChars - firstDigit, firstDigit);
c0d06f58:	19a0      	adds	r0, r4, r6
c0d06f5a:	1bc0      	subs	r0, r0, r7
c0d06f5c:	4639      	mov	r1, r7
c0d06f5e:	f000 f9e9 	bl	c0d07334 <explicit_bzero>
c0d06f62:	9e00      	ldr	r6, [sp, #0]
    }

    // If there are no decimal places return
    if (decimalPlaces == 0) {
c0d06f64:	2e00      	cmp	r6, #0
c0d06f66:	d01f      	beq.n	c0d06fa8 <intstr_to_fpstr_inplace+0xe0>
//        abcd              < numChars = 4
//                 abcd     < shift
//        000000000abcd     < fill
//        0.00000000abcd    < add decimal point

    if (numChars < decimalPlaces + 1) {
c0d06f68:	b2aa      	uxth	r2, r5
c0d06f6a:	4296      	cmp	r6, r2
c0d06f6c:	d30f      	bcc.n	c0d06f8e <intstr_to_fpstr_inplace+0xc6>
        // Move to end
        const uint16_t padSize = decimalPlaces - numChars + 1;
c0d06f6e:	1b70      	subs	r0, r6, r5
c0d06f70:	1c40      	adds	r0, r0, #1
        MEMMOVE(number + padSize, number, numChars);
c0d06f72:	b285      	uxth	r5, r0
c0d06f74:	1960      	adds	r0, r4, r5
c0d06f76:	4621      	mov	r1, r4
c0d06f78:	f000 f9d0 	bl	c0d0731c <__aeabi_memmove>
c0d06f7c:	2230      	movs	r2, #48	; 0x30
        MEMSET(number, '0', padSize);
c0d06f7e:	4620      	mov	r0, r4
c0d06f80:	4629      	mov	r1, r5
c0d06f82:	f000 f9cf 	bl	c0d07324 <__aeabi_memset>
        numChars = strlen(number);
c0d06f86:	4620      	mov	r0, r4
c0d06f88:	f000 fb64 	bl	c0d07654 <strlen>
c0d06f8c:	4605      	mov	r5, r0
    }

    // add decimal point
    const uint16_t pointPosition = numChars - decimalPlaces;
c0d06f8e:	1ba8      	subs	r0, r5, r6
    MEMMOVE(number + pointPosition + 1, number + pointPosition, decimalPlaces);  // shift content
c0d06f90:	b285      	uxth	r5, r0
c0d06f92:	1961      	adds	r1, r4, r5
c0d06f94:	1c48      	adds	r0, r1, #1
c0d06f96:	4632      	mov	r2, r6
c0d06f98:	f000 f9c0 	bl	c0d0731c <__aeabi_memmove>
c0d06f9c:	202e      	movs	r0, #46	; 0x2e
    number[pointPosition] = '.';
c0d06f9e:	5560      	strb	r0, [r4, r5]

    numChars = strlen(number);
c0d06fa0:	4620      	mov	r0, r4
c0d06fa2:	f000 fb57 	bl	c0d07654 <strlen>
c0d06fa6:	4605      	mov	r5, r0
    return numChars;
}
c0d06fa8:	b2e8      	uxtb	r0, r5
c0d06faa:	b001      	add	sp, #4
c0d06fac:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d06fae:	46c0      	nop			; (mov r8, r8)
c0d06fb0:	00001485 	.word	0x00001485
c0d06fb4:	00000818 	.word	0x00000818
c0d06fb8:	00001447 	.word	0x00001447

c0d06fbc <handle_stack_overflow>:
    // Terminate string
    *q = 0;
    return q - ascii_only_out;
}

void handle_stack_overflow() {
c0d06fbc:	b580      	push	{r7, lr}
    zemu_log("!!!!!!!!!!!!!!!!!!!!!! CANARY TRIGGERED!!! STACK OVERFLOW DETECTED\n");
#if defined (TARGET_NANOS) || defined(TARGET_NANOX) || defined(TARGET_NANOS2)
    io_seproxyhal_se_reset();
c0d06fbe:	f7fa fe27 	bl	c0d01c10 <io_seproxyhal_se_reset>
#else
    while (1);
#endif
}
c0d06fc2:	bd80      	pop	{r7, pc}

c0d06fc4 <check_app_canary>:

void check_app_canary() {
c0d06fc4:	b580      	push	{r7, lr}
#if defined (TARGET_NANOS) || defined(TARGET_NANOX) || defined(TARGET_NANOS2)
    if (app_stack_canary != APP_STACK_CANARY_MAGIC) handle_stack_overflow();
c0d06fc6:	4804      	ldr	r0, [pc, #16]	; (c0d06fd8 <check_app_canary+0x14>)
c0d06fc8:	6800      	ldr	r0, [r0, #0]
c0d06fca:	4904      	ldr	r1, [pc, #16]	; (c0d06fdc <check_app_canary+0x18>)
c0d06fcc:	4288      	cmp	r0, r1
c0d06fce:	d001      	beq.n	c0d06fd4 <check_app_canary+0x10>
    io_seproxyhal_se_reset();
c0d06fd0:	f7fa fe1e 	bl	c0d01c10 <io_seproxyhal_se_reset>
#endif
}
c0d06fd4:	bd80      	pop	{r7, pc}
c0d06fd6:	46c0      	nop			; (mov r8, r8)
c0d06fd8:	20000648 	.word	0x20000648
c0d06fdc:	dead0031 	.word	0xdead0031

c0d06fe0 <zemu_log_stack>:
            ctx);
    zemu_log(buf);
#else
    (void)ctx;
#endif
}
c0d06fe0:	4770      	bx	lr
	...

c0d06fe4 <__udivsi3>:
c0d06fe4:	2900      	cmp	r1, #0
c0d06fe6:	d034      	beq.n	c0d07052 <.udivsi3_skip_div0_test+0x6a>

c0d06fe8 <.udivsi3_skip_div0_test>:
c0d06fe8:	2301      	movs	r3, #1
c0d06fea:	2200      	movs	r2, #0
c0d06fec:	b410      	push	{r4}
c0d06fee:	4288      	cmp	r0, r1
c0d06ff0:	d32c      	bcc.n	c0d0704c <.udivsi3_skip_div0_test+0x64>
c0d06ff2:	2401      	movs	r4, #1
c0d06ff4:	0724      	lsls	r4, r4, #28
c0d06ff6:	42a1      	cmp	r1, r4
c0d06ff8:	d204      	bcs.n	c0d07004 <.udivsi3_skip_div0_test+0x1c>
c0d06ffa:	4281      	cmp	r1, r0
c0d06ffc:	d202      	bcs.n	c0d07004 <.udivsi3_skip_div0_test+0x1c>
c0d06ffe:	0109      	lsls	r1, r1, #4
c0d07000:	011b      	lsls	r3, r3, #4
c0d07002:	e7f8      	b.n	c0d06ff6 <.udivsi3_skip_div0_test+0xe>
c0d07004:	00e4      	lsls	r4, r4, #3
c0d07006:	42a1      	cmp	r1, r4
c0d07008:	d204      	bcs.n	c0d07014 <.udivsi3_skip_div0_test+0x2c>
c0d0700a:	4281      	cmp	r1, r0
c0d0700c:	d202      	bcs.n	c0d07014 <.udivsi3_skip_div0_test+0x2c>
c0d0700e:	0049      	lsls	r1, r1, #1
c0d07010:	005b      	lsls	r3, r3, #1
c0d07012:	e7f8      	b.n	c0d07006 <.udivsi3_skip_div0_test+0x1e>
c0d07014:	4288      	cmp	r0, r1
c0d07016:	d301      	bcc.n	c0d0701c <.udivsi3_skip_div0_test+0x34>
c0d07018:	1a40      	subs	r0, r0, r1
c0d0701a:	431a      	orrs	r2, r3
c0d0701c:	084c      	lsrs	r4, r1, #1
c0d0701e:	42a0      	cmp	r0, r4
c0d07020:	d302      	bcc.n	c0d07028 <.udivsi3_skip_div0_test+0x40>
c0d07022:	1b00      	subs	r0, r0, r4
c0d07024:	085c      	lsrs	r4, r3, #1
c0d07026:	4322      	orrs	r2, r4
c0d07028:	088c      	lsrs	r4, r1, #2
c0d0702a:	42a0      	cmp	r0, r4
c0d0702c:	d302      	bcc.n	c0d07034 <.udivsi3_skip_div0_test+0x4c>
c0d0702e:	1b00      	subs	r0, r0, r4
c0d07030:	089c      	lsrs	r4, r3, #2
c0d07032:	4322      	orrs	r2, r4
c0d07034:	08cc      	lsrs	r4, r1, #3
c0d07036:	42a0      	cmp	r0, r4
c0d07038:	d302      	bcc.n	c0d07040 <.udivsi3_skip_div0_test+0x58>
c0d0703a:	1b00      	subs	r0, r0, r4
c0d0703c:	08dc      	lsrs	r4, r3, #3
c0d0703e:	4322      	orrs	r2, r4
c0d07040:	2800      	cmp	r0, #0
c0d07042:	d003      	beq.n	c0d0704c <.udivsi3_skip_div0_test+0x64>
c0d07044:	091b      	lsrs	r3, r3, #4
c0d07046:	d001      	beq.n	c0d0704c <.udivsi3_skip_div0_test+0x64>
c0d07048:	0909      	lsrs	r1, r1, #4
c0d0704a:	e7e3      	b.n	c0d07014 <.udivsi3_skip_div0_test+0x2c>
c0d0704c:	0010      	movs	r0, r2
c0d0704e:	bc10      	pop	{r4}
c0d07050:	4770      	bx	lr
c0d07052:	b501      	push	{r0, lr}
c0d07054:	2000      	movs	r0, #0
c0d07056:	f000 f85f 	bl	c0d07118 <__aeabi_idiv0>
c0d0705a:	bd02      	pop	{r1, pc}

c0d0705c <__aeabi_uidivmod>:
c0d0705c:	2900      	cmp	r1, #0
c0d0705e:	d0f8      	beq.n	c0d07052 <.udivsi3_skip_div0_test+0x6a>
c0d07060:	b503      	push	{r0, r1, lr}
c0d07062:	f7ff ffc1 	bl	c0d06fe8 <.udivsi3_skip_div0_test>
c0d07066:	bc0e      	pop	{r1, r2, r3}
c0d07068:	4342      	muls	r2, r0
c0d0706a:	1a89      	subs	r1, r1, r2
c0d0706c:	4718      	bx	r3
c0d0706e:	46c0      	nop			; (mov r8, r8)

c0d07070 <__divsi3>:
c0d07070:	2900      	cmp	r1, #0
c0d07072:	d041      	beq.n	c0d070f8 <.divsi3_skip_div0_test+0x84>

c0d07074 <.divsi3_skip_div0_test>:
c0d07074:	b410      	push	{r4}
c0d07076:	0004      	movs	r4, r0
c0d07078:	404c      	eors	r4, r1
c0d0707a:	46a4      	mov	ip, r4
c0d0707c:	2301      	movs	r3, #1
c0d0707e:	2200      	movs	r2, #0
c0d07080:	2900      	cmp	r1, #0
c0d07082:	d500      	bpl.n	c0d07086 <.divsi3_skip_div0_test+0x12>
c0d07084:	4249      	negs	r1, r1
c0d07086:	2800      	cmp	r0, #0
c0d07088:	d500      	bpl.n	c0d0708c <.divsi3_skip_div0_test+0x18>
c0d0708a:	4240      	negs	r0, r0
c0d0708c:	4288      	cmp	r0, r1
c0d0708e:	d32c      	bcc.n	c0d070ea <.divsi3_skip_div0_test+0x76>
c0d07090:	2401      	movs	r4, #1
c0d07092:	0724      	lsls	r4, r4, #28
c0d07094:	42a1      	cmp	r1, r4
c0d07096:	d204      	bcs.n	c0d070a2 <.divsi3_skip_div0_test+0x2e>
c0d07098:	4281      	cmp	r1, r0
c0d0709a:	d202      	bcs.n	c0d070a2 <.divsi3_skip_div0_test+0x2e>
c0d0709c:	0109      	lsls	r1, r1, #4
c0d0709e:	011b      	lsls	r3, r3, #4
c0d070a0:	e7f8      	b.n	c0d07094 <.divsi3_skip_div0_test+0x20>
c0d070a2:	00e4      	lsls	r4, r4, #3
c0d070a4:	42a1      	cmp	r1, r4
c0d070a6:	d204      	bcs.n	c0d070b2 <.divsi3_skip_div0_test+0x3e>
c0d070a8:	4281      	cmp	r1, r0
c0d070aa:	d202      	bcs.n	c0d070b2 <.divsi3_skip_div0_test+0x3e>
c0d070ac:	0049      	lsls	r1, r1, #1
c0d070ae:	005b      	lsls	r3, r3, #1
c0d070b0:	e7f8      	b.n	c0d070a4 <.divsi3_skip_div0_test+0x30>
c0d070b2:	4288      	cmp	r0, r1
c0d070b4:	d301      	bcc.n	c0d070ba <.divsi3_skip_div0_test+0x46>
c0d070b6:	1a40      	subs	r0, r0, r1
c0d070b8:	431a      	orrs	r2, r3
c0d070ba:	084c      	lsrs	r4, r1, #1
c0d070bc:	42a0      	cmp	r0, r4
c0d070be:	d302      	bcc.n	c0d070c6 <.divsi3_skip_div0_test+0x52>
c0d070c0:	1b00      	subs	r0, r0, r4
c0d070c2:	085c      	lsrs	r4, r3, #1
c0d070c4:	4322      	orrs	r2, r4
c0d070c6:	088c      	lsrs	r4, r1, #2
c0d070c8:	42a0      	cmp	r0, r4
c0d070ca:	d302      	bcc.n	c0d070d2 <.divsi3_skip_div0_test+0x5e>
c0d070cc:	1b00      	subs	r0, r0, r4
c0d070ce:	089c      	lsrs	r4, r3, #2
c0d070d0:	4322      	orrs	r2, r4
c0d070d2:	08cc      	lsrs	r4, r1, #3
c0d070d4:	42a0      	cmp	r0, r4
c0d070d6:	d302      	bcc.n	c0d070de <.divsi3_skip_div0_test+0x6a>
c0d070d8:	1b00      	subs	r0, r0, r4
c0d070da:	08dc      	lsrs	r4, r3, #3
c0d070dc:	4322      	orrs	r2, r4
c0d070de:	2800      	cmp	r0, #0
c0d070e0:	d003      	beq.n	c0d070ea <.divsi3_skip_div0_test+0x76>
c0d070e2:	091b      	lsrs	r3, r3, #4
c0d070e4:	d001      	beq.n	c0d070ea <.divsi3_skip_div0_test+0x76>
c0d070e6:	0909      	lsrs	r1, r1, #4
c0d070e8:	e7e3      	b.n	c0d070b2 <.divsi3_skip_div0_test+0x3e>
c0d070ea:	0010      	movs	r0, r2
c0d070ec:	4664      	mov	r4, ip
c0d070ee:	2c00      	cmp	r4, #0
c0d070f0:	d500      	bpl.n	c0d070f4 <.divsi3_skip_div0_test+0x80>
c0d070f2:	4240      	negs	r0, r0
c0d070f4:	bc10      	pop	{r4}
c0d070f6:	4770      	bx	lr
c0d070f8:	b501      	push	{r0, lr}
c0d070fa:	2000      	movs	r0, #0
c0d070fc:	f000 f80c 	bl	c0d07118 <__aeabi_idiv0>
c0d07100:	bd02      	pop	{r1, pc}
c0d07102:	46c0      	nop			; (mov r8, r8)

c0d07104 <__aeabi_idivmod>:
c0d07104:	2900      	cmp	r1, #0
c0d07106:	d0f7      	beq.n	c0d070f8 <.divsi3_skip_div0_test+0x84>
c0d07108:	b503      	push	{r0, r1, lr}
c0d0710a:	f7ff ffb3 	bl	c0d07074 <.divsi3_skip_div0_test>
c0d0710e:	bc0e      	pop	{r1, r2, r3}
c0d07110:	4342      	muls	r2, r0
c0d07112:	1a89      	subs	r1, r1, r2
c0d07114:	4718      	bx	r3
c0d07116:	46c0      	nop			; (mov r8, r8)

c0d07118 <__aeabi_idiv0>:
c0d07118:	4770      	bx	lr
c0d0711a:	46c0      	nop			; (mov r8, r8)

c0d0711c <__aeabi_llsl>:
c0d0711c:	4091      	lsls	r1, r2
c0d0711e:	0003      	movs	r3, r0
c0d07120:	4090      	lsls	r0, r2
c0d07122:	469c      	mov	ip, r3
c0d07124:	3a20      	subs	r2, #32
c0d07126:	4093      	lsls	r3, r2
c0d07128:	4319      	orrs	r1, r3
c0d0712a:	4252      	negs	r2, r2
c0d0712c:	4663      	mov	r3, ip
c0d0712e:	40d3      	lsrs	r3, r2
c0d07130:	4319      	orrs	r1, r3
c0d07132:	4770      	bx	lr

c0d07134 <__aeabi_uldivmod>:
c0d07134:	2b00      	cmp	r3, #0
c0d07136:	d111      	bne.n	c0d0715c <__aeabi_uldivmod+0x28>
c0d07138:	2a00      	cmp	r2, #0
c0d0713a:	d10f      	bne.n	c0d0715c <__aeabi_uldivmod+0x28>
c0d0713c:	2900      	cmp	r1, #0
c0d0713e:	d100      	bne.n	c0d07142 <__aeabi_uldivmod+0xe>
c0d07140:	2800      	cmp	r0, #0
c0d07142:	d002      	beq.n	c0d0714a <__aeabi_uldivmod+0x16>
c0d07144:	2100      	movs	r1, #0
c0d07146:	43c9      	mvns	r1, r1
c0d07148:	0008      	movs	r0, r1
c0d0714a:	b407      	push	{r0, r1, r2}
c0d0714c:	4802      	ldr	r0, [pc, #8]	; (c0d07158 <__aeabi_uldivmod+0x24>)
c0d0714e:	a102      	add	r1, pc, #8	; (adr r1, c0d07158 <__aeabi_uldivmod+0x24>)
c0d07150:	1840      	adds	r0, r0, r1
c0d07152:	9002      	str	r0, [sp, #8]
c0d07154:	bd03      	pop	{r0, r1, pc}
c0d07156:	46c0      	nop			; (mov r8, r8)
c0d07158:	ffffffc1 	.word	0xffffffc1
c0d0715c:	b403      	push	{r0, r1}
c0d0715e:	4668      	mov	r0, sp
c0d07160:	b501      	push	{r0, lr}
c0d07162:	9802      	ldr	r0, [sp, #8]
c0d07164:	f000 f82a 	bl	c0d071bc <__udivmoddi4>
c0d07168:	9b01      	ldr	r3, [sp, #4]
c0d0716a:	469e      	mov	lr, r3
c0d0716c:	b002      	add	sp, #8
c0d0716e:	bc0c      	pop	{r2, r3}
c0d07170:	4770      	bx	lr
c0d07172:	46c0      	nop			; (mov r8, r8)

c0d07174 <__aeabi_lmul>:
c0d07174:	b5f7      	push	{r0, r1, r2, r4, r5, r6, r7, lr}
c0d07176:	9301      	str	r3, [sp, #4]
c0d07178:	b283      	uxth	r3, r0
c0d0717a:	469c      	mov	ip, r3
c0d0717c:	0006      	movs	r6, r0
c0d0717e:	0c03      	lsrs	r3, r0, #16
c0d07180:	4660      	mov	r0, ip
c0d07182:	000d      	movs	r5, r1
c0d07184:	4661      	mov	r1, ip
c0d07186:	b297      	uxth	r7, r2
c0d07188:	4378      	muls	r0, r7
c0d0718a:	0c14      	lsrs	r4, r2, #16
c0d0718c:	435f      	muls	r7, r3
c0d0718e:	4363      	muls	r3, r4
c0d07190:	434c      	muls	r4, r1
c0d07192:	0c01      	lsrs	r1, r0, #16
c0d07194:	468c      	mov	ip, r1
c0d07196:	19e4      	adds	r4, r4, r7
c0d07198:	4464      	add	r4, ip
c0d0719a:	42a7      	cmp	r7, r4
c0d0719c:	d902      	bls.n	c0d071a4 <__aeabi_lmul+0x30>
c0d0719e:	2180      	movs	r1, #128	; 0x80
c0d071a0:	0249      	lsls	r1, r1, #9
c0d071a2:	185b      	adds	r3, r3, r1
c0d071a4:	9901      	ldr	r1, [sp, #4]
c0d071a6:	436a      	muls	r2, r5
c0d071a8:	4371      	muls	r1, r6
c0d071aa:	0c27      	lsrs	r7, r4, #16
c0d071ac:	18fb      	adds	r3, r7, r3
c0d071ae:	0424      	lsls	r4, r4, #16
c0d071b0:	18c9      	adds	r1, r1, r3
c0d071b2:	b280      	uxth	r0, r0
c0d071b4:	1820      	adds	r0, r4, r0
c0d071b6:	1889      	adds	r1, r1, r2
c0d071b8:	b003      	add	sp, #12
c0d071ba:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d071bc <__udivmoddi4>:
c0d071bc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d071be:	0006      	movs	r6, r0
c0d071c0:	000f      	movs	r7, r1
c0d071c2:	0015      	movs	r5, r2
c0d071c4:	001c      	movs	r4, r3
c0d071c6:	b085      	sub	sp, #20
c0d071c8:	428b      	cmp	r3, r1
c0d071ca:	d863      	bhi.n	c0d07294 <__udivmoddi4+0xd8>
c0d071cc:	d101      	bne.n	c0d071d2 <__udivmoddi4+0x16>
c0d071ce:	4282      	cmp	r2, r0
c0d071d0:	d860      	bhi.n	c0d07294 <__udivmoddi4+0xd8>
c0d071d2:	0021      	movs	r1, r4
c0d071d4:	0028      	movs	r0, r5
c0d071d6:	f000 f86d 	bl	c0d072b4 <__clzdi2>
c0d071da:	0039      	movs	r1, r7
c0d071dc:	9000      	str	r0, [sp, #0]
c0d071de:	0030      	movs	r0, r6
c0d071e0:	f000 f868 	bl	c0d072b4 <__clzdi2>
c0d071e4:	9b00      	ldr	r3, [sp, #0]
c0d071e6:	0021      	movs	r1, r4
c0d071e8:	1a1b      	subs	r3, r3, r0
c0d071ea:	001a      	movs	r2, r3
c0d071ec:	0028      	movs	r0, r5
c0d071ee:	9303      	str	r3, [sp, #12]
c0d071f0:	f7ff ff94 	bl	c0d0711c <__aeabi_llsl>
c0d071f4:	9000      	str	r0, [sp, #0]
c0d071f6:	9101      	str	r1, [sp, #4]
c0d071f8:	42b9      	cmp	r1, r7
c0d071fa:	d845      	bhi.n	c0d07288 <__udivmoddi4+0xcc>
c0d071fc:	d101      	bne.n	c0d07202 <__udivmoddi4+0x46>
c0d071fe:	42b0      	cmp	r0, r6
c0d07200:	d842      	bhi.n	c0d07288 <__udivmoddi4+0xcc>
c0d07202:	9b00      	ldr	r3, [sp, #0]
c0d07204:	9c01      	ldr	r4, [sp, #4]
c0d07206:	2001      	movs	r0, #1
c0d07208:	2100      	movs	r1, #0
c0d0720a:	9a03      	ldr	r2, [sp, #12]
c0d0720c:	1af6      	subs	r6, r6, r3
c0d0720e:	41a7      	sbcs	r7, r4
c0d07210:	f7ff ff84 	bl	c0d0711c <__aeabi_llsl>
c0d07214:	0004      	movs	r4, r0
c0d07216:	000d      	movs	r5, r1
c0d07218:	9b03      	ldr	r3, [sp, #12]
c0d0721a:	2b00      	cmp	r3, #0
c0d0721c:	d02b      	beq.n	c0d07276 <__udivmoddi4+0xba>
c0d0721e:	9b01      	ldr	r3, [sp, #4]
c0d07220:	9a00      	ldr	r2, [sp, #0]
c0d07222:	07db      	lsls	r3, r3, #31
c0d07224:	0850      	lsrs	r0, r2, #1
c0d07226:	4318      	orrs	r0, r3
c0d07228:	9b01      	ldr	r3, [sp, #4]
c0d0722a:	0859      	lsrs	r1, r3, #1
c0d0722c:	9b03      	ldr	r3, [sp, #12]
c0d0722e:	469c      	mov	ip, r3
c0d07230:	42b9      	cmp	r1, r7
c0d07232:	d82c      	bhi.n	c0d0728e <__udivmoddi4+0xd2>
c0d07234:	d101      	bne.n	c0d0723a <__udivmoddi4+0x7e>
c0d07236:	42b0      	cmp	r0, r6
c0d07238:	d829      	bhi.n	c0d0728e <__udivmoddi4+0xd2>
c0d0723a:	0032      	movs	r2, r6
c0d0723c:	003b      	movs	r3, r7
c0d0723e:	1a12      	subs	r2, r2, r0
c0d07240:	418b      	sbcs	r3, r1
c0d07242:	2601      	movs	r6, #1
c0d07244:	1892      	adds	r2, r2, r2
c0d07246:	415b      	adcs	r3, r3
c0d07248:	2700      	movs	r7, #0
c0d0724a:	18b6      	adds	r6, r6, r2
c0d0724c:	415f      	adcs	r7, r3
c0d0724e:	2301      	movs	r3, #1
c0d07250:	425b      	negs	r3, r3
c0d07252:	449c      	add	ip, r3
c0d07254:	4663      	mov	r3, ip
c0d07256:	2b00      	cmp	r3, #0
c0d07258:	d1ea      	bne.n	c0d07230 <__udivmoddi4+0x74>
c0d0725a:	0030      	movs	r0, r6
c0d0725c:	0039      	movs	r1, r7
c0d0725e:	9a03      	ldr	r2, [sp, #12]
c0d07260:	f000 f81c 	bl	c0d0729c <__aeabi_llsr>
c0d07264:	9a03      	ldr	r2, [sp, #12]
c0d07266:	19a4      	adds	r4, r4, r6
c0d07268:	417d      	adcs	r5, r7
c0d0726a:	0006      	movs	r6, r0
c0d0726c:	000f      	movs	r7, r1
c0d0726e:	f7ff ff55 	bl	c0d0711c <__aeabi_llsl>
c0d07272:	1a24      	subs	r4, r4, r0
c0d07274:	418d      	sbcs	r5, r1
c0d07276:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d07278:	2b00      	cmp	r3, #0
c0d0727a:	d001      	beq.n	c0d07280 <__udivmoddi4+0xc4>
c0d0727c:	601e      	str	r6, [r3, #0]
c0d0727e:	605f      	str	r7, [r3, #4]
c0d07280:	0020      	movs	r0, r4
c0d07282:	0029      	movs	r1, r5
c0d07284:	b005      	add	sp, #20
c0d07286:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d07288:	2400      	movs	r4, #0
c0d0728a:	2500      	movs	r5, #0
c0d0728c:	e7c4      	b.n	c0d07218 <__udivmoddi4+0x5c>
c0d0728e:	19b6      	adds	r6, r6, r6
c0d07290:	417f      	adcs	r7, r7
c0d07292:	e7dc      	b.n	c0d0724e <__udivmoddi4+0x92>
c0d07294:	2400      	movs	r4, #0
c0d07296:	2500      	movs	r5, #0
c0d07298:	e7ed      	b.n	c0d07276 <__udivmoddi4+0xba>
	...

c0d0729c <__aeabi_llsr>:
c0d0729c:	40d0      	lsrs	r0, r2
c0d0729e:	000b      	movs	r3, r1
c0d072a0:	40d1      	lsrs	r1, r2
c0d072a2:	469c      	mov	ip, r3
c0d072a4:	3a20      	subs	r2, #32
c0d072a6:	40d3      	lsrs	r3, r2
c0d072a8:	4318      	orrs	r0, r3
c0d072aa:	4252      	negs	r2, r2
c0d072ac:	4663      	mov	r3, ip
c0d072ae:	4093      	lsls	r3, r2
c0d072b0:	4318      	orrs	r0, r3
c0d072b2:	4770      	bx	lr

c0d072b4 <__clzdi2>:
c0d072b4:	b510      	push	{r4, lr}
c0d072b6:	2900      	cmp	r1, #0
c0d072b8:	d103      	bne.n	c0d072c2 <__clzdi2+0xe>
c0d072ba:	f000 f807 	bl	c0d072cc <__clzsi2>
c0d072be:	3020      	adds	r0, #32
c0d072c0:	e002      	b.n	c0d072c8 <__clzdi2+0x14>
c0d072c2:	0008      	movs	r0, r1
c0d072c4:	f000 f802 	bl	c0d072cc <__clzsi2>
c0d072c8:	bd10      	pop	{r4, pc}
c0d072ca:	46c0      	nop			; (mov r8, r8)

c0d072cc <__clzsi2>:
c0d072cc:	211c      	movs	r1, #28
c0d072ce:	2301      	movs	r3, #1
c0d072d0:	041b      	lsls	r3, r3, #16
c0d072d2:	4298      	cmp	r0, r3
c0d072d4:	d301      	bcc.n	c0d072da <__clzsi2+0xe>
c0d072d6:	0c00      	lsrs	r0, r0, #16
c0d072d8:	3910      	subs	r1, #16
c0d072da:	0a1b      	lsrs	r3, r3, #8
c0d072dc:	4298      	cmp	r0, r3
c0d072de:	d301      	bcc.n	c0d072e4 <__clzsi2+0x18>
c0d072e0:	0a00      	lsrs	r0, r0, #8
c0d072e2:	3908      	subs	r1, #8
c0d072e4:	091b      	lsrs	r3, r3, #4
c0d072e6:	4298      	cmp	r0, r3
c0d072e8:	d301      	bcc.n	c0d072ee <__clzsi2+0x22>
c0d072ea:	0900      	lsrs	r0, r0, #4
c0d072ec:	3904      	subs	r1, #4
c0d072ee:	a202      	add	r2, pc, #8	; (adr r2, c0d072f8 <__clzsi2+0x2c>)
c0d072f0:	5c10      	ldrb	r0, [r2, r0]
c0d072f2:	1840      	adds	r0, r0, r1
c0d072f4:	4770      	bx	lr
c0d072f6:	46c0      	nop			; (mov r8, r8)
c0d072f8:	02020304 	.word	0x02020304
c0d072fc:	01010101 	.word	0x01010101
	...

c0d07308 <__aeabi_memclr>:
c0d07308:	b510      	push	{r4, lr}
c0d0730a:	2200      	movs	r2, #0
c0d0730c:	f000 f80a 	bl	c0d07324 <__aeabi_memset>
c0d07310:	bd10      	pop	{r4, pc}
c0d07312:	46c0      	nop			; (mov r8, r8)

c0d07314 <__aeabi_memcpy>:
c0d07314:	b510      	push	{r4, lr}
c0d07316:	f000 f835 	bl	c0d07384 <memcpy>
c0d0731a:	bd10      	pop	{r4, pc}

c0d0731c <__aeabi_memmove>:
c0d0731c:	b510      	push	{r4, lr}
c0d0731e:	f000 f883 	bl	c0d07428 <memmove>
c0d07322:	bd10      	pop	{r4, pc}

c0d07324 <__aeabi_memset>:
c0d07324:	000b      	movs	r3, r1
c0d07326:	b510      	push	{r4, lr}
c0d07328:	0011      	movs	r1, r2
c0d0732a:	001a      	movs	r2, r3
c0d0732c:	f000 f8d2 	bl	c0d074d4 <memset>
c0d07330:	bd10      	pop	{r4, pc}
c0d07332:	46c0      	nop			; (mov r8, r8)

c0d07334 <explicit_bzero>:
c0d07334:	b510      	push	{r4, lr}
c0d07336:	f000 f9cd 	bl	c0d076d4 <bzero>
c0d0733a:	bd10      	pop	{r4, pc}

c0d0733c <memcmp>:
c0d0733c:	b530      	push	{r4, r5, lr}
c0d0733e:	2a03      	cmp	r2, #3
c0d07340:	d90c      	bls.n	c0d0735c <memcmp+0x20>
c0d07342:	0003      	movs	r3, r0
c0d07344:	430b      	orrs	r3, r1
c0d07346:	079b      	lsls	r3, r3, #30
c0d07348:	d119      	bne.n	c0d0737e <memcmp+0x42>
c0d0734a:	6803      	ldr	r3, [r0, #0]
c0d0734c:	680c      	ldr	r4, [r1, #0]
c0d0734e:	42a3      	cmp	r3, r4
c0d07350:	d115      	bne.n	c0d0737e <memcmp+0x42>
c0d07352:	3a04      	subs	r2, #4
c0d07354:	3004      	adds	r0, #4
c0d07356:	3104      	adds	r1, #4
c0d07358:	2a03      	cmp	r2, #3
c0d0735a:	d8f6      	bhi.n	c0d0734a <memcmp+0xe>
c0d0735c:	1e55      	subs	r5, r2, #1
c0d0735e:	2a00      	cmp	r2, #0
c0d07360:	d00b      	beq.n	c0d0737a <memcmp+0x3e>
c0d07362:	2300      	movs	r3, #0
c0d07364:	e003      	b.n	c0d0736e <memcmp+0x32>
c0d07366:	1c5a      	adds	r2, r3, #1
c0d07368:	429d      	cmp	r5, r3
c0d0736a:	d006      	beq.n	c0d0737a <memcmp+0x3e>
c0d0736c:	0013      	movs	r3, r2
c0d0736e:	5cc2      	ldrb	r2, [r0, r3]
c0d07370:	5ccc      	ldrb	r4, [r1, r3]
c0d07372:	42a2      	cmp	r2, r4
c0d07374:	d0f7      	beq.n	c0d07366 <memcmp+0x2a>
c0d07376:	1b10      	subs	r0, r2, r4
c0d07378:	e000      	b.n	c0d0737c <memcmp+0x40>
c0d0737a:	2000      	movs	r0, #0
c0d0737c:	bd30      	pop	{r4, r5, pc}
c0d0737e:	1e55      	subs	r5, r2, #1
c0d07380:	e7ef      	b.n	c0d07362 <memcmp+0x26>
c0d07382:	46c0      	nop			; (mov r8, r8)

c0d07384 <memcpy>:
c0d07384:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d07386:	46c6      	mov	lr, r8
c0d07388:	b500      	push	{lr}
c0d0738a:	2a0f      	cmp	r2, #15
c0d0738c:	d941      	bls.n	c0d07412 <memcpy+0x8e>
c0d0738e:	2703      	movs	r7, #3
c0d07390:	000d      	movs	r5, r1
c0d07392:	003e      	movs	r6, r7
c0d07394:	4305      	orrs	r5, r0
c0d07396:	000c      	movs	r4, r1
c0d07398:	0003      	movs	r3, r0
c0d0739a:	402e      	ands	r6, r5
c0d0739c:	422f      	tst	r7, r5
c0d0739e:	d13d      	bne.n	c0d0741c <memcpy+0x98>
c0d073a0:	0015      	movs	r5, r2
c0d073a2:	3d10      	subs	r5, #16
c0d073a4:	092d      	lsrs	r5, r5, #4
c0d073a6:	46a8      	mov	r8, r5
c0d073a8:	012d      	lsls	r5, r5, #4
c0d073aa:	46ac      	mov	ip, r5
c0d073ac:	4484      	add	ip, r0
c0d073ae:	6827      	ldr	r7, [r4, #0]
c0d073b0:	001d      	movs	r5, r3
c0d073b2:	601f      	str	r7, [r3, #0]
c0d073b4:	6867      	ldr	r7, [r4, #4]
c0d073b6:	605f      	str	r7, [r3, #4]
c0d073b8:	68a7      	ldr	r7, [r4, #8]
c0d073ba:	609f      	str	r7, [r3, #8]
c0d073bc:	68e7      	ldr	r7, [r4, #12]
c0d073be:	3410      	adds	r4, #16
c0d073c0:	60df      	str	r7, [r3, #12]
c0d073c2:	3310      	adds	r3, #16
c0d073c4:	4565      	cmp	r5, ip
c0d073c6:	d1f2      	bne.n	c0d073ae <memcpy+0x2a>
c0d073c8:	4645      	mov	r5, r8
c0d073ca:	230f      	movs	r3, #15
c0d073cc:	240c      	movs	r4, #12
c0d073ce:	3501      	adds	r5, #1
c0d073d0:	012d      	lsls	r5, r5, #4
c0d073d2:	1949      	adds	r1, r1, r5
c0d073d4:	4013      	ands	r3, r2
c0d073d6:	1945      	adds	r5, r0, r5
c0d073d8:	4214      	tst	r4, r2
c0d073da:	d022      	beq.n	c0d07422 <memcpy+0x9e>
c0d073dc:	598c      	ldr	r4, [r1, r6]
c0d073de:	51ac      	str	r4, [r5, r6]
c0d073e0:	3604      	adds	r6, #4
c0d073e2:	1b9c      	subs	r4, r3, r6
c0d073e4:	2c03      	cmp	r4, #3
c0d073e6:	d8f9      	bhi.n	c0d073dc <memcpy+0x58>
c0d073e8:	3b04      	subs	r3, #4
c0d073ea:	089b      	lsrs	r3, r3, #2
c0d073ec:	3301      	adds	r3, #1
c0d073ee:	009b      	lsls	r3, r3, #2
c0d073f0:	18ed      	adds	r5, r5, r3
c0d073f2:	18c9      	adds	r1, r1, r3
c0d073f4:	2303      	movs	r3, #3
c0d073f6:	401a      	ands	r2, r3
c0d073f8:	1e56      	subs	r6, r2, #1
c0d073fa:	2a00      	cmp	r2, #0
c0d073fc:	d006      	beq.n	c0d0740c <memcpy+0x88>
c0d073fe:	2300      	movs	r3, #0
c0d07400:	5ccc      	ldrb	r4, [r1, r3]
c0d07402:	001a      	movs	r2, r3
c0d07404:	54ec      	strb	r4, [r5, r3]
c0d07406:	3301      	adds	r3, #1
c0d07408:	4296      	cmp	r6, r2
c0d0740a:	d1f9      	bne.n	c0d07400 <memcpy+0x7c>
c0d0740c:	bc80      	pop	{r7}
c0d0740e:	46b8      	mov	r8, r7
c0d07410:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d07412:	0005      	movs	r5, r0
c0d07414:	1e56      	subs	r6, r2, #1
c0d07416:	2a00      	cmp	r2, #0
c0d07418:	d1f1      	bne.n	c0d073fe <memcpy+0x7a>
c0d0741a:	e7f7      	b.n	c0d0740c <memcpy+0x88>
c0d0741c:	0005      	movs	r5, r0
c0d0741e:	1e56      	subs	r6, r2, #1
c0d07420:	e7ed      	b.n	c0d073fe <memcpy+0x7a>
c0d07422:	001a      	movs	r2, r3
c0d07424:	e7f6      	b.n	c0d07414 <memcpy+0x90>
c0d07426:	46c0      	nop			; (mov r8, r8)

c0d07428 <memmove>:
c0d07428:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0742a:	4288      	cmp	r0, r1
c0d0742c:	d90a      	bls.n	c0d07444 <memmove+0x1c>
c0d0742e:	188b      	adds	r3, r1, r2
c0d07430:	4298      	cmp	r0, r3
c0d07432:	d207      	bcs.n	c0d07444 <memmove+0x1c>
c0d07434:	1e53      	subs	r3, r2, #1
c0d07436:	2a00      	cmp	r2, #0
c0d07438:	d003      	beq.n	c0d07442 <memmove+0x1a>
c0d0743a:	5cca      	ldrb	r2, [r1, r3]
c0d0743c:	54c2      	strb	r2, [r0, r3]
c0d0743e:	3b01      	subs	r3, #1
c0d07440:	d2fb      	bcs.n	c0d0743a <memmove+0x12>
c0d07442:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d07444:	2a0f      	cmp	r2, #15
c0d07446:	d80b      	bhi.n	c0d07460 <memmove+0x38>
c0d07448:	0005      	movs	r5, r0
c0d0744a:	1e56      	subs	r6, r2, #1
c0d0744c:	2a00      	cmp	r2, #0
c0d0744e:	d0f8      	beq.n	c0d07442 <memmove+0x1a>
c0d07450:	2300      	movs	r3, #0
c0d07452:	5ccc      	ldrb	r4, [r1, r3]
c0d07454:	001a      	movs	r2, r3
c0d07456:	54ec      	strb	r4, [r5, r3]
c0d07458:	3301      	adds	r3, #1
c0d0745a:	4296      	cmp	r6, r2
c0d0745c:	d1f9      	bne.n	c0d07452 <memmove+0x2a>
c0d0745e:	e7f0      	b.n	c0d07442 <memmove+0x1a>
c0d07460:	2703      	movs	r7, #3
c0d07462:	000d      	movs	r5, r1
c0d07464:	003e      	movs	r6, r7
c0d07466:	4305      	orrs	r5, r0
c0d07468:	000c      	movs	r4, r1
c0d0746a:	0003      	movs	r3, r0
c0d0746c:	402e      	ands	r6, r5
c0d0746e:	422f      	tst	r7, r5
c0d07470:	d12b      	bne.n	c0d074ca <memmove+0xa2>
c0d07472:	0015      	movs	r5, r2
c0d07474:	3d10      	subs	r5, #16
c0d07476:	092d      	lsrs	r5, r5, #4
c0d07478:	46ac      	mov	ip, r5
c0d0747a:	012f      	lsls	r7, r5, #4
c0d0747c:	183f      	adds	r7, r7, r0
c0d0747e:	6825      	ldr	r5, [r4, #0]
c0d07480:	601d      	str	r5, [r3, #0]
c0d07482:	6865      	ldr	r5, [r4, #4]
c0d07484:	605d      	str	r5, [r3, #4]
c0d07486:	68a5      	ldr	r5, [r4, #8]
c0d07488:	609d      	str	r5, [r3, #8]
c0d0748a:	68e5      	ldr	r5, [r4, #12]
c0d0748c:	3410      	adds	r4, #16
c0d0748e:	60dd      	str	r5, [r3, #12]
c0d07490:	001d      	movs	r5, r3
c0d07492:	3310      	adds	r3, #16
c0d07494:	42bd      	cmp	r5, r7
c0d07496:	d1f2      	bne.n	c0d0747e <memmove+0x56>
c0d07498:	4665      	mov	r5, ip
c0d0749a:	230f      	movs	r3, #15
c0d0749c:	240c      	movs	r4, #12
c0d0749e:	3501      	adds	r5, #1
c0d074a0:	012d      	lsls	r5, r5, #4
c0d074a2:	1949      	adds	r1, r1, r5
c0d074a4:	4013      	ands	r3, r2
c0d074a6:	1945      	adds	r5, r0, r5
c0d074a8:	4214      	tst	r4, r2
c0d074aa:	d011      	beq.n	c0d074d0 <memmove+0xa8>
c0d074ac:	598c      	ldr	r4, [r1, r6]
c0d074ae:	51ac      	str	r4, [r5, r6]
c0d074b0:	3604      	adds	r6, #4
c0d074b2:	1b9c      	subs	r4, r3, r6
c0d074b4:	2c03      	cmp	r4, #3
c0d074b6:	d8f9      	bhi.n	c0d074ac <memmove+0x84>
c0d074b8:	3b04      	subs	r3, #4
c0d074ba:	089b      	lsrs	r3, r3, #2
c0d074bc:	3301      	adds	r3, #1
c0d074be:	009b      	lsls	r3, r3, #2
c0d074c0:	18ed      	adds	r5, r5, r3
c0d074c2:	18c9      	adds	r1, r1, r3
c0d074c4:	2303      	movs	r3, #3
c0d074c6:	401a      	ands	r2, r3
c0d074c8:	e7bf      	b.n	c0d0744a <memmove+0x22>
c0d074ca:	0005      	movs	r5, r0
c0d074cc:	1e56      	subs	r6, r2, #1
c0d074ce:	e7bf      	b.n	c0d07450 <memmove+0x28>
c0d074d0:	001a      	movs	r2, r3
c0d074d2:	e7ba      	b.n	c0d0744a <memmove+0x22>

c0d074d4 <memset>:
c0d074d4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d074d6:	0005      	movs	r5, r0
c0d074d8:	0783      	lsls	r3, r0, #30
c0d074da:	d049      	beq.n	c0d07570 <memset+0x9c>
c0d074dc:	1e54      	subs	r4, r2, #1
c0d074de:	2a00      	cmp	r2, #0
c0d074e0:	d045      	beq.n	c0d0756e <memset+0x9a>
c0d074e2:	0003      	movs	r3, r0
c0d074e4:	2603      	movs	r6, #3
c0d074e6:	b2ca      	uxtb	r2, r1
c0d074e8:	e002      	b.n	c0d074f0 <memset+0x1c>
c0d074ea:	3501      	adds	r5, #1
c0d074ec:	3c01      	subs	r4, #1
c0d074ee:	d33e      	bcc.n	c0d0756e <memset+0x9a>
c0d074f0:	3301      	adds	r3, #1
c0d074f2:	702a      	strb	r2, [r5, #0]
c0d074f4:	4233      	tst	r3, r6
c0d074f6:	d1f8      	bne.n	c0d074ea <memset+0x16>
c0d074f8:	2c03      	cmp	r4, #3
c0d074fa:	d930      	bls.n	c0d0755e <memset+0x8a>
c0d074fc:	22ff      	movs	r2, #255	; 0xff
c0d074fe:	400a      	ands	r2, r1
c0d07500:	0215      	lsls	r5, r2, #8
c0d07502:	4315      	orrs	r5, r2
c0d07504:	042a      	lsls	r2, r5, #16
c0d07506:	4315      	orrs	r5, r2
c0d07508:	2c0f      	cmp	r4, #15
c0d0750a:	d934      	bls.n	c0d07576 <memset+0xa2>
c0d0750c:	0027      	movs	r7, r4
c0d0750e:	3f10      	subs	r7, #16
c0d07510:	093f      	lsrs	r7, r7, #4
c0d07512:	013e      	lsls	r6, r7, #4
c0d07514:	46b4      	mov	ip, r6
c0d07516:	001e      	movs	r6, r3
c0d07518:	001a      	movs	r2, r3
c0d0751a:	3610      	adds	r6, #16
c0d0751c:	4466      	add	r6, ip
c0d0751e:	6015      	str	r5, [r2, #0]
c0d07520:	6055      	str	r5, [r2, #4]
c0d07522:	6095      	str	r5, [r2, #8]
c0d07524:	60d5      	str	r5, [r2, #12]
c0d07526:	3210      	adds	r2, #16
c0d07528:	42b2      	cmp	r2, r6
c0d0752a:	d1f8      	bne.n	c0d0751e <memset+0x4a>
c0d0752c:	3701      	adds	r7, #1
c0d0752e:	013f      	lsls	r7, r7, #4
c0d07530:	19db      	adds	r3, r3, r7
c0d07532:	270f      	movs	r7, #15
c0d07534:	220c      	movs	r2, #12
c0d07536:	4027      	ands	r7, r4
c0d07538:	4022      	ands	r2, r4
c0d0753a:	003c      	movs	r4, r7
c0d0753c:	2a00      	cmp	r2, #0
c0d0753e:	d00e      	beq.n	c0d0755e <memset+0x8a>
c0d07540:	1f3e      	subs	r6, r7, #4
c0d07542:	08b6      	lsrs	r6, r6, #2
c0d07544:	00b4      	lsls	r4, r6, #2
c0d07546:	46a4      	mov	ip, r4
c0d07548:	001a      	movs	r2, r3
c0d0754a:	1d1c      	adds	r4, r3, #4
c0d0754c:	4464      	add	r4, ip
c0d0754e:	c220      	stmia	r2!, {r5}
c0d07550:	42a2      	cmp	r2, r4
c0d07552:	d1fc      	bne.n	c0d0754e <memset+0x7a>
c0d07554:	2403      	movs	r4, #3
c0d07556:	3601      	adds	r6, #1
c0d07558:	00b6      	lsls	r6, r6, #2
c0d0755a:	199b      	adds	r3, r3, r6
c0d0755c:	403c      	ands	r4, r7
c0d0755e:	2c00      	cmp	r4, #0
c0d07560:	d005      	beq.n	c0d0756e <memset+0x9a>
c0d07562:	b2c9      	uxtb	r1, r1
c0d07564:	191c      	adds	r4, r3, r4
c0d07566:	7019      	strb	r1, [r3, #0]
c0d07568:	3301      	adds	r3, #1
c0d0756a:	429c      	cmp	r4, r3
c0d0756c:	d1fb      	bne.n	c0d07566 <memset+0x92>
c0d0756e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d07570:	0003      	movs	r3, r0
c0d07572:	0014      	movs	r4, r2
c0d07574:	e7c0      	b.n	c0d074f8 <memset+0x24>
c0d07576:	0027      	movs	r7, r4
c0d07578:	e7e2      	b.n	c0d07540 <memset+0x6c>
c0d0757a:	46c0      	nop			; (mov r8, r8)

c0d0757c <setjmp>:
c0d0757c:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d0757e:	4641      	mov	r1, r8
c0d07580:	464a      	mov	r2, r9
c0d07582:	4653      	mov	r3, sl
c0d07584:	465c      	mov	r4, fp
c0d07586:	466d      	mov	r5, sp
c0d07588:	4676      	mov	r6, lr
c0d0758a:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d0758c:	3828      	subs	r0, #40	; 0x28
c0d0758e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d07590:	2000      	movs	r0, #0
c0d07592:	4770      	bx	lr

c0d07594 <longjmp>:
c0d07594:	3010      	adds	r0, #16
c0d07596:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d07598:	4690      	mov	r8, r2
c0d0759a:	4699      	mov	r9, r3
c0d0759c:	46a2      	mov	sl, r4
c0d0759e:	46ab      	mov	fp, r5
c0d075a0:	46b5      	mov	sp, r6
c0d075a2:	c808      	ldmia	r0!, {r3}
c0d075a4:	3828      	subs	r0, #40	; 0x28
c0d075a6:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d075a8:	0008      	movs	r0, r1
c0d075aa:	d100      	bne.n	c0d075ae <longjmp+0x1a>
c0d075ac:	2001      	movs	r0, #1
c0d075ae:	4718      	bx	r3

c0d075b0 <strlcat>:
c0d075b0:	b570      	push	{r4, r5, r6, lr}
c0d075b2:	2a00      	cmp	r2, #0
c0d075b4:	d01f      	beq.n	c0d075f6 <strlcat+0x46>
c0d075b6:	0003      	movs	r3, r0
c0d075b8:	1885      	adds	r5, r0, r2
c0d075ba:	e002      	b.n	c0d075c2 <strlcat+0x12>
c0d075bc:	3301      	adds	r3, #1
c0d075be:	42ab      	cmp	r3, r5
c0d075c0:	d002      	beq.n	c0d075c8 <strlcat+0x18>
c0d075c2:	781c      	ldrb	r4, [r3, #0]
c0d075c4:	2c00      	cmp	r4, #0
c0d075c6:	d1f9      	bne.n	c0d075bc <strlcat+0xc>
c0d075c8:	1a1e      	subs	r6, r3, r0
c0d075ca:	1b95      	subs	r5, r2, r6
c0d075cc:	42b2      	cmp	r2, r6
c0d075ce:	d013      	beq.n	c0d075f8 <strlcat+0x48>
c0d075d0:	780c      	ldrb	r4, [r1, #0]
c0d075d2:	000a      	movs	r2, r1
c0d075d4:	2c00      	cmp	r4, #0
c0d075d6:	d00a      	beq.n	c0d075ee <strlcat+0x3e>
c0d075d8:	2d01      	cmp	r5, #1
c0d075da:	d002      	beq.n	c0d075e2 <strlcat+0x32>
c0d075dc:	701c      	strb	r4, [r3, #0]
c0d075de:	3d01      	subs	r5, #1
c0d075e0:	3301      	adds	r3, #1
c0d075e2:	7854      	ldrb	r4, [r2, #1]
c0d075e4:	3201      	adds	r2, #1
c0d075e6:	2c00      	cmp	r4, #0
c0d075e8:	d1f6      	bne.n	c0d075d8 <strlcat+0x28>
c0d075ea:	1a52      	subs	r2, r2, r1
c0d075ec:	18b6      	adds	r6, r6, r2
c0d075ee:	2200      	movs	r2, #0
c0d075f0:	701a      	strb	r2, [r3, #0]
c0d075f2:	0030      	movs	r0, r6
c0d075f4:	bd70      	pop	{r4, r5, r6, pc}
c0d075f6:	2600      	movs	r6, #0
c0d075f8:	0008      	movs	r0, r1
c0d075fa:	f000 f82b 	bl	c0d07654 <strlen>
c0d075fe:	1836      	adds	r6, r6, r0
c0d07600:	e7f7      	b.n	c0d075f2 <strlcat+0x42>
c0d07602:	46c0      	nop			; (mov r8, r8)

c0d07604 <strlcpy>:
c0d07604:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d07606:	0005      	movs	r5, r0
c0d07608:	2a00      	cmp	r2, #0
c0d0760a:	d013      	beq.n	c0d07634 <strlcpy+0x30>
c0d0760c:	1e50      	subs	r0, r2, #1
c0d0760e:	2a01      	cmp	r2, #1
c0d07610:	d019      	beq.n	c0d07646 <strlcpy+0x42>
c0d07612:	2300      	movs	r3, #0
c0d07614:	1c4f      	adds	r7, r1, #1
c0d07616:	1c6e      	adds	r6, r5, #1
c0d07618:	e002      	b.n	c0d07620 <strlcpy+0x1c>
c0d0761a:	3301      	adds	r3, #1
c0d0761c:	4298      	cmp	r0, r3
c0d0761e:	d016      	beq.n	c0d0764e <strlcpy+0x4a>
c0d07620:	18f4      	adds	r4, r6, r3
c0d07622:	46a4      	mov	ip, r4
c0d07624:	5ccc      	ldrb	r4, [r1, r3]
c0d07626:	18fa      	adds	r2, r7, r3
c0d07628:	54ec      	strb	r4, [r5, r3]
c0d0762a:	2c00      	cmp	r4, #0
c0d0762c:	d1f5      	bne.n	c0d0761a <strlcpy+0x16>
c0d0762e:	1a50      	subs	r0, r2, r1
c0d07630:	3801      	subs	r0, #1
c0d07632:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d07634:	000a      	movs	r2, r1
c0d07636:	0013      	movs	r3, r2
c0d07638:	3301      	adds	r3, #1
c0d0763a:	1e5c      	subs	r4, r3, #1
c0d0763c:	7824      	ldrb	r4, [r4, #0]
c0d0763e:	001a      	movs	r2, r3
c0d07640:	2c00      	cmp	r4, #0
c0d07642:	d1f9      	bne.n	c0d07638 <strlcpy+0x34>
c0d07644:	e7f3      	b.n	c0d0762e <strlcpy+0x2a>
c0d07646:	000a      	movs	r2, r1
c0d07648:	2300      	movs	r3, #0
c0d0764a:	702b      	strb	r3, [r5, #0]
c0d0764c:	e7f3      	b.n	c0d07636 <strlcpy+0x32>
c0d0764e:	4665      	mov	r5, ip
c0d07650:	e7fa      	b.n	c0d07648 <strlcpy+0x44>
c0d07652:	46c0      	nop			; (mov r8, r8)

c0d07654 <strlen>:
c0d07654:	b510      	push	{r4, lr}
c0d07656:	0783      	lsls	r3, r0, #30
c0d07658:	d00a      	beq.n	c0d07670 <strlen+0x1c>
c0d0765a:	0003      	movs	r3, r0
c0d0765c:	2103      	movs	r1, #3
c0d0765e:	e002      	b.n	c0d07666 <strlen+0x12>
c0d07660:	3301      	adds	r3, #1
c0d07662:	420b      	tst	r3, r1
c0d07664:	d005      	beq.n	c0d07672 <strlen+0x1e>
c0d07666:	781a      	ldrb	r2, [r3, #0]
c0d07668:	2a00      	cmp	r2, #0
c0d0766a:	d1f9      	bne.n	c0d07660 <strlen+0xc>
c0d0766c:	1a18      	subs	r0, r3, r0
c0d0766e:	bd10      	pop	{r4, pc}
c0d07670:	0003      	movs	r3, r0
c0d07672:	6819      	ldr	r1, [r3, #0]
c0d07674:	4a0c      	ldr	r2, [pc, #48]	; (c0d076a8 <strlen+0x54>)
c0d07676:	4c0d      	ldr	r4, [pc, #52]	; (c0d076ac <strlen+0x58>)
c0d07678:	188a      	adds	r2, r1, r2
c0d0767a:	438a      	bics	r2, r1
c0d0767c:	4222      	tst	r2, r4
c0d0767e:	d10f      	bne.n	c0d076a0 <strlen+0x4c>
c0d07680:	6859      	ldr	r1, [r3, #4]
c0d07682:	4a09      	ldr	r2, [pc, #36]	; (c0d076a8 <strlen+0x54>)
c0d07684:	3304      	adds	r3, #4
c0d07686:	188a      	adds	r2, r1, r2
c0d07688:	438a      	bics	r2, r1
c0d0768a:	4222      	tst	r2, r4
c0d0768c:	d108      	bne.n	c0d076a0 <strlen+0x4c>
c0d0768e:	6859      	ldr	r1, [r3, #4]
c0d07690:	4a05      	ldr	r2, [pc, #20]	; (c0d076a8 <strlen+0x54>)
c0d07692:	3304      	adds	r3, #4
c0d07694:	188a      	adds	r2, r1, r2
c0d07696:	438a      	bics	r2, r1
c0d07698:	4222      	tst	r2, r4
c0d0769a:	d0f1      	beq.n	c0d07680 <strlen+0x2c>
c0d0769c:	e000      	b.n	c0d076a0 <strlen+0x4c>
c0d0769e:	3301      	adds	r3, #1
c0d076a0:	781a      	ldrb	r2, [r3, #0]
c0d076a2:	2a00      	cmp	r2, #0
c0d076a4:	d1fb      	bne.n	c0d0769e <strlen+0x4a>
c0d076a6:	e7e1      	b.n	c0d0766c <strlen+0x18>
c0d076a8:	fefefeff 	.word	0xfefefeff
c0d076ac:	80808080 	.word	0x80808080

c0d076b0 <strnlen>:
c0d076b0:	b510      	push	{r4, lr}
c0d076b2:	0003      	movs	r3, r0
c0d076b4:	1844      	adds	r4, r0, r1
c0d076b6:	2900      	cmp	r1, #0
c0d076b8:	d103      	bne.n	c0d076c2 <strnlen+0x12>
c0d076ba:	e009      	b.n	c0d076d0 <strnlen+0x20>
c0d076bc:	3301      	adds	r3, #1
c0d076be:	429c      	cmp	r4, r3
c0d076c0:	d004      	beq.n	c0d076cc <strnlen+0x1c>
c0d076c2:	781a      	ldrb	r2, [r3, #0]
c0d076c4:	2a00      	cmp	r2, #0
c0d076c6:	d1f9      	bne.n	c0d076bc <strnlen+0xc>
c0d076c8:	1a18      	subs	r0, r3, r0
c0d076ca:	bd10      	pop	{r4, pc}
c0d076cc:	1a20      	subs	r0, r4, r0
c0d076ce:	e7fc      	b.n	c0d076ca <strnlen+0x1a>
c0d076d0:	2000      	movs	r0, #0
c0d076d2:	e7fa      	b.n	c0d076ca <strnlen+0x1a>

c0d076d4 <bzero>:
c0d076d4:	b510      	push	{r4, lr}
c0d076d6:	000a      	movs	r2, r1
c0d076d8:	2100      	movs	r1, #0
c0d076da:	f7ff fefb 	bl	c0d074d4 <memset>
c0d076de:	bd10      	pop	{r4, pc}
c0d076e0:	72646461 	.word	0x72646461
c0d076e4:	7465675f 	.word	0x7465675f
c0d076e8:	496d754e 	.word	0x496d754e
c0d076ec:	736d6574 	.word	0x736d6574
c0d076f0:	64646100 	.word	0x64646100
c0d076f4:	65675f72 	.word	0x65675f72
c0d076f8:	65744974 	.word	0x65744974
c0d076fc:	6425206d 	.word	0x6425206d
c0d07700:	0064252f 	.word	0x0064252f
c0d07704:	72646441 	.word	0x72646441
c0d07708:	00737365 	.word	0x00737365
c0d0770c:	72756f59 	.word	0x72756f59
c0d07710:	74615020 	.word	0x74615020
c0d07714:	52450068 	.word	0x52450068
c0d07718:	00524f52 	.word	0x00524f52
c0d0771c:	002f0027 	.word	0x002f0027

c0d07720 <BASE58ALPHABET>:
c0d07720:	34333231 38373635 43424139 47464544     123456789ABCDEFG
c0d07730:	4c4b4a48 51504e4d 55545352 59585756     HJKLMNPQRSTUVWXY
c0d07740:	6362615a 67666564 6b6a6968 706f6e6d     Zabcdefghijkmnop
c0d07750:	74737271 78777675 52457a79               qrstuvwxyzERR.

c0d0775e <bignumBigEndian_bcdprint.hexchars>:
c0d0775e:	33323130 37363534 42413938 46454443     0123456789ABCDEF
c0d0776e:	6e655000 676e6964 64654c00 20726567     .Pending.Ledger 
c0d0777e:	69766572 00007765                        review....

c0d07788 <ui_audited_elements>:
c0d07788:	00000003 00800000 00000020 00000001     ........ .......
c0d07798:	00000000 00ffffff 00000000 00000000     ................
c0d077a8:	00000107 0080000c 00000020 00000000     ........ .......
c0d077b8:	00ffffff 00000000 00008008 c0d0776f     ............ow..
c0d077c8:	00000107 00800018 00000020 00000000     ........ .......
c0d077d8:	00ffffff 00000000 00008008 c0d07777     ............ww..
c0d077e8:	38355353 00455250                       SS58PRE.

c0d077f0 <C_icon_app_colors>:
c0d077f0:	00000000 00ffffff                       ........

c0d077f8 <C_icon_app_bitmap>:
c0d077f8:	ffffffff f7ffffff f6fff77f f6dff43f     ............?...
c0d07808:	f7eff76f fbdff7ef fffffc3f ffffffff     o.......?.......

c0d07818 <C_icon_app>:
c0d07818:	00000010 00000010 00000001 c0d077f0     .............w..
c0d07828:	c0d077f8                                .w..

c0d0782c <C_icon_dashboard_colors>:
c0d0782c:	00000000 00ffffff                       ........

c0d07834 <C_icon_dashboard_bitmap>:
c0d07834:	00000000 f007800c ffc1fe03 03f03ff0     .............?..
c0d07844:	c03300cc 0000000c 00000000              ..3.........

c0d07850 <C_icon_dashboard>:
c0d07850:	0000000e 0000000e 00000001 c0d0782c     ............,x..
c0d07860:	c0d07834                                4x..

c0d07864 <seph_io_general_status>:
c0d07864:	00020060                                 `....

c0d07869 <seph_io_se_reset>:
c0d07869:	                                         F..

c0d0786c <g_pcHex>:
c0d0786c:	33323130 37363534 62613938 66656463     0123456789abcdef

c0d0787c <g_pcHex_cap>:
c0d0787c:	33323130 37363534 42413938 46454443     0123456789ABCDEF
c0d0788c:	7325003f 61684300 44006e69 006b636f     ?.%s.Chain.Dock.
c0d0789c:	656e6547 20736973 68736148 6e6f4e00     Genesis Hash.Non
c0d078ac:	54006563 45007069 50206172 65736168     ce.Tip.Era Phase
c0d078bc:	61724500 72655020 00646f69 636f6c42     .Era Period.Bloc
c0d078cc:	6f4e006b 72726520 4e00726f 6f6d206f     k.No error.No mo
c0d078dc:	64206572 00617461 74696e49 696c6169     re data.Initiali
c0d078ec:	2064657a 74706d65 6f632079 7865746e     zed empty contex
c0d078fc:	69640074 616c7073 64695f79 756f5f78     t.display_idx_ou
c0d0790c:	666f5f74 6e61725f 64006567 6c707369     t_of_range.displ
c0d0791c:	705f7961 5f656761 5f74756f 725f666f     ay_page_out_of_r
c0d0792c:	65676e61 65705300 65762063 6f697372     ange.Spec versio
c0d0793c:	6f6e206e 75732074 726f7070 00646574     n not supported.
c0d0794c:	206e7854 73726576 206e6f69 20746f6e     Txn version not 
c0d0795c:	70707573 6574726f 6f4e0064 6c612074     supported.Not al
c0d0796c:	65776f6c 6f4e0064 75732074 726f7070     lowed.Not suppor
c0d0797c:	00646574 78656e55 74636570 62206465     ted.Unexpected b
c0d0798c:	65666675 6e652072 6e550064 65707865     uffer end.Unexpe
c0d0799c:	64657463 6c617620 56006575 65756c61     cted value.Value
c0d079ac:	74756f20 20666f20 676e6172 61560065      out of range.Va
c0d079bc:	2065756c 206f6f74 796e616d 74796220     lue too many byt
c0d079cc:	55007365 7078656e 65746365 6f6d2064     es.Unexpected mo
c0d079dc:	656c7564 656e5500 63657078 20646574     dule.Unexpected 
c0d079ec:	6c6c6163 646e6920 55007865 7078656e     call index.Unexp
c0d079fc:	65746365 6e752064 73726170 62206465     ected unparsed b
c0d07a0c:	73657479 6c615600 63206575 6f6e6e61     ytes.Value canno
c0d07a1c:	65622074 69727020 6465746e 6c614300     t be printed.Cal
c0d07a2c:	656e206c 6e697473 6f6e2067 75732074     l nesting not su
c0d07a3c:	726f7070 00646574 2078614d 7473656e     pported.Max nest
c0d07a4c:	63206465 736c6c61 61657220 64656863     ed calls reached
c0d07a5c:	6c614300 6576206c 726f7463 63786520     .Call vector exc
c0d07a6c:	73646565 6d696c20 55007469 6365726e     eeds limit.Unrec
c0d07a7c:	696e676f 2064657a 6f727265 6f632072     ognized error co
c0d07a8c:	44006564 004b434f 65666236 63643432     de.DOCK.6bfe24dc
c0d07a9c:	33613261 30316562 32323266 37363231     a2a3be10f2221267
c0d07aac:	31636138 34366133 63653634 31343637     8ac13a6446ec7641
c0d07abc:	30633330 37343366 31376331 65393036     03c0f3471c71609e
c0d07acc:	38336361 65616134 63657300 5f746572     ac384aae.secret_
c0d07adc:	4e746567 74496d75 00736d65 4e524157     getNumItems.WARN
c0d07aec:	21474e49 45535500 20544120 52554f59     ING!.USE AT YOUR
c0d07afc:	4e574f20 53495220 2021214b 20756f59      OWN RISK!! You 
c0d07b0c:	20657261 756f6261 6f742074 616e6520     are about to ena
c0d07b1c:	20656c62 20656874 20544f44 6f636572     ble the DOT reco
c0d07b2c:	79726576 646f6d20 66492e65 756f7920     very mode.If you
c0d07b3c:	65726120 746f6e20 72757320 68772065      are not sure wh
c0d07b4c:	6f792079 72612075 65682065 202c6572     y you are here, 
c0d07b5c:	656a6572 6f207463 6e752072 67756c70     reject or unplug
c0d07b6c:	756f7920 65642072 65636976 6d6d6920      your device imm
c0d07b7c:	61696465 796c6574 7463412e 74617669     ediately.Activat
c0d07b8c:	20676e69 73696874 646f6d20 69772065     ing this mode wi
c0d07b9c:	74206c6c 6f706d65 69726172 6120796c     ll temporarily a
c0d07bac:	776f6c6c 756f7920 206f7420 6e676973     llow you to sign
c0d07bbc:	61727420 6361736e 6e6f6974 73752073      transactions us
c0d07bcc:	20676e69 6173754b 6b20616d 00737965     ing Kusama keys.
c0d07bdc:	616c6142 7365636e 61745300 676e696b     Balances.Staking
c0d07bec:	73655300 6e6f6973 69745500 7974696c     .Session.Utility
c0d07bfc:	61725400 6566736e 656b2072 61207065     .Transfer keep a
c0d07c0c:	6576696c 6e6f4200 6f420064 6520646e     live.Bond.Bond e
c0d07c1c:	61727478 626e5500 00646e6f 68746957     xtra.Unbond.With
c0d07c2c:	77617264 626e5520 65646e6f 61560064     draw Unbonded.Va
c0d07c3c:	6164696c 4e006574 6e696d6f 00657461     lidate.Nominate.
c0d07c4c:	6c696843 6553006c 61702074 00656579     Chill.Set payee.
c0d07c5c:	6f796150 73207475 656b6174 52007372     Payout stakers.R
c0d07c6c:	6e6f6265 65530064 656b2074 50007379     ebond.Set keys.P
c0d07c7c:	65677275 79656b20 61420073 00686374     urge keys.Batch.
c0d07c8c:	63746142 6c612068 6544006c 41007473     Batch all.Dest.A
c0d07c9c:	6e756f6d 6f430074 6f72746e 72656c6c     mount.Controller
c0d07cac:	79615000 4e006565 73206d75 6873616c     .Payee.Num slash
c0d07cbc:	20676e69 6e617073 72500073 00736665     ing spans.Prefs.
c0d07ccc:	67726154 00737465 696c6156 6f746164     Targets.Validato
c0d07cdc:	74732072 00687361 00617245 7379654b     r stash.Era.Keys
c0d07cec:	6f725000 4300666f 736c6c61 6c614600     .Proof.Calls.Fal
c0d07cfc:	54006573 00657572 78323025 6e6f4e00     se.True.%02x.Non
c0d07d0c:	453c0065 7974706d 7053003e 0074696c     e.<Empty>.Split.
c0d07d1c:	6e617453 64726164 636f4c00 3164656b     Standard.Locked1
c0d07d2c:	6f4c0078 64656b63 4c007832 656b636f     x.Locked2x.Locke
c0d07d3c:	00783364 6b636f4c 78346465 636f4c00     d3x.Locked4x.Loc
c0d07d4c:	3564656b 73250078 41002525 4e00796e     ked5x.%s%%.Any.N
c0d07d5c:	72546e6f 66736e61 47007265 7265766f     onTransfer.Gover
c0d07d6c:	636e616e 74530065 64656b61 61745300     nance.Staked.Sta
c0d07d7c:	30006873 0000002e                       sh.0....

c0d07d84 <USBD_HID_Desc>:
c0d07d84:	01112109 22220100                        .!...."".

c0d07d8d <HID_ReportDesc>:
c0d07d8d:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d07d9d:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d07dad:	                                         ..

c0d07daf <C_usb_bos>:
c0d07daf:	00390f05 05101802 08b63800 a009a934     ..9......8..4...
c0d07dbf:	a0fd8b47 b6158876 1e010065 05101c00     G...v...e.......
c0d07dcf:	dd60df00 c74589d8 65d29c4c 8a649e9d     ..`...E.L..e..d.
c0d07ddf:	0300009f 7700b206                        .......w.

c0d07de8 <HID_Desc>:
c0d07de8:	c0d05cad c0d05cbd c0d05ccd c0d05cdd     .\...\...\...\..
c0d07df8:	c0d05ced c0d05cfd c0d05d0d c0d05d1d     .\...\...]...]..

c0d07e08 <C_winusb_string_descriptor>:
c0d07e08:	004d0312 00460053 00310054 00300030     ..M.S.F.T.1.0.0.
c0d07e18:	                                         w.

c0d07e1a <C_winusb_guid>:
c0d07e1a:	00000092 00050100 00880001 00070000     ................
c0d07e2a:	002a0000 00650044 00690076 00650063     ..*.D.e.v.i.c.e.
c0d07e3a:	006e0049 00650074 00660072 00630061     I.n.t.e.r.f.a.c.
c0d07e4a:	00470065 00490055 00730044 00500000     e.G.U.I.D.s...P.
c0d07e5a:	007b0000 00330031 00360064 00340033     ..{.1.3.d.6.3.4.
c0d07e6a:	00300030 0032002d 00390043 002d0037     0.0.-.2.C.9.7.-.
c0d07e7a:	00300030 00340030 0030002d 00300030     0.0.0.4.-.0.0.0.
c0d07e8a:	002d0030 00630034 00350036 00340036     0.-.4.c.6.5.6.4.
c0d07e9a:	00370036 00350036 00320037 0000007d     6.7.6.5.7.2.}...
	...

c0d07eac <C_winusb_request_descriptor>:
c0d07eac:	0000000a 06030000 000800b2 00000001     ................
c0d07ebc:	000800a8 00010002 001400a0 49570003     ..............WI
c0d07ecc:	4253554e 00000000 00000000 00840000     NUSB............
c0d07edc:	00070004 0044002a 00760065 00630069     ....*.D.e.v.i.c.
c0d07eec:	00490065 0074006e 00720065 00610066     e.I.n.t.e.r.f.a.
c0d07efc:	00650063 00550047 00440049 00000073     c.e.G.U.I.D.s...
c0d07f0c:	007b0050 00450043 00300038 00320039     P.{.C.E.8.0.9.2.
c0d07f1c:	00340036 0034002d 00320042 002d0034     6.4.-.4.B.2.4.-.
c0d07f2c:	00450034 00310038 0041002d 00420038     4.E.8.1.-.A.8.B.
c0d07f3c:	002d0032 00370035 00440045 00310030     2.-.5.7.E.D.0.1.
c0d07f4c:	00350044 00300038 00310045 0000007d     D.5.8.0.E.1.}...
c0d07f5c:	00000000                                ....

c0d07f60 <USBD_HID>:
c0d07f60:	c0d05b23 c0d05b55 c0d05a8f 00000000     #[..U[...Z......
c0d07f70:	00000000 c0d05bb1 c0d05bc9 00000000     .....[...[......
	...
c0d07f88:	c0d05e2d c0d05e2d c0d05e2d c0d05e3d     -^..-^..-^..=^..

c0d07f98 <USBD_WEBUSB>:
c0d07f98:	c0d05c15 c0d05c41 c0d05c45 00000000     .\..A\..E\......
c0d07fa8:	00000000 c0d05c49 c0d05c61 00000000     ....I\..a\......
	...
c0d07fc0:	c0d05e2d c0d05e2d c0d05e2d c0d05e3d     -^..-^..-^..=^..

c0d07fd0 <USBD_DeviceDesc>:
c0d07fd0:	02100112 40000000 10112c97 02010201     .......@.,......
c0d07fe0:	                                         ..

c0d07fe2 <USBD_LangIDDesc>:
c0d07fe2:	04090304                                ....

c0d07fe6 <USBD_MANUFACTURER_STRING>:
c0d07fe6:	004c030e 00640065 00650067               ..L.e.d.g.e.r.

c0d07ff4 <USBD_PRODUCT_FS_STRING>:
c0d07ff4:	004e030e 006e0061 0020006f               ..N.a.n.o. .S.

c0d08002 <USB_SERIAL_STRING>:
c0d08002:	0030030a 00300030                        ..0.0.0.1.

c0d0800c <C_winusb_wcid>:
c0d0800c:	00000028 00040100 00000001 00000000     (...............
c0d0801c:	49570101 4253554e 00000000 00000000     ..WINUSB........
	...

c0d08034 <USBD_CfgDesc>:
c0d08034:	00400209 c0020102 00040932 00030200     ..@.....2.......
c0d08044:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d08054:	05070100 00400302 01040901 ffff0200     ......@.........
c0d08064:	050702ff 00400383 03050701 01004003     ......@......@..

c0d08074 <USBD_DeviceQualifierDesc>:
c0d08074:	0200060a 40000000 00000001              .......@....

c0d08080 <ux_menu_elements>:
c0d08080:	00008003 00800000 00000020 00000001     ........ .......
c0d08090:	00000000 00ffffff 00000000 00000000     ................
c0d080a0:	00038105 0007000e 00000004 00000000     ................
c0d080b0:	00ffffff 00000000 000b0000 00000000     ................
c0d080c0:	00768205 0007000e 00000004 00000000     ..v.............
c0d080d0:	00ffffff 00000000 000c0000 00000000     ................
c0d080e0:	000e4107 00640003 0000000c 00000000     .A....d.........
c0d080f0:	00ffffff 00000000 0000800a 00000000     ................
c0d08100:	000e4207 00640023 0000000c 00000000     .B..#.d.........
c0d08110:	00ffffff 00000000 0000800a 00000000     ................
c0d08120:	000e1005 00000009 00000000 00000000     ................
c0d08130:	00ffffff 00000000 00000000 00000000     ................
c0d08140:	000e2007 00640013 0000000c 00000000     . ....d.........
c0d08150:	00ffffff 00000000 00008008 00000000     ................
c0d08160:	000e2107 0064000c 0000000c 00000000     .!....d.........
c0d08170:	00ffffff 00000000 00008008 00000000     ................
c0d08180:	000e2207 0064001a 0000000c 00000000     ."....d.........
c0d08190:	00ffffff 00000000 00008008 00000000     ................

c0d081a0 <UX_MENU_END_ENTRY>:
	...
c0d081bc:	70615f68 766f7270 5f680065 656a6572     h_approve.h_reje
c0d081cc:	68007463 6761705f 5f676e69 74696e69     ct.h_paging_init
c0d081dc:	705f6800 6e696761 61635f67 6e695f6e     .h_paging_can_in
c0d081ec:	61657263 68006573 6761705f 5f676e69     crease.h_paging_
c0d081fc:	5f6e6163 72636e69 65736165 004f4e20     can_increase NO.
c0d0820c:	61705f68 676e6967 636e695f 73616572     h_paging_increas
c0d0821c:	5f680065 69676170 635f676e 645f6e61     e.h_paging_can_d
c0d0822c:	65726365 00657361 61705f68 676e6967     ecrease.h_paging
c0d0823c:	6e61635f 6365645f 73616572 4f4e2065     _can_decrease NO
c0d0824c:	705f6800 6e696761 65645f67 61657263     .h_paging_decrea
c0d0825c:	49206573 25207864 61700064 2d2d6567     se Idx %d.page--
c0d0826c:	65746900 002d2d6d 69746361 615f6e6f     .item--.action_a
c0d0827c:	70656363 63610074 6e6f6974 6a65725f     ccept.action_rej
c0d0828c:	00746365 63697571 6361206b 74706563     ect.quick accept
c0d0829c:	725f6800 65697665 70755f77 65746164     .h_review_update
c0d082ac:	7461645f 202d2061 4e746547 74496d75     _data - GetNumIt
c0d082bc:	3d736d65 4c554e3d 7075004c 65746164     ems==NULL.update
c0d082cc:	78644920 2f642520 73006425 5f776f68      Idx %d/%d.show_
c0d082dc:	65636361 615f7470 6f697463 202d206e     accept_action - 
c0d082ec:	65636361 69207470 006d6574 454a4552     accept item.REJE
c0d082fc:	73005443 5f776f68 656a6572 615f7463     CT.show_reject_a
c0d0830c:	6f697463 202d206e 656a6572 69207463     ction - reject i
c0d0831c:	006d6574 64255b20 5d64252f 00000000     tem. [%d/%d]....
c0d0832c:	574f4853 20474e49 41544144 70784500     SHOWING DATA.Exp
c0d0833c:	20747265 65646f6d 3276003a 2e34342e     ert mode:.v2.44.
c0d0834c:	65440030 6f6c6576 20646570 003a7962     0.Developed by:.
c0d0835c:	646e6f5a 632e7861 694c0068 736e6563     Zondax.ch.Licens
c0d0836c:	00203a65 63617041 32206568 5100302e     e: .Apache 2.0.Q
c0d0837c:	00746975 65725f68 77656976 7475625f     uit.h_review_but
c0d0838c:	5f6e6f74 7466656c 725f6800 65697665     ton_left.h_revie
c0d0839c:	75625f77 6e6f7474 6769725f 52007468     w_button_right.R
c0d083ac:	79646165 63657300 20746572 63696c63     eady.secret clic
c0d083bc:	6425206b 6976000a 725f7765 65697665     k %d..view_revie
c0d083cc:	68735f77 695f776f 006c706d              w_show_impl.

c0d083d8 <menu_main>:
	...
c0d083e4:	c0d07818 c0d07897 20000594 00000c21     .x...x..... !...
c0d083f4:	00000000 c0d06d19 00000000 c0d07818     .....m.......x..
c0d08404:	c0d08339 200005a6 00000c21 00000000     9...... !.......
	...
c0d0841c:	c0d07818 c0d07897 c0d08346 00000c21     .x...x..F...!...
c0d0842c:	00000000 c0d06d31 00000000 c0d07818     ....1m.......x..
c0d0843c:	c0d0834e c0d0835c 00000c21 00000000     N...\...!.......
	...
c0d08454:	c0d07818 c0d08366 c0d08370 00000c21     .x..f...p...!...
c0d08464:	00000000 c0d0693d 00000000 c0d07850     ....=i......Px..
c0d08474:	c0d0837b 00000000 00001d32 00000000     {.......2.......
	...

c0d0849c <view_review>:
c0d0849c:	00000003 00800000 00000020 00000001     ........ .......
c0d084ac:	00000000 00ffffff 00000000 00000000     ................
c0d084bc:	00001005 00070000 00000007 00000000     ................
c0d084cc:	00ffffff 00000000 00090000 00000000     ................
c0d084dc:	00791105 00070000 00000007 00000000     ..y.............
c0d084ec:	00ffffff 00000000 000a0000 00000000     ................
c0d084fc:	00002007 00800008 0000000b 00000000     . ..............
c0d0850c:	00ffffff 00000000 0000800a 20000594     ............... 
c0d0851c:	00002107 00800013 0000000b 00000000     .!..............
c0d0852c:	00ffffff 00000000 0000800a 200005a6     ............... 
c0d0853c:	00002207 0080001e 0000000b 00000000     ."..............
c0d0854c:	00ffffff 00000000 0000800a 200005c9     ............... 
c0d0855c:	4b434f44 43455220 5245564f 00000059     DOCK RECOVERY...
c0d0856c:	61736964 64656c62 00000000              disabled....

c0d08578 <view_error>:
c0d08578:	00000003 00800000 00000020 00000001     ........ .......
c0d08588:	00000000 00ffffff 00000000 00000000     ................
c0d08598:	00790005 00070000 00000007 00000000     ..y.............
c0d085a8:	00ffffff 00000000 00060000 00000000     ................
c0d085b8:	00002007 00800008 0000000b 00000000     . ..............
c0d085c8:	00ffffff 00000000 0000800a 20000594     ............... 
c0d085d8:	00002007 00800013 0000000b 00000000     . ..............
c0d085e8:	00ffffff 00000000 0000800a 200005a6     ............... 
c0d085f8:	00007107 0080001e 0085000b 00000000     .q..............
c0d08608:	00ffffff 00000000 0032800a 200005c9     ..........2.... 

c0d08618 <_etext>:
	...

c0d08640 <N_appmode_impl>:
	...

c0d08680 <N_appdata_impl>:
	...
