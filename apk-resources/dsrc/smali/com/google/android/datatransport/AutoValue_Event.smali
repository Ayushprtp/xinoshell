.class final Lcom/google/android/datatransport/AutoValue_Event;
.super Lcom/google/android/datatransport/Event;
.source "AutoValue_Event.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/google/android/datatransport/Event<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private final code:Ljava/lang/Integer;

.field private final payload:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field

.field private final priority:Lcom/google/android/datatransport/Priority;

.field private final productData:Lcom/google/android/datatransport/ProductData;


# direct methods
.method constructor <init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V
    .locals 2
    .param p1, "code"    # Ljava/lang/Integer;
    .param p3, "priority"    # Lcom/google/android/datatransport/Priority;
    .param p4, "productData"    # Lcom/google/android/datatransport/ProductData;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Integer;",
            "TT;",
            "Lcom/google/android/datatransport/Priority;",
            "Lcom/google/android/datatransport/ProductData;",
            ")V"
        }
    .end annotation

    .line 22
    .local p0, "this":Lcom/google/android/datatransport/AutoValue_Event;, "Lcom/google/android/datatransport/AutoValue_Event<TT;>;"
    .local p2, "payload":Ljava/lang/Object;, "TT;"
    invoke-direct {p0}, Lcom/google/android/datatransport/Event;-><init>()V

    .line 23
    iput-object p1, p0, Lcom/google/android/datatransport/AutoValue_Event;->code:Ljava/lang/Integer;

    .line 24
    if-eqz p2, :cond_1

    .line 27
    iput-object p2, p0, Lcom/google/android/datatransport/AutoValue_Event;->payload:Ljava/lang/Object;

    .line 28
    if-eqz p3, :cond_0

    .line 31
    iput-object p3, p0, Lcom/google/android/datatransport/AutoValue_Event;->priority:Lcom/google/android/datatransport/Priority;

    .line 32
    iput-object p4, p0, Lcom/google/android/datatransport/AutoValue_Event;->productData:Lcom/google/android/datatransport/ProductData;

    .line 33
    return-void

    .line 29
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "Null priority"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 25
    :cond_1
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "Null payload"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 69
    .local p0, "this":Lcom/google/android/datatransport/AutoValue_Event;, "Lcom/google/android/datatransport/AutoValue_Event<TT;>;"
    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    .line 70
    return v0

    .line 72
    :cond_0
    instance-of v1, p1, Lcom/google/android/datatransport/Event;

    const/4 v2, 0x0

    if-eqz v1, :cond_4

    .line 73
    move-object v1, p1

    check-cast v1, Lcom/google/android/datatransport/Event;

    .line 74
    .local v1, "that":Lcom/google/android/datatransport/Event;, "Lcom/google/android/datatransport/Event<*>;"
    iget-object v3, p0, Lcom/google/android/datatransport/AutoValue_Event;->code:Ljava/lang/Integer;

    if-nez v3, :cond_1

    invoke-virtual {v1}, Lcom/google/android/datatransport/Event;->getCode()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_0

    :cond_1
    iget-object v3, p0, Lcom/google/android/datatransport/AutoValue_Event;->code:Ljava/lang/Integer;

    invoke-virtual {v1}, Lcom/google/android/datatransport/Event;->getCode()Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    :goto_0
    iget-object v3, p0, Lcom/google/android/datatransport/AutoValue_Event;->payload:Ljava/lang/Object;

    .line 75
    invoke-virtual {v1}, Lcom/google/android/datatransport/Event;->getPayload()Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lcom/google/android/datatransport/AutoValue_Event;->priority:Lcom/google/android/datatransport/Priority;

    .line 76
    invoke-virtual {v1}, Lcom/google/android/datatransport/Event;->getPriority()Lcom/google/android/datatransport/Priority;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/google/android/datatransport/Priority;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lcom/google/android/datatransport/AutoValue_Event;->productData:Lcom/google/android/datatransport/ProductData;

    if-nez v3, :cond_2

    .line 77
    invoke-virtual {v1}, Lcom/google/android/datatransport/Event;->getProductData()Lcom/google/android/datatransport/ProductData;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_1

    :cond_2
    iget-object v3, p0, Lcom/google/android/datatransport/AutoValue_Event;->productData:Lcom/google/android/datatransport/ProductData;

    invoke-virtual {v1}, Lcom/google/android/datatransport/Event;->getProductData()Lcom/google/android/datatransport/ProductData;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    :goto_1
    goto :goto_2

    :cond_3
    move v0, v2

    .line 74
    :goto_2
    return v0

    .line 79
    .end local v1    # "that":Lcom/google/android/datatransport/Event;, "Lcom/google/android/datatransport/Event<*>;"
    :cond_4
    return v2
