.class public Lcom/google/xinoshell/utils/TelegramBotUtils;
.super Ljava/lang/Object;
.source "TelegramBotUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;,
        Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "TelegramBotUtils"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static sendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;)V
    .locals 3
    .param p0, "botToken"    # Ljava/lang/String;
    .param p1, "chatId"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "callback"    # Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;

    .line 23
    new-instance v0, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;

    invoke-direct {v0, p3}, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;-><init>(Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;)V

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object p0, v1, v2

    const/4 v2, 0x1

    aput-object p1, v1, v2

    const/4 v2, 0x2

    aput-object p2, v1, v2

    invoke-virtual {v0, v1}, Lcom/google/xinoshell/utils/TelegramBotUtils$SendMessageTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 24
    return-void
.end method
