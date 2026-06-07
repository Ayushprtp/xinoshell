.class public final Lcom/google/firebase/messaging/MessagingKt;
.super Ljava/lang/Object;
.source "Messaging.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\u0018\u0002\n\u0000\u001a/\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00082\u0019\u0008\u0004\u0010\t\u001a\u0013\u0012\u0004\u0012\u00020\u000b\u0012\u0004\u0012\u00020\u000c0\n\u00a2\u0006\u0002\u0008\rH\u0086\u0008\u00f8\u0001\u0000\"\u0015\u0010\u0000\u001a\u00020\u0001*\u00020\u00028F\u00a2\u0006\u0006\u001a\u0004\u0008\u0003\u0010\u0004\u0082\u0002\u0007\n\u0005\u0008\u009920\u0001\u00a8\u0006\u000e"
    }
    d2 = {
        "messaging",
        "Lcom/google/firebase/messaging/FirebaseMessaging;",
        "Lcom/google/firebase/Firebase;",
        "getMessaging",
        "(Lcom/google/firebase/Firebase;)Lcom/google/firebase/messaging/FirebaseMessaging;",
        "remoteMessage",
        "Lcom/google/firebase/messaging/RemoteMessage;",
        "to",
        "",
        "init",
        "Lkotlin/Function1;",
        "Lcom/google/firebase/messaging/RemoteMessage$Builder;",
        "",
        "Lkotlin/ExtensionFunctionType;",
        "com.google.firebase-firebase-messaging"
    }
    k = 0x2
    mv = {
        0x2,
        0x0,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static final getMessaging(Lcom/google/firebase/Firebase;)Lcom/google/firebase/messaging/FirebaseMessaging;
    .locals 2
    .param p0, "$this$messaging"    # Lcom/google/firebase/Firebase;

    const-string v0, "<this>"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    invoke-static {}, Lcom/google/firebase/messaging/FirebaseMessaging;->getInstance()Lcom/google/firebase/messaging/FirebaseMessaging;

    move-result-object v0

    const-string v1, "getInstance(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method public static final remoteMessage(Ljava/lang/String;Lkotlin/jvm/functions/Function1;)Lcom/google/firebase/messaging/RemoteMessage;
    .locals 4
    .param p0, "to"    # Ljava/lang/String;
    .param p1, "init"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/google/firebase/messaging/RemoteMessage$Builder;",
            "Lkotlin/Unit;",
            ">;)",
            "Lcom/google/firebase/messaging/RemoteMessage;"
        }
    .end annotation

    const-string v0, "to"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "init"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 33
    .local v0, "$i$f$remoteMessage":I
    new-instance v1, Lcom/google/firebase/messaging/RemoteMessage$Builder;

    invoke-direct {v1, p0}, Lcom/google/firebase/messaging/RemoteMessage$Builder;-><init>(Ljava/lang/String;)V

    .line 34
    .local v1, "builder":Lcom/google/firebase/messaging/RemoteMessage$Builder;
    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 35
    invoke-virtual {v1}, Lcom/google/firebase/messaging/RemoteMessage$Builder;->build()Lcom/google/firebase/messaging/RemoteMessage;

    move-result-object v2

    const-string v3, "build(...)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v2
.end method
