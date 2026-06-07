.class public Landroidx/core/view/WindowInsetsCompat;
.super Ljava/lang/Object;
.source "WindowInsetsCompat.java"


# instance fields
.field private final mInsets:Ljava/lang/Object;


# direct methods
.method public constructor <init>(Landroidx/core/view/WindowInsetsCompat;)V
    .locals 2
    .param p1, "src"    # Landroidx/core/view/WindowInsetsCompat;

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 62
    nop

    .line 63
    if-nez p1, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/view/WindowInsets;

    iget-object v1, p1, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v1, Landroid/view/WindowInsets;

    invoke-direct {v0, v1}, Landroid/view/WindowInsets;-><init>(Landroid/view/WindowInsets;)V

    :goto_0
    iput-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    .line 67
    return-void
.end method

.method constructor <init>(Ljava/lang/Object;)V
    .locals 0
    .param p1, "insets"    # Ljava/lang/Object;

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 53
    iput-object p1, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    .line 54
    return-void
.end method

.method public static toWindowInsetsCompat(Landroid/view/WindowInsets;)Landroidx/core/view/WindowInsetsCompat;
    .locals 2
    .param p0, "insets"    # Landroid/view/WindowInsets;

    .line 542
    new-instance v0, Landroidx/core/view/WindowInsetsCompat;

    invoke-static {p0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/core/view/WindowInsetsCompat;-><init>(Ljava/lang/Object;)V

    return-object v0
.end method


# virtual methods
.method public consumeDisplayCutout()Landroidx/core/view/WindowInsetsCompat;
    .locals 2

    .line 385
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    .line 386
    new-instance v0, Landroidx/core/view/WindowInsetsCompat;

    iget-object v1, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v1, Landroid/view/WindowInsets;

    invoke-virtual {v1}, Landroid/view/WindowInsets;->consumeDisplayCutout()Landroid/view/WindowInsets;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/core/view/WindowInsetsCompat;-><init>(Ljava/lang/Object;)V

    return-object v0

    .line 388
    :cond_0
    return-object p0
.end method

.method public consumeStableInsets()Landroidx/core/view/WindowInsetsCompat;
    .locals 2

    .line 357
    nop

    .line 358
    new-instance v0, Landroidx/core/view/WindowInsetsCompat;

    iget-object v1, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v1, Landroid/view/WindowInsets;

    invoke-virtual {v1}, Landroid/view/WindowInsets;->consumeStableInsets()Landroid/view/WindowInsets;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/core/view/WindowInsetsCompat;-><init>(Ljava/lang/Object;)V

    return-object v0
.end method

.method public consumeSystemWindowInsets()Landroidx/core/view/WindowInsetsCompat;
    .locals 2

    .line 212
    nop

    .line 213
    new-instance v0, Landroidx/core/view/WindowInsetsCompat;

    iget-object v1, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v1, Landroid/view/WindowInsets;

    invoke-virtual {v1}, Landroid/view/WindowInsets;->consumeSystemWindowInsets()Landroid/view/WindowInsets;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/core/view/WindowInsetsCompat;-><init>(Ljava/lang/Object;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 507
    if-ne p0, p1, :cond_0

    .line 508
    const/4 v0, 0x1

    return v0

    .line 510
    :cond_0
    instance-of v0, p1, Landroidx/core/view/WindowInsetsCompat;

    if-nez v0, :cond_1

    .line 511
    const/4 v0, 0x0

    return v0

    .line 513
    :cond_1
    move-object v0, p1

    check-cast v0, Landroidx/core/view/WindowInsetsCompat;

    .line 514
    .local v0, "other":Landroidx/core/view/WindowInsetsCompat;
    iget-object v1, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    iget-object v2, v0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    invoke-static {v1, v2}, Landroidx/core/util/ObjectsCompat;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public getDisplayCutout()Landroidx/core/view/DisplayCutoutCompat;
    .locals 2

    .line 372
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    .line 373
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getDisplayCutout()Landroid/view/DisplayCutout;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/view/DisplayCutoutCompat;->wrap(Ljava/lang/Object;)Landroidx/core/view/DisplayCutoutCompat;

    move-result-object v0

    return-object v0

    .line 375
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getMandatorySystemGestureInsets()Landroidx/core/graphics/Insets;
    .locals 2

    .line 453
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_0

    .line 454
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getMandatorySystemGestureInsets()Landroid/graphics/Insets;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/graphics/Insets;->wrap(Landroid/graphics/Insets;)Landroidx/core/graphics/Insets;

    move-result-object v0

    return-object v0

    .line 457
    :cond_0
    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getSystemWindowInsets()Landroidx/core/graphics/Insets;

    move-result-object v0

    return-object v0
.end method

.method public getStableInsetBottom()I
    .locals 1

    .line 325
    nop

    .line 326
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getStableInsetBottom()I

    move-result v0

    return v0
.end method

.method public getStableInsetLeft()I
    .locals 1

    .line 286
    nop

    .line 287
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getStableInsetLeft()I

    move-result v0

    return v0
.end method

.method public getStableInsetRight()I
    .locals 1

    .line 305
    nop

    .line 306
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getStableInsetRight()I

    move-result v0

    return v0
.end method

.method public getStableInsetTop()I
    .locals 1

    .line 267
    nop

    .line 268
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getStableInsetTop()I

    move-result v0

    return v0
.end method

.method public getStableInsets()Landroidx/core/graphics/Insets;
    .locals 4

    .line 433
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_0

    .line 434
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getStableInsets()Landroid/graphics/Insets;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/graphics/Insets;->wrap(Landroid/graphics/Insets;)Landroidx/core/graphics/Insets;

    move-result-object v0

    return-object v0

    .line 437
    :cond_0
    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getStableInsetLeft()I

    move-result v0

    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getStableInsetTop()I

    move-result v1

    .line 438
    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getStableInsetRight()I

    move-result v2

    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getStableInsetBottom()I

    move-result v3

    .line 437
    invoke-static {v0, v1, v2, v3}, Landroidx/core/graphics/Insets;->of(IIII)Landroidx/core/graphics/Insets;

    move-result-object v0

    return-object v0
.end method

.method public getSystemGestureInsets()Landroidx/core/graphics/Insets;
    .locals 2

    .line 497
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_0

    .line 498
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getSystemGestureInsets()Landroid/graphics/Insets;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/graphics/Insets;->wrap(Landroid/graphics/Insets;)Landroidx/core/graphics/Insets;

    move-result-object v0

    return-object v0

    .line 501
    :cond_0
    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getSystemWindowInsets()Landroidx/core/graphics/Insets;

    move-result-object v0

    return-object v0
.end method

.method public getSystemWindowInsetBottom()I
    .locals 1

    .line 130
    nop

    .line 131
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getSystemWindowInsetBottom()I

    move-result v0

    return v0
.end method

.method public getSystemWindowInsetLeft()I
    .locals 1

    .line 79
    nop

    .line 80
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getSystemWindowInsetLeft()I

    move-result v0

    return v0
.end method

.method public getSystemWindowInsetRight()I
    .locals 1

    .line 113
    nop

    .line 114
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getSystemWindowInsetRight()I

    move-result v0

    return v0
.end method

.method public getSystemWindowInsetTop()I
    .locals 1

    .line 96
    nop

    .line 97
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getSystemWindowInsetTop()I

    move-result v0

    return v0
.end method

.method public getSystemWindowInsets()Landroidx/core/graphics/Insets;
    .locals 4

    .line 407
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_0

    .line 408
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getSystemWindowInsets()Landroid/graphics/Insets;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/graphics/Insets;->wrap(Landroid/graphics/Insets;)Landroidx/core/graphics/Insets;

    move-result-object v0

    return-object v0

    .line 411
    :cond_0
    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getSystemWindowInsetLeft()I

    move-result v0

    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getSystemWindowInsetTop()I

    move-result v1

    .line 412
    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getSystemWindowInsetRight()I

    move-result v2

    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getSystemWindowInsetBottom()I

    move-result v3

    .line 411
    invoke-static {v0, v1, v2, v3}, Landroidx/core/graphics/Insets;->of(IIII)Landroidx/core/graphics/Insets;

    move-result-object v0

    return-object v0
.end method

.method public getTappableElementInsets()Landroidx/core/graphics/Insets;
    .locals 2

    .line 474
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_0

    .line 475
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->getTappableElementInsets()Landroid/graphics/Insets;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/graphics/Insets;->wrap(Landroid/graphics/Insets;)Landroidx/core/graphics/Insets;

    move-result-object v0

    return-object v0

    .line 478
    :cond_0
    invoke-virtual {p0}, Landroidx/core/view/WindowInsetsCompat;->getSystemWindowInsets()Landroidx/core/graphics/Insets;

    move-result-object v0

    return-object v0
.end method

.method public hasInsets()Z
    .locals 1

    .line 160
    nop

    .line 161
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->hasInsets()Z

    move-result v0

    return v0
.end method

.method public hasStableInsets()Z
    .locals 1

    .line 344
    nop

    .line 345
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->hasStableInsets()Z

    move-result v0

    return v0
.end method

.method public hasSystemWindowInsets()Z
    .locals 1

    .line 147
    nop

    .line 148
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->hasSystemWindowInsets()Z

    move-result v0

    return v0
.end method

.method public hashCode()I
    .locals 1

    .line 519
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    :goto_0
    return v0
.end method

.method public isConsumed()Z
    .locals 1

    .line 181
    nop

    .line 182
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->isConsumed()Z

    move-result v0

    return v0
.end method

.method public isRound()Z
    .locals 1

    .line 199
    nop

    .line 200
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    invoke-virtual {v0}, Landroid/view/WindowInsets;->isRound()Z

    move-result v0

    return v0
.end method

.method public replaceSystemWindowInsets(IIII)Landroidx/core/view/WindowInsetsCompat;
    .locals 2
    .param p1, "left"    # I
    .param p2, "top"    # I
    .param p3, "right"    # I
    .param p4, "bottom"    # I

    .line 230
    nop

    .line 231
    new-instance v0, Landroidx/core/view/WindowInsetsCompat;

    iget-object v1, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v1, Landroid/view/WindowInsets;

    .line 232
    invoke-virtual {v1, p1, p2, p3, p4}, Landroid/view/WindowInsets;->replaceSystemWindowInsets(IIII)Landroid/view/WindowInsets;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/core/view/WindowInsetsCompat;-><init>(Ljava/lang/Object;)V

    .line 231
    return-object v0
.end method

.method public replaceSystemWindowInsets(Landroid/graphics/Rect;)Landroidx/core/view/WindowInsetsCompat;
    .locals 2
    .param p1, "systemWindowInsets"    # Landroid/graphics/Rect;

    .line 247
    nop

    .line 248
    new-instance v0, Landroidx/core/view/WindowInsetsCompat;

    iget-object v1, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v1, Landroid/view/WindowInsets;

    .line 249
    invoke-virtual {v1, p1}, Landroid/view/WindowInsets;->replaceSystemWindowInsets(Landroid/graphics/Rect;)Landroid/view/WindowInsets;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/core/view/WindowInsetsCompat;-><init>(Ljava/lang/Object;)V

    .line 248
    return-object v0
.end method

.method public toWindowInsets()Landroid/view/WindowInsets;
    .locals 1

    .line 530
    iget-object v0, p0, Landroidx/core/view/WindowInsetsCompat;->mInsets:Ljava/lang/Object;

    check-cast v0, Landroid/view/WindowInsets;

    return-object v0
.end method
