.class public abstract Lcom/google/android/datatransport/Event;
.super Ljava/lang/Object;
.source "Event.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 21
    .local p0, "this":Lcom/google/android/datatransport/Event;, "Lcom/google/android/datatransport/Event<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static ofData(ILjava/lang/Object;)Lcom/google/android/datatransport/Event;
    .locals 4
    .param p0, "code"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(ITT;)",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 37
    .local p1, "payload":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    sget-object v2, Lcom/google/android/datatransport/Priority;->DEFAULT:Lcom/google/android/datatransport/Priority;

    const/4 v3, 0x0

    invoke-direct {v0, v1, p1, v2, v3}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofData(ILjava/lang/Object;Lcom/google/android/datatransport/ProductData;)Lcom/google/android/datatransport/Event;
    .locals 3
    .param p0, "code"    # I
    .param p2, "productData"    # Lcom/google/android/datatransport/ProductData;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(ITT;",
            "Lcom/google/android/datatransport/ProductData;",
            ")",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 33
    .local p1, "payload":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    sget-object v2, Lcom/google/android/datatransport/Priority;->DEFAULT:Lcom/google/android/datatransport/Priority;

    invoke-direct {v0, v1, p1, v2, p2}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofData(Ljava/lang/Object;)Lcom/google/android/datatransport/Event;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;)",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 45
    .local p0, "payload":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    const/4 v1, 0x0

    sget-object v2, Lcom/google/android/datatransport/Priority;->DEFAULT:Lcom/google/android/datatransport/Priority;

    invoke-direct {v0, v1, p0, v2, v1}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofData(Ljava/lang/Object;Lcom/google/android/datatransport/ProductData;)Lcom/google/android/datatransport/Event;
    .locals 3
    .param p1, "productData"    # Lcom/google/android/datatransport/ProductData;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;",
            "Lcom/google/android/datatransport/ProductData;",
            ")",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 41
    .local p0, "payload":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    const/4 v1, 0x0

    sget-object v2, Lcom/google/android/datatransport/Priority;->DEFAULT:Lcom/google/android/datatransport/Priority;

    invoke-direct {v0, v1, p0, v2, p1}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofTelemetry(ILjava/lang/Object;)Lcom/google/android/datatransport/Event;
    .locals 4
    .param p0, "code"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(ITT;)",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 53
    .local p1, "value":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    sget-object v2, Lcom/google/android/datatransport/Priority;->VERY_LOW:Lcom/google/android/datatransport/Priority;

    const/4 v3, 0x0

    invoke-direct {v0, v1, p1, v2, v3}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofTelemetry(ILjava/lang/Object;Lcom/google/android/datatransport/ProductData;)Lcom/google/android/datatransport/Event;
    .locals 3
    .param p0, "code"    # I
    .param p2, "productData"    # Lcom/google/android/datatransport/ProductData;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(ITT;",
            "Lcom/google/android/datatransport/ProductData;",
            ")",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 49
    .local p1, "value":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    sget-object v2, Lcom/google/android/datatransport/Priority;->VERY_LOW:Lcom/google/android/datatransport/Priority;

    invoke-direct {v0, v1, p1, v2, p2}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofTelemetry(Ljava/lang/Object;)Lcom/google/android/datatransport/Event;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;)",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 61
    .local p0, "value":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    const/4 v1, 0x0

    sget-object v2, Lcom/google/android/datatransport/Priority;->VERY_LOW:Lcom/google/android/datatransport/Priority;

    invoke-direct {v0, v1, p0, v2, v1}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofTelemetry(Ljava/lang/Object;Lcom/google/android/datatransport/ProductData;)Lcom/google/android/datatransport/Event;
    .locals 3
    .param p1, "productData"    # Lcom/google/android/datatransport/ProductData;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;",
            "Lcom/google/android/datatransport/ProductData;",
            ")",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 57
    .local p0, "value":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    const/4 v1, 0x0

    sget-object v2, Lcom/google/android/datatransport/Priority;->VERY_LOW:Lcom/google/android/datatransport/Priority;

    invoke-direct {v0, v1, p0, v2, p1}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofUrgent(ILjava/lang/Object;)Lcom/google/android/datatransport/Event;
    .locals 4
    .param p0, "code"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(ITT;)",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 69
    .local p1, "value":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    sget-object v2, Lcom/google/android/datatransport/Priority;->HIGHEST:Lcom/google/android/datatransport/Priority;

    const/4 v3, 0x0

    invoke-direct {v0, v1, p1, v2, v3}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofUrgent(ILjava/lang/Object;Lcom/google/android/datatransport/ProductData;)Lcom/google/android/datatransport/Event;
    .locals 3
    .param p0, "code"    # I
    .param p2, "productData"    # Lcom/google/android/datatransport/ProductData;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(ITT;",
            "Lcom/google/android/datatransport/ProductData;",
            ")",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 65
    .local p1, "value":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    sget-object v2, Lcom/google/android/datatransport/Priority;->HIGHEST:Lcom/google/android/datatransport/Priority;

    invoke-direct {v0, v1, p1, v2, p2}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofUrgent(Ljava/lang/Object;)Lcom/google/android/datatransport/Event;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;)",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 77
    .local p0, "value":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    const/4 v1, 0x0

    sget-object v2, Lcom/google/android/datatransport/Priority;->HIGHEST:Lcom/google/android/datatransport/Priority;

    invoke-direct {v0, v1, p0, v2, v1}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method

.method public static ofUrgent(Ljava/lang/Object;Lcom/google/android/datatransport/ProductData;)Lcom/google/android/datatransport/Event;
    .locals 3
    .param p1, "productData"    # Lcom/google/android/datatransport/ProductData;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;",
            "Lcom/google/android/datatransport/ProductData;",
            ")",
            "Lcom/google/android/datatransport/Event<",
            "TT;>;"
        }
    .end annotation

    .line 73
    .local p0, "value":Ljava/lang/Object;, "TT;"
    new-instance v0, Lcom/google/android/datatransport/AutoValue_Event;

    const/4 v1, 0x0

    sget-object v2, Lcom/google/android/datatransport/Priority;->HIGHEST:Lcom/google/android/datatransport/Priority;

    invoke-direct {v0, v1, p0, v2, p1}, Lcom/google/android/datatransport/AutoValue_Event;-><init>(Ljava/lang/Integer;Ljava/lang/Object;Lcom/google/android/datatransport/Priority;Lcom/google/android/datatransport/ProductData;)V

    return-object v0
.end method


# virtual methods
.method public abstract getCode()Ljava/lang/Integer;
.end method

.method public abstract getPayload()Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation
.end method

.method public abstract getPriority()Lcom/google/android/datatransport/Priority;
.end method

.method public abstract getProductData()Lcom/google/android/datatransport/ProductData;
.end method