.end method

.method public getCode()Ljava/lang/Integer;
    .locals 1

    .line 38
    .local p0, "this":Lcom/google/android/datatransport/AutoValue_Event;, "Lcom/google/android/datatransport/AutoValue_Event<TT;>;"
    iget-object v0, p0, Lcom/google/android/datatransport/AutoValue_Event;->code:Ljava/lang/Integer;

    return-object v0
.end method

.method public getPayload()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .line 43
    .local p0, "this":Lcom/google/android/datatransport/AutoValue_Event;, "Lcom/google/android/datatransport/AutoValue_Event<TT;>;"
    iget-object v0, p0, Lcom/google/android/datatransport/AutoValue_Event;->payload:Ljava/lang/Object;

    return-object v0
.end method

.method public getPriority()Lcom/google/android/datatransport/Priority;
    .locals 1

    .line 48
    .local p0, "this":Lcom/google/android/datatransport/AutoValue_Event;, "Lcom/google/android/datatransport/AutoValue_Event<TT;>;"
    iget-object v0, p0, Lcom/google/android/datatransport/AutoValue_Event;->priority:Lcom/google/android/datatransport/Priority;

    return-object v0
.end method

.method public getProductData()Lcom/google/android/datatransport/ProductData;
    .locals 1

    .line 54
    .local p0, "this":Lcom/google/android/datatransport/AutoValue_Event;, "Lcom/google/android/datatransport/AutoValue_Event<TT;>;"
    iget-object v0, p0, Lcom/google/android/datatransport/AutoValue_Event;->productData:Lcom/google/android/datatransport/ProductData;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 84
    .local p0, "this":Lcom/google/android/datatransport/AutoValue_Event;, "Lcom/google/android/datatransport/AutoValue_Event<TT;>;"
    const/4 v0, 0x1

    .line 85
    .local v0, "h$":I
    const v1, 0xf4243

    mul-int/2addr v0, v1

    .line 86
    iget-object v2, p0, Lcom/google/android/datatransport/AutoValue_Event;->code:Ljava/lang/Integer;

    const/4 v3, 0x0

    if-nez v2, :cond_0

    move v2, v3

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lcom/google/android/datatransport/AutoValue_Event;->code:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->hashCode()I

    move-result v2

    :goto_0
    xor-int/2addr v0, v2

    .line 87
    mul-int/2addr v0, v1

    .line 88
    iget-object v2, p0, Lcom/google/android/datatransport/AutoValue_Event;->payload:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    xor-int/2addr v0, v2

    .line 89
    mul-int/2addr v0, v1

    .line 90
    iget-object v2, p0, Lcom/google/android/datatransport/AutoValue_Event;->priority:Lcom/google/android/datatransport/Priority;

    invoke-virtual {v2}, Lcom/google/android/datatransport/Priority;->hashCode()I

    move-result v2

    xor-int/2addr v0, v2

    .line 91
    mul-int/2addr v0, v1

    .line 92
    iget-object v1, p0, Lcom/google/android/datatransport/AutoValue_Event;->productData:Lcom/google/android/datatransport/ProductData;

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    iget-object v1, p0, Lcom/google/android/datatransport/AutoValue_Event;->productData:Lcom/google/android/datatransport/ProductData;

    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_1
    xor-int/2addr v0, v3

    .line 93
    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 59
    .local p0, "this":Lcom/google/android/datatransport/AutoValue_Event;, "Lcom/google/android/datatransport/AutoValue_Event<TT;>;"
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Event{code="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/google/android/datatransport/AutoValue_Event;->code:Ljava/lang/Integer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", payload="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/google/android/datatransport/AutoValue_Event;->payload:Ljava/lang/Object;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", priority="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/google/android/datatransport/AutoValue_Event;->priority:Lcom/google/android/datatransport/Priority;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", productData="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/google/android/datatransport/AutoValue_Event;->productData:Lcom/google/android/datatransport/ProductData;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
