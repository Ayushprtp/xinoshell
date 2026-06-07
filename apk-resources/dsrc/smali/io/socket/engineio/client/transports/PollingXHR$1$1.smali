.class Lio/socket/engineio/client/transports/PollingXHR$1$1;
.super Ljava/lang/Object;
.source "PollingXHR.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/PollingXHR$1;->call([Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/transports/PollingXHR$1;

.field final synthetic val$args:[Ljava/lang/Object;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/PollingXHR$1;[Ljava/lang/Object;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/transports/PollingXHR$1;

    .line 58
    iput-object p1, p0, Lio/socket/engineio/client/transports/PollingXHR$1$1;->this$1:Lio/socket/engineio/client/transports/PollingXHR$1;

    iput-object p2, p0, Lio/socket/engineio/client/transports/PollingXHR$1$1;->val$args:[Ljava/lang/Object;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 61
    iget-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$1$1;->this$1:Lio/socket/engineio/client/transports/PollingXHR$1;

    iget-object v0, v0, Lio/socket/engineio/client/transports/PollingXHR$1;->val$self:Lio/socket/engineio/client/transports/PollingXHR;

    iget-object v1, p0, Lio/socket/engineio/client/transports/PollingXHR$1$1;->val$args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "responseHeaders"

    invoke-virtual {v0, v2, v1}, Lio/socket/engineio/client/transports/PollingXHR;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 62
    return-void
.end method
