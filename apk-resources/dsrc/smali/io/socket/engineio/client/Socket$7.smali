.class Lio/socket/engineio/client/Socket$7;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket;->probe(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/Socket;

.field final synthetic val$cleanup:[Ljava/lang/Runnable;

.field final synthetic val$failed:[Z

.field final synthetic val$name:Ljava/lang/String;

.field final synthetic val$self:Lio/socket/engineio/client/Socket;

.field final synthetic val$transport:[Lio/socket/engineio/client/Transport;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;[ZLjava/lang/String;[Lio/socket/engineio/client/Transport;Lio/socket/engineio/client/Socket;[Ljava/lang/Runnable;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .line 362
    iput-object p1, p0, Lio/socket/engineio/client/Socket$7;->this$0:Lio/socket/engineio/client/Socket;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$7;->val$failed:[Z

    iput-object p3, p0, Lio/socket/engineio/client/Socket$7;->val$name:Ljava/lang/String;

    iput-object p4, p0, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    iput-object p5, p0, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    iput-object p6, p0, Lio/socket/engineio/client/Socket$7;->val$cleanup:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 4
    .param p1, "args"    # [Ljava/lang/Object;

    .line 365
    iget-object v0, p0, Lio/socket/engineio/client/Socket$7;->val$failed:[Z

    const/4 v1, 0x0

    aget-boolean v0, v0, v1

    if-eqz v0, :cond_0

    return-void

    .line 367
    :cond_0
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v0

    sget-object v2, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v0, v2}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 368
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v0

    iget-object v2, p0, Lio/socket/engineio/client/Socket$7;->val$name:Ljava/lang/String;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "probe transport \'%s\' opened"

    invoke-static {v3, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 370
    :cond_1
    new-instance v0, Lio/socket/engineio/parser/Packet;

    const-string v2, "ping"

    const-string v3, "probe"

    invoke-direct {v0, v2, v3}, Lio/socket/engineio/parser/Packet;-><init>(Ljava/lang/String;Ljava/lang/Object;)V

    .line 371
    .local v0, "packet":Lio/socket/engineio/parser/Packet;, "Lio/socket/engineio/parser/Packet<Ljava/lang/String;>;"
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v2, v2, v1

    const/4 v3, 0x1

    new-array v3, v3, [Lio/socket/engineio/parser/Packet;

    aput-object v0, v3, v1

    invoke-virtual {v2, v3}, Lio/socket/engineio/client/Transport;->send([Lio/socket/engineio/parser/Packet;)V

    .line 372
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v1, v2, v1

    new-instance v2, Lio/socket/engineio/client/Socket$7$1;

    invoke-direct {v2, p0}, Lio/socket/engineio/client/Socket$7$1;-><init>(Lio/socket/engineio/client/Socket$7;)V

    const-string v3, "packet"

    invoke-virtual {v1, v3, v2}, Lio/socket/engineio/client/Transport;->once(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 419
    return-void
.end method
