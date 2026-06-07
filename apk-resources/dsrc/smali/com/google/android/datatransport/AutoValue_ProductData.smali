.class final Lcom/google/android/datatransport/AutoValue_ProductData;
.super Lcom/google/android/datatransport/ProductData;
.source "AutoValue_ProductData.java"


# instance fields
.field private final productId:Ljava/lang/Integer;


# direct methods
.method constructor <init>(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "productId"    # Ljava/lang/Integer;

    .line 13
    invoke-direct {p0}, Lcom/google/android/datatransport/ProductData;-><init>()V

    .line 14
    iput-object p1, p0, Lcom/google/android/datatransport/AutoValue_ProductData;->productId:Ljava/lang/Integer;

    .line 15
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4
    .param p1, "o"    # Ljava/lang/Object;

    .line 32
    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    .line 33
    return v0

    .line 35
    :cond_0
    instance-of v1, p1, Lcom/google/android/datatransport/ProductData;

    const/4 v2, 0x0

    if-eqz v1, :cond_3

    .line 36
    move-object v1, p1

    check-cast v1, Lcom/google/android/datatransport/ProductData;

    .line 37
    .local v1, "that":Lcom/google/android/datatransport/ProductData;
    iget-object v3, p0, Lcom/google/android/datatransport/AutoValue_ProductData;->productId:Ljava/lang/Integer;

    if-nez v3, :cond_2

    invoke-virtual {v1}, Lcom/google/android/datatransport/ProductData;->getProductId()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_0

    :cond_1
    move v0, v2

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/google/android/datatransport/AutoValue_ProductData;->productId:Ljava/lang/Integer;

    invoke-virtual {v1}, Lcom/google/android/datatransport/ProductData;->getProductId()Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v0

    :goto_0
    return v0

    .line 39
    .end local v1    # "that":Lcom/google/android/datatransport/ProductData;
    :cond_3
    return v2
.end method

.method public getProductId()Ljava/lang/Integer;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/google/android/datatransport/AutoValue_ProductData;->productId:Ljava/lang/Integer;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .line 44
    const/4 v0, 0x1

    .line 45
    .local v0, "h$":I
    const v1, 0xf4243

    mul-int/2addr v0, v1

    .line 46
    iget-object v1, p0, Lcom/google/android/datatransport/AutoValue_ProductData;->productId:Ljava/lang/Integer;

    if-nez v1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/google/android/datatransport/AutoValue_ProductData;->productId:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->hashCode()I

    move-result v1

    :goto_0
    xor-int/2addr v0, v1

    .line 47
    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 25
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ProductData{productId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/google/android/datatransport/AutoValue_ProductData;->productId:Ljava/lang/Integer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
