.class Lio/socket/engineio/client/Socket$7$1;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket$7;->call([Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/Socket$7;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket$7;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/Socket$7;

    .line 372
    iput-object p1, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 5
    .param p1, "args"    # [Ljava/lang/Object;

    .line 375
    iget-object v0, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v0, v0, Lio/socket/engineio/client/Socket$7;->val$failed:[Z

    const/4 v1, 0x0

    aget-boolean v0, v0, v1

    if-eqz v0, :cond_0

    return-void

    .line 377
    :cond_0
    aget-object v0, p1, v1

    check-cast v0, Lio/socket/engineio/parser/Packet;

    .line 378
    .local v0, "msg":Lio/socket/engineio/parser/Packet;
    const-string v2, "pong"

    iget-object v3, v0, Lio/socket/engineio/parser/Packet;->type:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    const-string v2, "probe"

    iget-object v3, v0, Lio/socket/engineio/parser/Packet;->data:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 379
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v2

    sget-object v3, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 380
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v2

    iget-object v3, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v3, v3, Lio/socket/engineio/client/Socket$7;->val$name:Ljava/lang/String;

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "probe transport \'%s\' pong"

    invoke-static {v4, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 382
    :cond_1
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    const/4 v3, 0x1

    invoke-static {v2, v3}, Lio/socket/engineio/client/Socket;->access$1302(Lio/socket/engineio/client/Socket;Z)Z

    .line 383
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    iget-object v3, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v3, v3, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v3, v3, v1

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "upgrading"

    invoke-virtual {v2, v4, v3}, Lio/socket/engineio/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 384
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v2, v2, v1

    if-nez v2, :cond_2

    return-void

    .line 385
    :cond_2
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v1, v2, v1

    iget-object v1, v1, Lio/socket/engineio/client/Transport;->name:Ljava/lang/String;

    const-string v2, "websocket"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    invoke-static {v1}, Lio/socket/engineio/client/Socket;->access$302(Z)Z

    .line 387
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v1

    sget-object v2, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 388
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v1

    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    iget-object v2, v2, Lio/socket/engineio/client/Socket;->transport:Lio/socket/engineio/client/Transport;

    iget-object v2, v2, Lio/socket/engineio/client/Transport;->name:Ljava/lang/String;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "pausing current transport \'%s\'"

    invoke-static {v3, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 390
    :cond_3
    iget-object v1, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    iget-object v1, v1, Lio/socket/engineio/client/Socket;->transport:Lio/socket/engineio/client/Transport;

    check-cast v1, Lio/socket/engineio/client/transports/Polling;

    new-instance v2, Lio/socket/engineio/client/Socket$7$1$1;

    invoke-direct {v2, p0}, Lio/socket/engineio/client/Socket$7$1$1;-><init>(Lio/socket/engineio/client/Socket$7$1;)V

    invoke-virtual {v1, v2}, Lio/socket/engineio/client/transports/Polling;->pause(Ljava/lang/Runnable;)V

    goto :goto_0

    .line 410
    :cond_4
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v2

    sget-object v3, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 411
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v2

    iget-object v3, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v3, v3, Lio/socket/engineio/client/Socket$7;->val$name:Ljava/lang/String;

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "probe transport \'%s\' failed"

    invoke-static {v4, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 413
    :cond_5
    new-instance v2, Lio/socket/engineio/client/EngineIOException;

    const-string v3, "probe error"

    invoke-direct {v2, v3}, Lio/socket/engineio/client/EngineIOException;-><init>(Ljava/lang/String;)V

    .line 414
    .local v2, "err":Lio/socket/engineio/client/EngineIOException;
    iget-object v3, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v3, v3, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v1, v3, v1

    iget-object v1, v1, Lio/socket/engineio/client/Transport;->name:Ljava/lang/String;

    iput-object v1, v2, Lio/socket/engineio/client/EngineIOException;->transport:Ljava/lang/String;

    .line 415
    iget-object v1, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    const-string v3, "upgradeError"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lio/socket/engineio/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 417
    .end local v2    # "err":Lio/socket/engineio/client/EngineIOException;
    :goto_0
    return-void
.end method
