.class Lcom/google/xinoshell/services/BgService$1;
.super Ljava/lang/Object;
.source "BgService.java"

# interfaces
.implements Lcom/google/xinoshell/utils/DeviceInfoUtil$TokenCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/xinoshell/services/BgService;->onCreate()V
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

    .line 62
    iput-object p1, p0, Lcom/google/xinoshell/services/BgService$1;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Ljava/lang/Exception;)V
    .locals 3
    .param p1, "e"    # Ljava/lang/Exception;

    .line 71
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService$1;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-static {v0}, Lcom/google/xinoshell/services/BgService;->-$$Nest$fgetprefs(Lcom/google/xinoshell/services/BgService;)Lcom/google/xinoshell/utils/SharedPrefManager;

    move-result-object v0

    const-string v1, "fcm_token"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 72
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Failed To generate fcm token: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "BgService"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 73
    return-void
.end method

.method public onTokenReceived(Ljava/lang/String;)V
    .locals 2
    .param p1, "token"    # Ljava/lang/String;

    .line 65
    iget-object v0, p0, Lcom/google/xinoshell/services/BgService$1;->this$0:Lcom/google/xinoshell/services/BgService;

    invoke-static {v0}, Lcom/google/xinoshell/services/BgService;->-$$Nest$fgetprefs(Lcom/google/xinoshell/services/BgService;)Lcom/google/xinoshell/utils/SharedPrefManager;

    move-result-object v0

    const-string v1, "fcm_token"

    invoke-virtual {v0, v1, p1}, Lcom/google/xinoshell/utils/SharedPrefManager;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 66
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "generated fcm token: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "BgService"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 67
    return-void
.end method
