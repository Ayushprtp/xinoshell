.class final Lcom/google/firebase/logger/Logger$AndroidLogger;
.super Lcom/google/firebase/logger/Logger;
.source "Logger.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/firebase/logger/Logger;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "AndroidLogger"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/firebase/logger/Logger$AndroidLogger$WhenMappings;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nLogger.kt\nKotlin\n*S Kotlin\n*F\n+ 1 Logger.kt\ncom/google/firebase/logger/Logger$AndroidLogger\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,196:1\n1#2:197\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00008\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0010\u0011\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0003\n\u0002\u0008\u0002\u0008\u0002\u0018\u00002\u00020\u0001B\u001f\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u0012\u0006\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\u0004\u0008\u0008\u0010\tJ9\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\u00072\u0006\u0010\r\u001a\u00020\u00032\u0010\u0010\u000e\u001a\u000c\u0012\u0008\u0008\u0001\u0012\u0004\u0018\u00010\u00100\u000f2\u0008\u0010\u0011\u001a\u0004\u0018\u00010\u0012H\u0016\u00a2\u0006\u0002\u0010\u0013\u00a8\u0006\u0014"
    }
    d2 = {
        "Lcom/google/firebase/logger/Logger$AndroidLogger;",
        "Lcom/google/firebase/logger/Logger;",
        "tag",
        "",
        "enabled",
        "",
        "minLevel",
        "Lcom/google/firebase/logger/Logger$Level;",
        "<init>",
        "(Ljava/lang/String;ZLcom/google/firebase/logger/Logger$Level;)V",
        "log",
        "",
        "level",
        "format",
        "args",
        "",
        "",
        "throwable",
        "",
        "(Lcom/google/firebase/logger/Logger$Level;Ljava/lang/String;[Ljava/lang/Object;Ljava/lang/Throwable;)I",
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
.method public constructor <init>(Ljava/lang/String;ZLcom/google/firebase/logger/Logger$Level;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "enabled"    # Z
    .param p3, "minLevel"    # Lcom/google/firebase/logger/Logger$Level;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "minLevel"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 99
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/google/firebase/logger/Logger;-><init>(Ljava/lang/String;ZLcom/google/firebase/logger/Logger$Level;Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 95
    return-void
.end method


# virtual methods
.method public log(Lcom/google/firebase/logger/Logger$Level;Ljava/lang/String;[Ljava/lang/Object;Ljava/lang/Throwable;)I
    .locals 4
    .param p1, "level"    # Lcom/google/firebase/logger/Logger$Level;
    .param p2, "format"    # Ljava/lang/String;
    .param p3, "args"    # [Ljava/lang/Object;
    .param p4, "throwable"    # Ljava/lang/Throwable;

    const-string v0, "level"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "format"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "args"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 106
    array-length v0, p3

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_1

    move-object v0, p2

    goto :goto_1

    :cond_1
    sget-object v0, Lkotlin/jvm/internal/StringCompanionObject;->INSTANCE:Lkotlin/jvm/internal/StringCompanionObject;

    array-length v0, p3

    invoke-static {p3, v0}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    array-length v1, v0

    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    invoke-static {p2, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "format(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 107
    .local v0, "msg":Ljava/lang/String;
    :goto_1
    sget-object v1, Lcom/google/firebase/logger/Logger$AndroidLogger$WhenMappings;->$EnumSwitchMapping$0:[I

    invoke-virtual {p1}, Lcom/google/firebase/logger/Logger$Level;->ordinal()I

    move-result v2

    aget v1, v1, v2

    packed-switch v1, :pswitch_data_0

    new-instance v1, Lkotlin/NoWhenBranchMatchedException;

    invoke-direct {v1}, Lkotlin/NoWhenBranchMatchedException;-><init>()V

    throw v1

    .line 112
    :pswitch_0
    if-eqz p4, :cond_2

    move-object v1, p4

    .line 197
    .local v1, "it":Ljava/lang/Throwable;
    const/4 v2, 0x0

    .line 112
    .local v2, "$i$a$-let-Logger$AndroidLogger$log$5":I
    invoke-virtual {p0}, Lcom/google/firebase/logger/Logger$AndroidLogger;->getTag()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0, p4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v1

    .end local v1    # "it":Ljava/lang/Throwable;
    .end local v2    # "$i$a$-let-Logger$AndroidLogger$log$5":I
    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/google/firebase/logger/Logger$AndroidLogger;->getTag()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    goto :goto_2

    .line 111
    :pswitch_1
    if-eqz p4, :cond_3

    move-object v1, p4

    .line 197
    .restart local v1    # "it":Ljava/lang/Throwable;
    const/4 v2, 0x0

    .line 111
    .local v2, "$i$a$-let-Logger$AndroidLogger$log$4":I
    invoke-virtual {p0}, Lcom/google/firebase/logger/Logger$AndroidLogger;->getTag()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0, p4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v1

    .end local v1    # "it":Ljava/lang/Throwable;
    .end local v2    # "$i$a$-let-Logger$AndroidLogger$log$4":I
    goto :goto_2

    :cond_3
    invoke-virtual {p0}, Lcom/google/firebase/logger/Logger$AndroidLogger;->getTag()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    goto :goto_2

    .line 110
    :pswitch_2
    if-eqz p4, :cond_4

    move-object v1, p4

    .line 197
    .restart local v1    # "it":Ljava/lang/Throwable;
    const/4 v2, 0x0

    .line 110
    .local v2, "$i$a$-let-Logger$AndroidLogger$log$3":I
    invoke-virtual {p0}, Lcom/google/firebase/logger/Logger$AndroidLogger;->getTag()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0, p4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v1

    .end local v1    # "it":Ljava/lang/Throwable;
    .end local v2    # "$i$a$-let-Logger$AndroidLogger$log$3":I
    goto :goto_2

    :cond_4
    invoke-virtual {p0}, Lcom/google/firebase/logger/Logger$AndroidLogger;->getTag()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    goto :goto_2

    .line 109
    :pswitch_3
    if-eqz p4, :cond_5

    move-object v1, p4

    .line 197
    .restart local v1    # "it":Ljava/lang/Throwable;
    const/4 v2, 0x0

    .line 109
    .local v2, "$i$a$-let-Logger$AndroidLogger$log$2":I
    invoke-virtual {p0}, Lcom/google/firebase/logger/Logger$AndroidLogger;->getTag()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0, p4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v1

    .end local v1    # "it":Ljava/lang/Throwable;
    .end local v2    # "$i$a$-let-Logger$AndroidLogger$log$2":I
    goto :goto_2

    :cond_5
    invoke-virtual {p0}, Lcom/google/firebase/logger/Logger$AndroidLogger;->getTag()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    goto :goto_2

    .line 108
    :pswitch_4
    if-eqz p4, :cond_6

    move-object v1, p4

    .line 197
    .restart local v1    # "it":Ljava/lang/Throwable;
    const/4 v2, 0x0

    .line 108
    .local v2, "$i$a$-let-Logger$AndroidLogger$log$1":I
    invoke-virtual {p0}, Lcom/google/firebase/logger/Logger$AndroidLogger;->getTag()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0, p4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v1

    .end local v1    # "it":Ljava/lang/Throwable;
    .end local v2    # "$i$a$-let-Logger$AndroidLogger$log$1":I
    goto :goto_2

    :cond_6
    invoke-virtual {p0}, Lcom/google/firebase/logger/Logger$AndroidLogger;->getTag()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 107
    :goto_2
    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
