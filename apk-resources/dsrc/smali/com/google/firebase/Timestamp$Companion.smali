.class public final Lcom/google/firebase/Timestamp$Companion;
.super Ljava/lang/Object;
.source "Timestamp.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/firebase/Timestamp;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00002\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0010\t\n\u0002\u0010\u0008\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\t\u0008\u0002\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J\u0008\u0010\u0007\u001a\u00020\u0006H\u0007J\u0018\u0010\u0008\u001a\u000e\u0012\u0004\u0012\u00020\n\u0012\u0004\u0012\u00020\u000b0\t*\u00020\u000cH\u0002J\u0018\u0010\r\u001a\u00020\u000e2\u0006\u0010\u000f\u001a\u00020\n2\u0006\u0010\u0010\u001a\u00020\u000bH\u0002R\u0016\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u00058\u0006X\u0087\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/google/firebase/Timestamp$Companion;",
        "",
        "<init>",
        "()V",
        "CREATOR",
        "Landroid/os/Parcelable$Creator;",
        "Lcom/google/firebase/Timestamp;",
        "now",
        "toPreciseTime",
        "Lkotlin/Pair;",
        "",
        "",
        "Ljava/util/Date;",
        "validateRange",
        "",
        "seconds",
        "nanoseconds",
        "com.google.firebase-firebase-common"
    }
    k = 0x1
    mv = {
        0x2,
        0x0,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 103
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/google/firebase/Timestamp$Companion;-><init>()V

    return-void
.end method

.method public static final synthetic access$toPreciseTime(Lcom/google/firebase/Timestamp$Companion;Ljava/util/Date;)Lkotlin/Pair;
    .locals 1
    .param p0, "$this"    # Lcom/google/firebase/Timestamp$Companion;
    .param p1, "$receiver"    # Ljava/util/Date;

    .line 103
    invoke-direct {p0, p1}, Lcom/google/firebase/Timestamp$Companion;->toPreciseTime(Ljava/util/Date;)Lkotlin/Pair;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$validateRange(Lcom/google/firebase/Timestamp$Companion;JI)V
    .locals 0
    .param p0, "$this"    # Lcom/google/firebase/Timestamp$Companion;
    .param p1, "seconds"    # J
    .param p3, "nanoseconds"    # I

    .line 103
    invoke-direct {p0, p1, p2, p3}, Lcom/google/firebase/Timestamp$Companion;->validateRange(JI)V

    return-void
.end method

.method private final toPreciseTime(Ljava/util/Date;)Lkotlin/Pair;
    .locals 6
    .param p1, "$this$toPreciseTime"    # Ljava/util/Date;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Date;",
            ")",
            "Lkotlin/Pair<",
            "Ljava/lang/Long;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 115
    invoke-virtual {p1}, Ljava/util/Date;->getTime()J

    move-result-wide v0

    const/16 v2, 0x3e8

    int-to-long v2, v2

    div-long/2addr v0, v2

    .line 116
    .local v0, "seconds":J
    invoke-virtual {p1}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    rem-long/2addr v4, v2

    const v2, 0xf4240

    int-to-long v2, v2

    mul-long/2addr v4, v2

    long-to-int v2, v4

    .line 118
    .local v2, "nanoseconds":I
    if-gez v2, :cond_0

    const-wide/16 v3, 0x1

    sub-long v3, v0, v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    const v4, 0x3b9aca00

    add-int/2addr v4, v2

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v3, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    return-object v3

    .line 120
    :cond_0
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v3, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v3

    return-object v3
.end method

.method private final validateRange(JI)V
    .locals 4
    .param p1, "seconds"    # J
    .param p3, "nanoseconds"    # I

    .line 134
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-ltz p3, :cond_0

    const v2, 0x3b9aca00

    if-ge p3, v2, :cond_0

    move v2, v0

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    if-eqz v2, :cond_3

    .line 138
    const-wide v2, -0xe7791f700L

    cmp-long v2, v2, p1

    if-gtz v2, :cond_1

    const-wide v2, 0x3afff44180L

    cmp-long v2, p1, v2

    if-gez v2, :cond_1

    goto :goto_1

    :cond_1
    move v0, v1

    :goto_1
    if-eqz v0, :cond_2

    .line 141
    return-void

    .line 138
    :cond_2
    const/4 v0, 0x0

    .line 139
    .local v0, "$i$a$-require-Timestamp$Companion$validateRange$2":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Timestamp seconds out of range: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 138
    .end local v0    # "$i$a$-require-Timestamp$Companion$validateRange$2":I
    new-instance v1, Ljava/lang/IllegalArgumentException;

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 134
    :cond_3
    const/4 v0, 0x0

    .line 135
    .local v0, "$i$a$-require-Timestamp$Companion$validateRange$1":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Timestamp nanoseconds out of range: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 134
    .end local v0    # "$i$a$-require-Timestamp$Companion$validateRange$1":I
    new-instance v1, Ljava/lang/IllegalArgumentException;

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method


# virtual methods
.method public final now()Lcom/google/firebase/Timestamp;
    .locals 2
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 112
    new-instance v0, Lcom/google/firebase/Timestamp;

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-direct {v0, v1}, Lcom/google/firebase/Timestamp;-><init>(Ljava/util/Date;)V

    return-object v0
.end method
