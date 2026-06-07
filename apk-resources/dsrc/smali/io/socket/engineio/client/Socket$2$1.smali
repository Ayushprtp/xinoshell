.class Lio/socket/engineio/client/Socket$2$1;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket$2;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/Socket$2;

.field final synthetic val$self:Lio/socket/engineio/client/Socket;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket$2;Lio/socket/engineio/client/Socket;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/Socket$2;

    .line 249
    iput-object p1, p0, Lio/socket/engineio/client/Socket$2$1;->this$1:Lio/socket/engineio/client/Socket$2;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$2$1;->val$self:Lio/socket/engineio/client/Socket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 252
    iget-object v0, p0, Lio/socket/engineio/client/Socket$2$1;->val$self:Lio/socket/engineio/client/Socket;

    new-instance v1, Lio/socket/engineio/client/EngineIOException;

    const-string v2, "No transports available"

    invoke-direct {v1, v2}, Lio/socket/engineio/client/EngineIOException;-><init>(Ljava/lang/String;)V

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "error"

    invoke-virtual {v0, v2, v1}, Lio/socket/engineio/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 253
    return-void
.end method
