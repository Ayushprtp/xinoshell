.class final Lokhttp3/internal/http2/Http2Stream$FramingSource;
.super Ljava/lang/Object;
.source "Http2Stream.java"

# interfaces
.implements Lokio/Source;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lokhttp3/internal/http2/Http2Stream;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "FramingSource"
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field closed:Z

.field finished:Z

.field private final maxByteCount:J

.field private final readBuffer:Lokio/Buffer;

.field private final receiveBuffer:Lokio/Buffer;

.field final synthetic this$0:Lokhttp3/internal/http2/Http2Stream;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 329
    const-class v0, Lokhttp3/internal/http2/Http2Stream;

    return-void
.end method

.method constructor <init>(Lokhttp3/internal/http2/Http2Stream;J)V
    .locals 0
    .param p2, "maxByteCount"    # J

    .line 348
    iput-object p1, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 331
    new-instance p1, Lokio/Buffer;

    invoke-direct {p1}, Lokio/Buffer;-><init>()V

    iput-object p1, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->receiveBuffer:Lokio/Buffer;

    .line 334
    new-instance p1, Lokio/Buffer;

    invoke-direct {p1}, Lokio/Buffer;-><init>()V

    iput-object p1, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->readBuffer:Lokio/Buffer;

    .line 349
    iput-wide p2, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->maxByteCount:J

    .line 350
    return-void
.end method

.method private updateConnectionFlowControl(J)V
    .locals 1
    .param p1, "read"    # J

    .line 428
    iget-object v0, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 429
    iget-object v0, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-object v0, v0, Lokhttp3/internal/http2/Http2Stream;->connection:Lokhttp3/internal/http2/Http2Connection;

    invoke-virtual {v0, p1, p2}, Lokhttp3/internal/http2/Http2Connection;->updateConnectionFlowControl(J)V

    .line 430
    return-void

    .line 428
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method


# virtual methods
.method public close()V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 493
    const/4 v0, 0x0

    .line 494
    .local v0, "headersToDeliver":Ljava/util/List;, "Ljava/util/List<Lokhttp3/Headers;>;"
    const/4 v1, 0x0

    .line 495
    .local v1, "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    iget-object v2, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    monitor-enter v2

    .line 496
    const/4 v3, 0x1

    :try_start_0
    iput-boolean v3, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->closed:Z

    .line 497
    iget-object v3, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v3}, Lokio/Buffer;->size()J

    move-result-wide v3

    .line 498
    .local v3, "bytesDiscarded":J
    iget-object v5, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v5}, Lokio/Buffer;->clear()V

    .line 499
    iget-object v5, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v5}, Lokhttp3/internal/http2/Http2Stream;->access$000(Lokhttp3/internal/http2/Http2Stream;)Ljava/util/Deque;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Deque;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_0

    iget-object v5, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v5}, Lokhttp3/internal/http2/Http2Stream;->access$100(Lokhttp3/internal/http2/Http2Stream;)Lokhttp3/internal/http2/Header$Listener;

    move-result-object v5

    if-eqz v5, :cond_0

    .line 500
    new-instance v5, Ljava/util/ArrayList;

    iget-object v6, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v6}, Lokhttp3/internal/http2/Http2Stream;->access$000(Lokhttp3/internal/http2/Http2Stream;)Ljava/util/Deque;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    move-object v0, v5

    .line 501
    iget-object v5, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v5}, Lokhttp3/internal/http2/Http2Stream;->access$000(Lokhttp3/internal/http2/Http2Stream;)Ljava/util/Deque;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Deque;->clear()V

    .line 502
    iget-object v5, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v5}, Lokhttp3/internal/http2/Http2Stream;->access$100(Lokhttp3/internal/http2/Http2Stream;)Lokhttp3/internal/http2/Header$Listener;

    move-result-object v5

    move-object v1, v5

    .line 504
    :cond_0
    iget-object v5, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-virtual {v5}, Ljava/lang/Object;->notifyAll()V

    .line 505
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 506
    const-wide/16 v5, 0x0

    cmp-long v2, v3, v5

    if-lez v2, :cond_1

    .line 507
    invoke-direct {p0, v3, v4}, Lokhttp3/internal/http2/Http2Stream$FramingSource;->updateConnectionFlowControl(J)V

    .line 509
    :cond_1
    iget-object v2, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-virtual {v2}, Lokhttp3/internal/http2/Http2Stream;->cancelStreamIfNecessary()V

    .line 510
    if-eqz v1, :cond_2

    .line 511
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lokhttp3/Headers;

    .line 512
    .local v5, "headers":Lokhttp3/Headers;
    invoke-interface {v1, v5}, Lokhttp3/internal/http2/Header$Listener;->onHeaders(Lokhttp3/Headers;)V

    .line 513
    .end local v5    # "headers":Lokhttp3/Headers;
    goto :goto_0

    .line 515
    :cond_2
    return-void

    .line 505
    .end local v3    # "bytesDiscarded":J
    :catchall_0
    move-exception v3

    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v3
