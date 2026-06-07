.class Lio/socket/engineio/parser/Base64$Decoder;
.super Lio/socket/engineio/parser/Base64$Coder;
.source "Base64.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/engineio/parser/Base64;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "Decoder"
.end annotation


# static fields
.field private static final DECODE:[I

.field private static final DECODE_WEBSAFE:[I

.field private static final EQUALS:I = -0x2

.field private static final SKIP:I = -0x1


# instance fields
.field private final alphabet:[I

.field private state:I

.field private value:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 164
    const/16 v0, 0x100

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lio/socket/engineio/parser/Base64$Decoder;->DECODE:[I

    .line 186
    const/16 v0, 0x100

    new-array v0, v0, [I

    fill-array-data v0, :array_1

    sput-object v0, Lio/socket/engineio/parser/Base64$Decoder;->DECODE_WEBSAFE:[I

    return-void

    nop

    :array_0
    .array-data 4
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        0x3e
        -0x1
        -0x1
        -0x1
        0x3f
        0x34
        0x35
        0x36
        0x37
        0x38
        0x39
        0x3a
        0x3b
        0x3c
        0x3d
        -0x1
        -0x1
        -0x1
        -0x2
        -0x1
        -0x1
        -0x1
        0x0
        0x1
        0x2
        0x3
        0x4
        0x5
        0x6
        0x7
        0x8
        0x9
        0xa
        0xb
        0xc
        0xd
        0xe
        0xf
        0x10
        0x11
        0x12
        0x13
        0x14
        0x15
        0x16
        0x17
        0x18
        0x19
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        0x1a
        0x1b
        0x1c
        0x1d
        0x1e
        0x1f
        0x20
        0x21
        0x22
        0x23
        0x24
        0x25
        0x26
        0x27
        0x28
        0x29
        0x2a
        0x2b
        0x2c
        0x2d
        0x2e
        0x2f
        0x30
        0x31
        0x32
        0x33
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
    .end array-data

    :array_1
    .array-data 4
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        0x3e
        -0x1
        -0x1
        0x34
        0x35
        0x36
        0x37
        0x38
        0x39
        0x3a
        0x3b
        0x3c
        0x3d
        -0x1
        -0x1
        -0x1
        -0x2
        -0x1
        -0x1
        -0x1
        0x0
        0x1
        0x2
        0x3
        0x4
        0x5
        0x6
        0x7
        0x8
        0x9
        0xa
        0xb
        0xc
        0xd
        0xe
        0xf
        0x10
        0x11
        0x12
        0x13
        0x14
        0x15
        0x16
        0x17
        0x18
        0x19
        -0x1
        -0x1
        -0x1
        -0x1
        0x3f
        -0x1
        0x1a
        0x1b
        0x1c
        0x1d
        0x1e
        0x1f
        0x20
        0x21
        0x22
        0x23
        0x24
        0x25
        0x26
        0x27
        0x28
        0x29
        0x2a
        0x2b
        0x2c
        0x2d
        0x2e
        0x2f
        0x30
        0x31
        0x32
        0x33
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
        -0x1
    .end array-data
.end method

.method public constructor <init>(I[B)V
    .locals 1
    .param p1, "flags"    # I
    .param p2, "output"    # [B

    .line 219
    invoke-direct {p0}, Lio/socket/engineio/parser/Base64$Coder;-><init>()V

    .line 220
    iput-object p2, p0, Lio/socket/engineio/parser/Base64$Decoder;->output:[B

    .line 221
    and-int/lit8 v0, p1, 0x8

    if-nez v0, :cond_0

    sget-object v0, Lio/socket/engineio/parser/Base64$Decoder;->DECODE:[I

    goto :goto_0

    :cond_0
    sget-object v0, Lio/socket/engineio/parser/Base64$Decoder;->DECODE_WEBSAFE:[I

    :goto_0
    iput-object v0, p0, Lio/socket/engineio/parser/Base64$Decoder;->alphabet:[I

    .line 222
    const/4 v0, 0x0

    iput v0, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 223
    iput v0, p0, Lio/socket/engineio/parser/Base64$Decoder;->value:I

    .line 224
    return-void
.end method


# virtual methods
.method public maxOutputSize(I)I
    .locals 1
    .param p1, "len"    # I

    .line 230
    mul-int/lit8 v0, p1, 0x3

    div-int/lit8 v0, v0, 0x4

    add-int/lit8 v0, v0, 0xa

    return v0
.end method

.method public process([BIIZ)Z
    .locals 11
    .param p1, "input"    # [B
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .param p4, "finish"    # Z

    .line 239
    iget v0, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    const/4 v1, 0x0

    const/4 v2, 0x6

    if-ne v0, v2, :cond_0

    return v1

    .line 240
    :cond_0
    move v0, p2

    .line 241
    .local v0, "p":I
    add-int/2addr p3, p2

    .line 247
    iget v3, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 248
    .local v3, "state":I
    iget v4, p0, Lio/socket/engineio/parser/Base64$Decoder;->value:I

    .line 249
    .local v4, "value":I
    const/4 v5, 0x0

    .line 250
    .local v5, "op":I
    iget-object v6, p0, Lio/socket/engineio/parser/Base64$Decoder;->output:[B

    .line 251
    .local v6, "output":[B
    iget-object v7, p0, Lio/socket/engineio/parser/Base64$Decoder;->alphabet:[I

    .line 252
    .local v7, "alphabet":[I
    :goto_0
    if-ge v0, p3, :cond_b

    .line 267
    if-nez v3, :cond_2

    .line 268
    :goto_1
    add-int/lit8 v8, v0, 0x4

    if-gt v8, p3, :cond_1

    aget-byte v8, p1, v0

    and-int/lit16 v8, v8, 0xff

    aget v8, v7, v8

    shl-int/lit8 v8, v8, 0x12

    add-int/lit8 v9, v0, 0x1

    aget-byte v9, p1, v9

    and-int/lit16 v9, v9, 0xff

    aget v9, v7, v9

    shl-int/lit8 v9, v9, 0xc

    or-int/2addr v8, v9

    add-int/lit8 v9, v0, 0x2

    aget-byte v9, p1, v9

    and-int/lit16 v9, v9, 0xff

    aget v9, v7, v9

    shl-int/2addr v9, v2

    or-int/2addr v8, v9

    add-int/lit8 v9, v0, 0x3

    aget-byte v9, p1, v9

    and-int/lit16 v9, v9, 0xff

    aget v9, v7, v9

    or-int/2addr v8, v9

    move v4, v8

    if-ltz v8, :cond_1

    .line 273
    add-int/lit8 v8, v5, 0x2

    int-to-byte v9, v4

    aput-byte v9, v6, v8

    .line 274
    add-int/lit8 v8, v5, 0x1

    shr-int/lit8 v9, v4, 0x8

    int-to-byte v9, v9

    aput-byte v9, v6, v8

    .line 275
    shr-int/lit8 v8, v4, 0x10

    int-to-byte v8, v8

    aput-byte v8, v6, v5

    .line 276
    add-int/lit8 v5, v5, 0x3

    .line 277
    add-int/lit8 v0, v0, 0x4

    goto :goto_1

    .line 279
    :cond_1
    if-lt v0, p3, :cond_2

    goto/16 :goto_3

    .line 285
    :cond_2
    add-int/lit8 v8, v0, 0x1

    .end local v0    # "p":I
    .local v8, "p":I
    aget-byte v0, p1, v0

    and-int/lit16 v0, v0, 0xff

    aget v0, v7, v0

    .line 286
    .local v0, "d":I
    const/4 v9, -0x2

    const/4 v10, -0x1

    packed-switch v3, :pswitch_data_0

    goto/16 :goto_2

    .line 349
    :pswitch_0
    if-eq v0, v10, :cond_a

    .line 350
    iput v2, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 351
    return v1

    .line 341
    :pswitch_1
    if-ne v0, v9, :cond_3

    .line 342
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_2

    .line 343
    :cond_3
    if-eq v0, v10, :cond_a

    .line 344
    iput v2, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 345
    return v1

    .line 320
    :pswitch_2
    if-ltz v0, :cond_4

    .line 322
    shl-int/lit8 v9, v4, 0x6

    or-int v4, v9, v0

    .line 323
    add-int/lit8 v9, v5, 0x2

    int-to-byte v10, v4

    aput-byte v10, v6, v9

    .line 324
    add-int/lit8 v9, v5, 0x1

    shr-int/lit8 v10, v4, 0x8

    int-to-byte v10, v10

    aput-byte v10, v6, v9

    .line 325
    shr-int/lit8 v9, v4, 0x10

    int-to-byte v9, v9

    aput-byte v9, v6, v5

    .line 326
    add-int/lit8 v5, v5, 0x3

    .line 327
    const/4 v3, 0x0

    goto :goto_2

    .line 328
    :cond_4
    if-ne v0, v9, :cond_5

    .line 331
    add-int/lit8 v9, v5, 0x1

    shr-int/lit8 v10, v4, 0x2

    int-to-byte v10, v10

    aput-byte v10, v6, v9

    .line 332
    shr-int/lit8 v9, v4, 0xa

    int-to-byte v9, v9

    aput-byte v9, v6, v5

    .line 333
    add-int/lit8 v5, v5, 0x2

    .line 334
    const/4 v3, 0x5

    goto :goto_2

    .line 335
    :cond_5
    if-eq v0, v10, :cond_a

    .line 336
    iput v2, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 337
    return v1

    .line 306
    :pswitch_3
    if-ltz v0, :cond_6

    .line 307
    shl-int/lit8 v9, v4, 0x6

    or-int v4, v9, v0

    .line 308
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 309
    :cond_6
    if-ne v0, v9, :cond_7

    .line 312
    add-int/lit8 v9, v5, 0x1

    .end local v5    # "op":I
    .local v9, "op":I
    shr-int/lit8 v10, v4, 0x4

    int-to-byte v10, v10

    aput-byte v10, v6, v5

    .line 313
    const/4 v3, 0x4

    move v5, v9

    goto :goto_2

    .line 314
    .end local v9    # "op":I
    .restart local v5    # "op":I
    :cond_7
    if-eq v0, v10, :cond_a

    .line 315
    iput v2, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 316
    return v1

    .line 297
    :pswitch_4
    if-ltz v0, :cond_8

    .line 298
    shl-int/lit8 v9, v4, 0x6

    or-int v4, v9, v0

    .line 299
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 300
    :cond_8
    if-eq v0, v10, :cond_a

    .line 301
    iput v2, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 302
    return v1

    .line 288
    :pswitch_5
    if-ltz v0, :cond_9

    .line 289
    move v4, v0

    .line 290
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 291
    :cond_9
    if-eq v0, v10, :cond_a

    .line 292
    iput v2, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 293
    return v1

    .line 355
    .end local v0    # "d":I
    :cond_a
    :goto_2
    move v0, v8

    goto/16 :goto_0

    .line 356
    .end local v8    # "p":I
    .local v0, "p":I
    :cond_b
    :goto_3
    const/4 v8, 0x1

    if-nez p4, :cond_c

    .line 359
    iput v3, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 360
    iput v4, p0, Lio/socket/engineio/parser/Base64$Decoder;->value:I

    .line 361
    iput v5, p0, Lio/socket/engineio/parser/Base64$Decoder;->op:I

    .line 362
    return v8

    .line 366
    :cond_c
    packed-switch v3, :pswitch_data_1

    goto :goto_4

    .line 388
    :pswitch_6
    iput v2, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 389
    return v1

    .line 383
    :pswitch_7
    add-int/lit8 v1, v5, 0x1

    .end local v5    # "op":I
    .local v1, "op":I
    shr-int/lit8 v2, v4, 0xa

    int-to-byte v2, v2

    aput-byte v2, v6, v5

    .line 384
    add-int/lit8 v5, v1, 0x1

    .end local v1    # "op":I
    .restart local v5    # "op":I
    shr-int/lit8 v2, v4, 0x2

    int-to-byte v2, v2

    aput-byte v2, v6, v1

    .line 385
    goto :goto_4

    .line 378
    :pswitch_8
    add-int/lit8 v1, v5, 0x1

    .end local v5    # "op":I
    .restart local v1    # "op":I
    shr-int/lit8 v2, v4, 0x4

    int-to-byte v2, v2

    aput-byte v2, v6, v5

    .line 379
    move v5, v1

    goto :goto_4

    .line 373
    .end local v1    # "op":I
    .restart local v5    # "op":I
    :pswitch_9
    iput v2, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 374
    return v1

    .line 369
    :pswitch_a
    nop

    .line 395
    :goto_4
    iput v3, p0, Lio/socket/engineio/parser/Base64$Decoder;->state:I

    .line 396
    iput v5, p0, Lio/socket/engineio/parser/Base64$Decoder;->op:I

    .line 397
    return v8

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
    .end packed-switch
.end method
