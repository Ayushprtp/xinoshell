.class public abstract Lio/socket/client/AckWithTimeout;
.super Ljava/lang/Object;
.source "AckWithTimeout.java"

# interfaces
.implements Lio/socket/client/Ack;


# instance fields
.field private final timeout:J

.field private final timer:Ljava/util/Timer;


# direct methods
.method public constructor <init>(J)V
    .locals 1
    .param p1, "timeout"    # J

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 8
    new-instance v0, Ljava/util/Timer;

    invoke-direct {v0}, Ljava/util/Timer;-><init>()V

    iput-object v0, p0, Lio/socket/client/AckWithTimeout;->timer:Ljava/util/Timer;

    .line 15
    iput-wide p1, p0, Lio/socket/client/AckWithTimeout;->timeout:J

    .line 16
    return-void
.end method


# virtual methods
.method public final varargs call([Ljava/lang/Object;)V
    .locals 1
    .param p1, "args"    # [Ljava/lang/Object;

    .line 20
    iget-object v0, p0, Lio/socket/client/AckWithTimeout;->timer:Ljava/util/Timer;

    invoke-virtual {v0}, Ljava/util/Timer;->cancel()V

    .line 21
    invoke-virtual {p0, p1}, Lio/socket/client/AckWithTimeout;->onSuccess([Ljava/lang/Object;)V

    .line 22
    return-void
.end method

.method public final cancelTimer()V
    .locals 1

    .line 29
    iget-object v0, p0, Lio/socket/client/AckWithTimeout;->timer:Ljava/util/Timer;

    invoke-virtual {v0}, Ljava/util/Timer;->cancel()V

    .line 30
    return-void
.end method

.method public varargs abstract onSuccess([Ljava/lang/Object;)V
.end method

.method public abstract onTimeout()V
.end method

.method public final schedule(Ljava/util/TimerTask;)V
    .locals 3
    .param p1, "task"    # Ljava/util/TimerTask;

    .line 25
    iget-object v0, p0, Lio/socket/client/AckWithTimeout;->timer:Ljava/util/Timer;

    iget-wide v1, p0, Lio/socket/client/AckWithTimeout;->timeout:J

    invoke-virtual {v0, p1, v1, v2}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    .line 26
    return-void
.end method