.end method

.method public read(Lokio/Buffer;J)J
    .locals 12
    .param p1, "sink"    # Lokio/Buffer;
    .param p2, "byteCount"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 353
    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-ltz v2, :cond_9

    .line 356
    :goto_0
    const/4 v2, 0x0

    .line 357
    .local v2, "headersToDeliver":Lokhttp3/Headers;
    const/4 v3, 0x0

    .line 358
    .local v3, "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    const-wide/16 v4, -0x1

    .line 359
    .local v4, "readBytesDelivered":J
    const/4 v6, 0x0

    .line 363
    .local v6, "errorCodeToDeliver":Lokhttp3/internal/http2/ErrorCode;
    iget-object v7, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    monitor-enter v7

    .line 364
    :try_start_0
    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-object v8, v8, Lokhttp3/internal/http2/Http2Stream;->readTimeout:Lokhttp3/internal/http2/Http2Stream$StreamTimeout;

    invoke-virtual {v8}, Lokhttp3/internal/http2/Http2Stream$StreamTimeout;->enter()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    .line 366
    :try_start_1
    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-object v8, v8, Lokhttp3/internal/http2/Http2Stream;->errorCode:Lokhttp3/internal/http2/ErrorCode;

    if-eqz v8, :cond_0

    .line 368
    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-object v8, v8, Lokhttp3/internal/http2/Http2Stream;->errorCode:Lokhttp3/internal/http2/ErrorCode;

    move-object v6, v8

    .line 371
    :cond_0
    iget-boolean v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->closed:Z

    if-nez v8, :cond_8

    .line 374
    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v8}, Lokhttp3/internal/http2/Http2Stream;->access$000(Lokhttp3/internal/http2/Http2Stream;)Ljava/util/Deque;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/Deque;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_1

    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v8}, Lokhttp3/internal/http2/Http2Stream;->access$100(Lokhttp3/internal/http2/Http2Stream;)Lokhttp3/internal/http2/Header$Listener;

    move-result-object v8

    if-eqz v8, :cond_1

    .line 376
    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v8}, Lokhttp3/internal/http2/Http2Stream;->access$000(Lokhttp3/internal/http2/Http2Stream;)Ljava/util/Deque;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/Deque;->removeFirst()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lokhttp3/Headers;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 377
    .end local v2    # "headersToDeliver":Lokhttp3/Headers;
    .local v8, "headersToDeliver":Lokhttp3/Headers;
    :try_start_2
    iget-object v2, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v2}, Lokhttp3/internal/http2/Http2Stream;->access$100(Lokhttp3/internal/http2/Http2Stream;)Lokhttp3/internal/http2/Header$Listener;

    move-result-object v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-object v3, v2

    move-object v2, v8

    .end local v3    # "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    .local v2, "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    goto :goto_1

    .line 398
    .end local v2    # "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    .restart local v3    # "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    :catchall_0
    move-exception v0

    move-object v2, v8

    goto/16 :goto_2

    .line 379
    .end local v8    # "headersToDeliver":Lokhttp3/Headers;
    .local v2, "headersToDeliver":Lokhttp3/Headers;
    :cond_1
    :try_start_3
    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v8}, Lokio/Buffer;->size()J

    move-result-wide v8

    cmp-long v8, v8, v0

    if-lez v8, :cond_3

    .line 381
    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->readBuffer:Lokio/Buffer;

    iget-object v9, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v9}, Lokio/Buffer;->size()J

    move-result-wide v9

    invoke-static {p2, p3, v9, v10}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v9

    invoke-virtual {v8, p1, v9, v10}, Lokio/Buffer;->read(Lokio/Buffer;J)J

    move-result-wide v8
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 382
    .end local v4    # "readBytesDelivered":J
    .local v8, "readBytesDelivered":J
    :try_start_4
    iget-object v4, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-wide v10, v4, Lokhttp3/internal/http2/Http2Stream;->unacknowledgedBytesRead:J

    add-long/2addr v10, v8

    iput-wide v10, v4, Lokhttp3/internal/http2/Http2Stream;->unacknowledgedBytesRead:J

    .line 384
    if-nez v6, :cond_2

    iget-object v4, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-wide v4, v4, Lokhttp3/internal/http2/Http2Stream;->unacknowledgedBytesRead:J

    iget-object v10, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-object v10, v10, Lokhttp3/internal/http2/Http2Stream;->connection:Lokhttp3/internal/http2/Http2Connection;

    iget-object v10, v10, Lokhttp3/internal/http2/Http2Connection;->okHttpSettings:Lokhttp3/internal/http2/Settings;

    .line 386
    invoke-virtual {v10}, Lokhttp3/internal/http2/Settings;->getInitialWindowSize()I

    move-result v10

    div-int/lit8 v10, v10, 0x2

    int-to-long v10, v10

    cmp-long v4, v4, v10

    if-ltz v4, :cond_2

    .line 389
    iget-object v4, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-object v4, v4, Lokhttp3/internal/http2/Http2Stream;->connection:Lokhttp3/internal/http2/Http2Connection;

    iget-object v5, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget v5, v5, Lokhttp3/internal/http2/Http2Stream;->id:I

    iget-object v10, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-wide v10, v10, Lokhttp3/internal/http2/Http2Stream;->unacknowledgedBytesRead:J

    invoke-virtual {v4, v5, v10, v11}, Lokhttp3/internal/http2/Http2Connection;->writeWindowUpdateLater(IJ)V

    .line 390
    iget-object v4, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iput-wide v0, v4, Lokhttp3/internal/http2/Http2Stream;->unacknowledgedBytesRead:J
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 398
    :cond_2
    move-wide v4, v8

    goto :goto_1

    :catchall_1
    move-exception v0

    move-wide v4, v8

    goto :goto_2

    .line 392
    .end local v8    # "readBytesDelivered":J
    .restart local v4    # "readBytesDelivered":J
    :cond_3
    :try_start_5
    iget-boolean v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->finished:Z

    if-nez v8, :cond_4

    if-nez v6, :cond_4

    .line 394
    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-virtual {v8}, Lokhttp3/internal/http2/Http2Stream;->waitForIo()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 398
    :try_start_6
    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-object v8, v8, Lokhttp3/internal/http2/Http2Stream;->readTimeout:Lokhttp3/internal/http2/Http2Stream$StreamTimeout;

    invoke-virtual {v8}, Lokhttp3/internal/http2/Http2Stream$StreamTimeout;->exitAndThrowIfTimedOut()V

    monitor-exit v7

    goto/16 :goto_0

    :cond_4
    :goto_1
    iget-object v8, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-object v8, v8, Lokhttp3/internal/http2/Http2Stream;->readTimeout:Lokhttp3/internal/http2/Http2Stream$StreamTimeout;

    invoke-virtual {v8}, Lokhttp3/internal/http2/Http2Stream$StreamTimeout;->exitAndThrowIfTimedOut()V

    .line 399
    nop

    .line 400
    monitor-exit v7
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 404
    if-eqz v2, :cond_5

    if-eqz v3, :cond_5

    .line 405
    invoke-interface {v3, v2}, Lokhttp3/internal/http2/Header$Listener;->onHeaders(Lokhttp3/Headers;)V

    .line 406
    goto/16 :goto_0

    .line 409
    :cond_5
    const-wide/16 v0, -0x1

    cmp-long v7, v4, v0

    if-eqz v7, :cond_6

    .line 411
    invoke-direct {p0, v4, v5}, Lokhttp3/internal/http2/Http2Stream$FramingSource;->updateConnectionFlowControl(J)V

    .line 412
    return-wide v4

    .line 415
    :cond_6
    if-nez v6, :cond_7

    .line 423
    return-wide v0

    .line 420
    :cond_7
    new-instance v0, Lokhttp3/internal/http2/StreamResetException;

    invoke-direct {v0, v6}, Lokhttp3/internal/http2/StreamResetException;-><init>(Lokhttp3/internal/http2/ErrorCode;)V

    throw v0

    .line 372
    :cond_8
    :try_start_7
    new-instance v0, Ljava/io/IOException;

    const-string v1, "stream closed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v2    # "headersToDeliver":Lokhttp3/Headers;
    .end local v3    # "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    .end local v4    # "readBytesDelivered":J
    .end local v6    # "errorCodeToDeliver":Lokhttp3/internal/http2/ErrorCode;
    .end local p1    # "sink":Lokio/Buffer;
    .end local p2    # "byteCount":J
    throw v0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 398
    .restart local v2    # "headersToDeliver":Lokhttp3/Headers;
    .restart local v3    # "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    .restart local v4    # "readBytesDelivered":J
    .restart local v6    # "errorCodeToDeliver":Lokhttp3/internal/http2/ErrorCode;
    .restart local p1    # "sink":Lokio/Buffer;
    .restart local p2    # "byteCount":J
    :catchall_2
    move-exception v0

    :goto_2
    :try_start_8
    iget-object v1, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-object v1, v1, Lokhttp3/internal/http2/Http2Stream;->readTimeout:Lokhttp3/internal/http2/Http2Stream$StreamTimeout;

    invoke-virtual {v1}, Lokhttp3/internal/http2/Http2Stream$StreamTimeout;->exitAndThrowIfTimedOut()V

    .end local v2    # "headersToDeliver":Lokhttp3/Headers;
    .end local v3    # "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    .end local v4    # "readBytesDelivered":J
    .end local v6    # "errorCodeToDeliver":Lokhttp3/internal/http2/ErrorCode;
    .end local p1    # "sink":Lokio/Buffer;
    .end local p2    # "byteCount":J
    throw v0

    .line 400
    .restart local v2    # "headersToDeliver":Lokhttp3/Headers;
    .restart local v3    # "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    .restart local v4    # "readBytesDelivered":J
    .restart local v6    # "errorCodeToDeliver":Lokhttp3/internal/http2/ErrorCode;
    .restart local p1    # "sink":Lokio/Buffer;
    .restart local p2    # "byteCount":J
    :catchall_3
    move-exception v0

    monitor-exit v7
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    throw v0

    .line 353
    .end local v2    # "headersToDeliver":Lokhttp3/Headers;
    .end local v3    # "headersListenerToNotify":Lokhttp3/internal/http2/Header$Listener;
    .end local v4    # "readBytesDelivered":J
    .end local v6    # "errorCodeToDeliver":Lokhttp3/internal/http2/ErrorCode;
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "byteCount < 0: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method receive(Lokio/BufferedSource;J)V
    .locals 18
    .param p1, "in"    # Lokio/BufferedSource;
    .param p2, "byteCount"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 437
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    iget-object v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-static {v0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_9

    .line 439
    move-wide/from16 v3, p2

    .end local p2    # "byteCount":J
    .local v3, "byteCount":J
    :goto_0
    const-wide/16 v5, 0x0

    cmp-long v0, v3, v5

    if-lez v0, :cond_8

    .line 442
    iget-object v7, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    monitor-enter v7

    .line 443
    :try_start_0
    iget-boolean v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->finished:Z

    move v8, v0

    .line 444
    .local v8, "finished":Z
    iget-object v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->size()J

    move-result-wide v9

    add-long/2addr v9, v3

    iget-wide v11, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->maxByteCount:J

    cmp-long v0, v9, v11

    const/4 v9, 0x1

    const/4 v10, 0x0

    if-lez v0, :cond_0

    move v0, v9

    goto :goto_1

    :cond_0
    move v0, v10

    :goto_1
    move v11, v0

    .line 445
    .local v11, "flowControlError":Z
    monitor-exit v7
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 448
    if-eqz v11, :cond_1

    .line 449
    invoke-interface {v2, v3, v4}, Lokio/BufferedSource;->skip(J)V

    .line 450
    iget-object v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    sget-object v5, Lokhttp3/internal/http2/ErrorCode;->FLOW_CONTROL_ERROR:Lokhttp3/internal/http2/ErrorCode;

    invoke-virtual {v0, v5}, Lokhttp3/internal/http2/Http2Stream;->closeLater(Lokhttp3/internal/http2/ErrorCode;)V

    .line 451
    return-void

    .line 455
    :cond_1
    if-eqz v8, :cond_2

    .line 456
    invoke-interface {v2, v3, v4}, Lokio/BufferedSource;->skip(J)V

    .line 457
    return-void

    .line 461
    :cond_2
    iget-object v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->receiveBuffer:Lokio/Buffer;

    invoke-interface {v2, v0, v3, v4}, Lokio/BufferedSource;->read(Lokio/Buffer;J)J

    move-result-wide v12

    .line 462
    .local v12, "read":J
    const-wide/16 v14, -0x1

    cmp-long v0, v12, v14

    if-eqz v0, :cond_7

    .line 463
    sub-long v14, v3, v12

    .line 468
    .end local v3    # "byteCount":J
    .local v14, "byteCount":J
    const-wide/16 v3, 0x0

    .line 469
    .local v3, "bytesDiscarded":J
    iget-object v7, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    monitor-enter v7

    .line 470
    :try_start_1
    iget-boolean v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->closed:Z

    if-eqz v0, :cond_3

    .line 471
    iget-object v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->receiveBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->size()J

    move-result-wide v9

    move-wide v3, v9

    .line 472
    iget-object v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->receiveBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->clear()V

    goto :goto_3

    .line 474
    :cond_3
    iget-object v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->readBuffer:Lokio/Buffer;

    invoke-virtual {v0}, Lokio/Buffer;->size()J

    move-result-wide v16

    cmp-long v0, v16, v5

    if-nez v0, :cond_4

    goto :goto_2

    :cond_4
    move v9, v10

    .line 475
    .local v9, "wasEmpty":Z
    :goto_2
    iget-object v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->readBuffer:Lokio/Buffer;

    iget-object v10, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->receiveBuffer:Lokio/Buffer;

    invoke-virtual {v0, v10}, Lokio/Buffer;->writeAll(Lokio/Source;)J

    .line 476
    if-eqz v9, :cond_5

    .line 477
    iget-object v0, v1, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 480
    .end local v9    # "wasEmpty":Z
    :cond_5
    :goto_3
    monitor-exit v7
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 481
    cmp-long v0, v3, v5

    if-lez v0, :cond_6

    .line 482
    invoke-direct {v1, v3, v4}, Lokhttp3/internal/http2/Http2Stream$FramingSource;->updateConnectionFlowControl(J)V

    .line 484
    .end local v3    # "bytesDiscarded":J
    .end local v8    # "finished":Z
    .end local v11    # "flowControlError":Z
    .end local v12    # "read":J
    :cond_6
    move-wide v3, v14

    goto :goto_0

    .line 480
    .restart local v3    # "bytesDiscarded":J
    .restart local v8    # "finished":Z
    .restart local v11    # "flowControlError":Z
    .restart local v12    # "read":J
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v7
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 462
    .end local v14    # "byteCount":J
    .local v3, "byteCount":J
    :cond_7
    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0

    .line 445
    .end local v8    # "finished":Z
    .end local v11    # "flowControlError":Z
    .end local v12    # "read":J
    :catchall_1
    move-exception v0

    :try_start_3
    monitor-exit v7
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw v0

    .line 485
    :cond_8
    return-void

    .line 437
    .end local v3    # "byteCount":J
    .restart local p2    # "byteCount":J
    :cond_9
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public timeout()Lokio/Timeout;
    .locals 1

    .line 488
    iget-object v0, p0, Lokhttp3/internal/http2/Http2Stream$FramingSource;->this$0:Lokhttp3/internal/http2/Http2Stream;

    iget-object v0, v0, Lokhttp3/internal/http2/Http2Stream;->readTimeout:Lokhttp3/internal/http2/Http2Stream$StreamTimeout;

    return-object v0
.end method
