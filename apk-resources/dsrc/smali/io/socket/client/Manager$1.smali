.class Lio/socket/client/Manager$1;
.super Ljava/lang/Object;
.source "Manager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Manager;->open(Lio/socket/client/Manager$OpenCallback;)Lio/socket/client/Manager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Manager;

.field final synthetic val$fn:Lio/socket/client/Manager$OpenCallback;


# direct methods
.method constructor <init>(Lio/socket/client/Manager;Lio/socket/client/Manager$OpenCallback;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Manager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 219
    iput-object p1, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iput-object p2, p0, Lio/socket/client/Manager$1;->val$fn:Lio/socket/client/Manager$OpenCallback;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 12

    .line 222
    invoke-static {}, Lio/socket/client/Manager;->access$000()Ljava/util/logging/Logger;

    move-result-object v0

    sget-object v1, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 223
    invoke-static {}, Lio/socket/client/Manager;->access$000()Ljava/util/logging/Logger;

    move-result-object v0

    iget-object v1, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iget-object v1, v1, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "readyState %s"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 225
    :cond_0
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iget-object v0, v0, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    sget-object v1, Lio/socket/client/Manager$ReadyState;->OPEN:Lio/socket/client/Manager$ReadyState;

    if-eq v0, v1, :cond_5

    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iget-object v0, v0, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    sget-object v1, Lio/socket/client/Manager$ReadyState;->OPENING:Lio/socket/client/Manager$ReadyState;

    if-ne v0, v1, :cond_1

    move-object v2, p0

    goto/16 :goto_0

    .line 227
    :cond_1
    invoke-static {}, Lio/socket/client/Manager;->access$000()Ljava/util/logging/Logger;

    move-result-object v0

    sget-object v1, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 228
    invoke-static {}, Lio/socket/client/Manager;->access$000()Ljava/util/logging/Logger;

    move-result-object v0

    iget-object v1, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    invoke-static {v1}, Lio/socket/client/Manager;->access$100(Lio/socket/client/Manager;)Ljava/net/URI;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "opening %s"

    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 230
    :cond_2
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    new-instance v1, Lio/socket/client/Manager$Engine;

    iget-object v2, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    invoke-static {v2}, Lio/socket/client/Manager;->access$100(Lio/socket/client/Manager;)Ljava/net/URI;

    move-result-object v2

    iget-object v3, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    invoke-static {v3}, Lio/socket/client/Manager;->access$200(Lio/socket/client/Manager;)Lio/socket/client/Manager$Options;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Lio/socket/client/Manager$Engine;-><init>(Ljava/net/URI;Lio/socket/engineio/client/Socket$Options;)V

    iput-object v1, v0, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    .line 231
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iget-object v6, v0, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    .line 232
    .local v6, "socket":Lio/socket/engineio/client/Socket;
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    .line 233
    .local v0, "self":Lio/socket/client/Manager;
    iget-object v1, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    sget-object v2, Lio/socket/client/Manager$ReadyState;->OPENING:Lio/socket/client/Manager$ReadyState;

    iput-object v2, v1, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    .line 234
    iget-object v1, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lio/socket/client/Manager;->access$302(Lio/socket/client/Manager;Z)Z

    .line 237
    new-instance v1, Lio/socket/client/Manager$1$1;

    invoke-direct {v1, p0, v0}, Lio/socket/client/Manager$1$1;-><init>(Lio/socket/client/Manager$1;Lio/socket/client/Manager;)V

    const-string v2, "transport"

    invoke-virtual {v6, v2, v1}, Lio/socket/engineio/client/Socket;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 244
    new-instance v1, Lio/socket/client/Manager$1$2;

    invoke-direct {v1, p0, v0}, Lio/socket/client/Manager$1$2;-><init>(Lio/socket/client/Manager$1;Lio/socket/client/Manager;)V

    const-string v2, "open"

    invoke-static {v6, v2, v1}, Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;

    move-result-object v5

    .line 252
    .local v5, "openSub":Lio/socket/client/On$Handle;
    new-instance v1, Lio/socket/client/Manager$1$3;

    invoke-direct {v1, p0, v0}, Lio/socket/client/Manager$1$3;-><init>(Lio/socket/client/Manager$1;Lio/socket/client/Manager;)V

    const-string v2, "error"

    invoke-static {v6, v2, v1}, Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;

    move-result-object v7

    .line 271
    .local v7, "errorSub":Lio/socket/client/On$Handle;
    iget-object v1, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    invoke-static {v1}, Lio/socket/client/Manager;->access$700(Lio/socket/client/Manager;)J

    move-result-wide v3

    .line 272
    .local v3, "timeout":J
    new-instance v1, Lio/socket/client/Manager$1$4;

    move-object v2, p0

    invoke-direct/range {v1 .. v6}, Lio/socket/client/Manager$1$4;-><init>(Lio/socket/client/Manager$1;JLio/socket/client/On$Handle;Lio/socket/engineio/client/Socket;)V

    .line 282
    .local v1, "onTimeout":Ljava/lang/Runnable;
    const-wide/16 v8, 0x0

    cmp-long v10, v3, v8

    if-nez v10, :cond_3

    .line 283
    invoke-static {v1}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 284
    return-void

    .line 285
    :cond_3
    iget-object v10, v2, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    invoke-static {v10}, Lio/socket/client/Manager;->access$700(Lio/socket/client/Manager;)J

    move-result-wide v10

    cmp-long v8, v10, v8

    if-lez v8, :cond_4

    .line 286
    invoke-static {}, Lio/socket/client/Manager;->access$000()Ljava/util/logging/Logger;

    move-result-object v8

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    const-string v10, "connection attempt will timeout after %d"

    invoke-static {v10, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 288
    new-instance v8, Ljava/util/Timer;

    invoke-direct {v8}, Ljava/util/Timer;-><init>()V

    .line 289
    .local v8, "timer":Ljava/util/Timer;
    new-instance v9, Lio/socket/client/Manager$1$5;

    invoke-direct {v9, p0, v1}, Lio/socket/client/Manager$1$5;-><init>(Lio/socket/client/Manager$1;Ljava/lang/Runnable;)V

    invoke-virtual {v8, v9, v3, v4}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    .line 296
    iget-object v9, v2, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    invoke-static {v9}, Lio/socket/client/Manager;->access$800(Lio/socket/client/Manager;)Ljava/util/Queue;

    move-result-object v9

    new-instance v10, Lio/socket/client/Manager$1$6;

    invoke-direct {v10, p0, v8}, Lio/socket/client/Manager$1$6;-><init>(Lio/socket/client/Manager$1;Ljava/util/Timer;)V

    invoke-interface {v9, v10}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 304
    .end local v8    # "timer":Ljava/util/Timer;
    :cond_4
    iget-object v8, v2, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    invoke-static {v8}, Lio/socket/client/Manager;->access$800(Lio/socket/client/Manager;)Ljava/util/Queue;

    move-result-object v8

    invoke-interface {v8, v5}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 305
    iget-object v8, v2, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    invoke-static {v8}, Lio/socket/client/Manager;->access$800(Lio/socket/client/Manager;)Ljava/util/Queue;

    move-result-object v8

    invoke-interface {v8, v7}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 307
    iget-object v8, v2, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iget-object v8, v8, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    invoke-virtual {v8}, Lio/socket/engineio/client/Socket;->open()Lio/socket/engineio/client/Socket;

    .line 308
    return-void

    .line 225
    .end local v0    # "self":Lio/socket/client/Manager;
    .end local v1    # "onTimeout":Ljava/lang/Runnable;
    .end local v3    # "timeout":J
    .end local v5    # "openSub":Lio/socket/client/On$Handle;
    .end local v6    # "socket":Lio/socket/engineio/client/Socket;
    .end local v7    # "errorSub":Lio/socket/client/On$Handle;
    :cond_5
    move-object v2, p0

    :goto_0
    return-void
.end method
