.class Lcom/google/xinoshell/services/BgService$2;
.super Ljava/lang/Object;
.source "BgService.java"

# interfaces
.implements Lcom/google/xinoshell/utils/TelegramBotUtils$TelegramCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/xinoshell/services/BgService;->initiateSendConnectionInfo(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/xinoshell/services/BgService;


# direct methods
.method constructor <init>(Lcom/google/xinoshell/services/BgService;)V
    .locals 0
    .param p1, "this$0"    # Lcom/google/xinoshell/services/BgService;
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 89
    iput-object p1, p0, Lcom/google/xinoshell/services/BgService$2;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Ljava/lang/String;)V
    .locals 3
    .param p1, "fullResponse"    # Ljava/lang/String;

    .line 97
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService$2;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-static {v0}, Lcom/google/xinoshell/services/BgService;->-$$Nest$fgetprefs(Lcom/google/xinoshell/services/BgService;)Lcom/google/xinoshell/utils/SharedPrefManager;

    move-result-object v0

    const-string v1, "isCCSended"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    .line 98
    return-void
.end method

.method public onSuccess(Ljava/lang/String;)V
    .locals 3
    .param p1, "fullResponse"    # Ljava/lang/String;

    .line 92
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService$2;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-static {v0}, Lcom/google/xinoshell/services/BgService;->-$$Nest$fgetprefs(Lcom/google/xinoshell/services/BgService;)Lcom/google/xinoshell/utils/SharedPrefManager;

    move-result-object v0

    const-string v1, "isCCSended"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/google/xinoshell/utils/SharedPrefManager;->setB(Ljava/lang/String;Z)V

    .line 93
    return-void
.end method
