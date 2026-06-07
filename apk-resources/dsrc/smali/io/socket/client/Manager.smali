.class public Lio/socket/client/Manager;
.super Lio/socket/emitter/Emitter;
.source "Manager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/socket/client/Manager$Engine;,
        Lio/socket/client/Manager$Options;,
        Lio/socket/client/Manager$ReadyState;,
        Lio/socket/client/Manager$OpenCallback;
    }
.end annotation


# static fields
.field public static final EVENT_CLOSE:Ljava/lang/String; = "close"

.field public static final EVENT_ERROR:Ljava/lang/String; = "error"

.field public static final EVENT_OPEN:Ljava/lang/String; = "open"

.field public static final EVENT_PACKET:Ljava/lang/String; = "packet"

.field public static final EVENT_RECONNECT:Ljava/lang/String; = "reconnect"

.field public static final EVENT_RECONNECT_ATTEMPT:Ljava/lang/String; = "reconnect_attempt"

.field public static final EVENT_RECONNECT_ERROR:Ljava/lang/String; = "reconnect_error"

.field public static final EVENT_RECONNECT_FAILED:Ljava/lang/String; = "reconnect_failed"

.field public static final EVENT_TRANSPORT:Ljava/lang/String; = "transport"

.field static defaultCallFactory:Lokhttp3/Call$Factory;

.field static defaultWebSocketFactory:Lokhttp3/WebSocket$Factory;

.field private static final logger:Ljava/util/logging/Logger;


# instance fields
.field private _randomizationFactor:D

.field private _reconnection:Z

.field private _reconnectionAttempts:I

.field private _reconnectionDelay:J

.field private _reconnectionDelayMax:J

.field private _timeout:J

.field private final backoff:Lio/socket/backo/Backoff;

.field private final decoder:Lio/socket/parser/Parser$Decoder;

.field private final encoder:Lio/socket/parser/Parser$Encoder;

.field private encoding:Z

.field engine:Lio/socket/engineio/client/Socket;

.field final nsps:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lio/socket/client/Socket;",
            ">;"
        }
    .end annotation
.end field

.field private final opts:Lio/socket/client/Manager$Options;

.field private final packetBuffer:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/socket/parser/Packet;",
            ">;"
        }
    .end annotation
.end field

.field readyState:Lio/socket/client/Manager$ReadyState;

.field private reconnecting:Z

.field private skipReconnect:Z

.field private final subs:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue<",
            "Lio/socket/client/On$Handle;",
            ">;"
        }
    .end annotation
.end field

.field private final uri:Ljava/net/URI;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 24
    const-class v0, Lio/socket/client/Manager;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 92
    const/4 v0, 0x0

    invoke-direct {p0, v0, v0}, Lio/socket/client/Manager;-><init>(Ljava/net/URI;Lio/socket/client/Manager$Options;)V

    .line 93
    return-void
.end method

.method public constructor <init>(Lio/socket/client/Manager$Options;)V
    .locals 1
    .param p1, "opts"    # Lio/socket/client/Manager$Options;

    .line 100
    const/4 v0, 0x0

    invoke-direct {p0, v0, p1}, Lio/socket/client/Manager;-><init>(Ljava/net/URI;Lio/socket/client/Manager$Options;)V

    .line 101
    return-void
.end method

.method public constructor <init>(Ljava/net/URI;)V
    .locals 1
    .param p1, "uri"    # Ljava/net/URI;

    .line 96
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lio/socket/client/Manager;-><init>(Ljava/net/URI;Lio/socket/client/Manager$Options;)V

    .line 97
    return-void
.end method

.method public constructor <init>(Ljava/net/URI;Lio/socket/client/Manager$Options;)V
    .locals 4
    .param p1, "uri"    # Ljava/net/URI;
    .param p2, "opts"    # Lio/socket/client/Manager$Options;

    .line 103
    invoke-direct {p0}, Lio/socket/emitter/Emitter;-><init>()V

    .line 78
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lio/socket/client/Manager;->packetBuffer:Ljava/util/List;

    .line 79
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lio/socket/client/Manager;->subs:Ljava/util/Queue;

    .line 88
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lio/socket/client/Manager;->nsps:Ljava/util/Map;

    .line 104
    if-nez p2, :cond_0

    .line 105
    new-instance v0, Lio/socket/client/Manager$Options;

    invoke-direct {v0}, Lio/socket/client/Manager$Options;-><init>()V

    move-object p2, v0

    .line 107
    :cond_0
    iget-object v0, p2, Lio/socket/client/Manager$Options;->path:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 108
    const-string v0, "/socket.io"

    iput-object v0, p2, Lio/socket/client/Manager$Options;->path:Ljava/lang/String;

    .line 110
    :cond_1
    iget-object v0, p2, Lio/socket/client/Manager$Options;->webSocketFactory:Lokhttp3/WebSocket$Factory;

    if-nez v0, :cond_2

    .line 111
    sget-object v0, Lio/socket/client/Manager;->defaultWebSocketFactory:Lokhttp3/WebSocket$Factory;

    iput-object v0, p2, Lio/socket/client/Manager$Options;->webSocketFactory:Lokhttp3/WebSocket$Factory;

    .line 113
    :cond_2
    iget-object v0, p2, Lio/socket/client/Manager$Options;->callFactory:Lokhttp3/Call$Factory;

    if-nez v0, :cond_3

    .line 114
    sget-object v0, Lio/socket/client/Manager;->defaultCallFactory:Lokhttp3/Call$Factory;

    iput-object v0, p2, Lio/socket/client/Manager$Options;->callFactory:Lokhttp3/Call$Factory;

    .line 116
    :cond_3
    iput-object p2, p0, Lio/socket/client/Manager;->opts:Lio/socket/client/Manager$Options;

    .line 117
    iget-boolean v0, p2, Lio/socket/client/Manager$Options;->reconnection:Z

    invoke-virtual {p0, v0}, Lio/socket/client/Manager;->reconnection(Z)Lio/socket/client/Manager;

    .line 118
    iget v0, p2, Lio/socket/client/Manager$Options;->reconnectionAttempts:I

    if-eqz v0, :cond_4

    iget v0, p2, Lio/socket/client/Manager$Options;->reconnectionAttempts:I

    goto :goto_0

    :cond_4
    const v0, 0x7fffffff

    :goto_0
    invoke-virtual {p0, v0}, Lio/socket/client/Manager;->reconnectionAttempts(I)Lio/socket/client/Manager;

    .line 119
    iget-wide v0, p2, Lio/socket/client/Manager$Options;->reconnectionDelay:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_5

    iget-wide v0, p2, Lio/socket/client/Manager$Options;->reconnectionDelay:J

    goto :goto_1

    :cond_5
    const-wide/16 v0, 0x3e8

    :goto_1
    invoke-virtual {p0, v0, v1}, Lio/socket/client/Manager;->reconnectionDelay(J)Lio/socket/client/Manager;

    .line 120
    iget-wide v0, p2, Lio/socket/client/Manager$Options;->reconnectionDelayMax:J

    cmp-long v0, v0, v2

    if-eqz v0, :cond_6

    iget-wide v0, p2, Lio/socket/client/Manager$Options;->reconnectionDelayMax:J

    goto :goto_2

    :cond_6
    const-wide/16 v0, 0x1388

    :goto_2
    invoke-virtual {p0, v0, v1}, Lio/socket/client/Manager;->reconnectionDelayMax(J)Lio/socket/client/Manager;

    .line 121
    iget-wide v0, p2, Lio/socket/client/Manager$Options;->randomizationFactor:D

    const-wide/16 v2, 0x0

    cmpl-double v0, v0, v2

    if-eqz v0, :cond_7

    iget-wide v0, p2, Lio/socket/client/Manager$Options;->randomizationFactor:D

    goto :goto_3

    :cond_7
    const-wide/high16 v0, 0x3fe0000000000000L    # 0.5

    :goto_3
    invoke-virtual {p0, v0, v1}, Lio/socket/client/Manager;->randomizationFactor(D)Lio/socket/client/Manager;

    .line 122
    new-instance v0, Lio/socket/backo/Backoff;

    invoke-direct {v0}, Lio/socket/backo/Backoff;-><init>()V

    .line 123
    invoke-virtual {p0}, Lio/socket/client/Manager;->reconnectionDelay()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lio/socket/backo/Backoff;->setMin(J)Lio/socket/backo/Backoff;

    move-result-object v0

    .line 124
    invoke-virtual {p0}, Lio/socket/client/Manager;->reconnectionDelayMax()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lio/socket/backo/Backoff;->setMax(J)Lio/socket/backo/Backoff;

    move-result-object v0

    .line 125
    invoke-virtual {p0}, Lio/socket/client/Manager;->randomizationFactor()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lio/socket/backo/Backoff;->setJitter(D)Lio/socket/backo/Backoff;

    move-result-object v0

    iput-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    .line 126
    iget-wide v0, p2, Lio/socket/client/Manager$Options;->timeout:J

    invoke-virtual {p0, v0, v1}, Lio/socket/client/Manager;->timeout(J)Lio/socket/client/Manager;

    .line 127
    sget-object v0, Lio/socket/client/Manager$ReadyState;->CLOSED:Lio/socket/client/Manager$ReadyState;

    iput-object v0, p0, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    .line 128
    iput-object p1, p0, Lio/socket/client/Manager;->uri:Ljava/net/URI;

    .line 129
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/socket/client/Manager;->encoding:Z

    .line 130
    iget-object v0, p2, Lio/socket/client/Manager$Options;->encoder:Lio/socket/parser/Parser$Encoder;

    if-eqz v0, :cond_8

    iget-object v0, p2, Lio/socket/client/Manager$Options;->encoder:Lio/socket/parser/Parser$Encoder;

    goto :goto_4

    :cond_8
    new-instance v0, Lio/socket/parser/IOParser$Encoder;

    invoke-direct {v0}, Lio/socket/parser/IOParser$Encoder;-><init>()V

    :goto_4
    iput-object v0, p0, Lio/socket/client/Manager;->encoder:Lio/socket/parser/Parser$Encoder;

    .line 131
    iget-object v0, p2, Lio/socket/client/Manager$Options;->decoder:Lio/socket/parser/Parser$Decoder;

    if-eqz v0, :cond_9

    iget-object v0, p2, Lio/socket/client/Manager$Options;->decoder:Lio/socket/parser/Parser$Decoder;

    goto :goto_5

    :cond_9
    new-instance v0, Lio/socket/parser/IOParser$Decoder;

    invoke-direct {v0}, Lio/socket/parser/IOParser$Decoder;-><init>()V

    :goto_5
    iput-object v0, p0, Lio/socket/client/Manager;->decoder:Lio/socket/parser/Parser$Decoder;

    .line 132
    return-void
.end method

.method static synthetic access$000()Ljava/util/logging/Logger;
    .locals 1

    .line 22
    sget-object v0, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    return-object v0
.end method

.method static synthetic access$100(Lio/socket/client/Manager;)Ljava/net/URI;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    iget-object v0, p0, Lio/socket/client/Manager;->uri:Ljava/net/URI;

    return-object v0
.end method

.method static synthetic access$1000(Lio/socket/client/Manager;Ljava/lang/Exception;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;
    .param p1, "x1"    # Ljava/lang/Exception;

    .line 22
    invoke-direct {p0, p1}, Lio/socket/client/Manager;->onerror(Ljava/lang/Exception;)V

    return-void
.end method

.method static synthetic access$1100(Lio/socket/client/Manager;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;
    .param p1, "x1"    # Ljava/lang/String;

    .line 22
    invoke-direct {p0, p1}, Lio/socket/client/Manager;->onclose(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1200(Lio/socket/client/Manager;Lio/socket/parser/Packet;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;
    .param p1, "x1"    # Lio/socket/parser/Packet;

    .line 22
    invoke-direct {p0, p1}, Lio/socket/client/Manager;->ondecoded(Lio/socket/parser/Packet;)V

    return-void
.end method

.method static synthetic access$1302(Lio/socket/client/Manager;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;
    .param p1, "x1"    # Z

    .line 22
    iput-boolean p1, p0, Lio/socket/client/Manager;->encoding:Z

    return p1
.end method

.method static synthetic access$1400(Lio/socket/client/Manager;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    invoke-direct {p0}, Lio/socket/client/Manager;->processPacketQueue()V

    return-void
.end method

.method static synthetic access$1500(Lio/socket/client/Manager;)Lio/socket/backo/Backoff;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    return-object v0
.end method

.method static synthetic access$1602(Lio/socket/client/Manager;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;
    .param p1, "x1"    # Z

    .line 22
    iput-boolean p1, p0, Lio/socket/client/Manager;->reconnecting:Z

    return p1
.end method

.method static synthetic access$1700(Lio/socket/client/Manager;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    invoke-direct {p0}, Lio/socket/client/Manager;->reconnect()V

    return-void
.end method

.method static synthetic access$1800(Lio/socket/client/Manager;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    invoke-direct {p0}, Lio/socket/client/Manager;->onreconnect()V

    return-void
.end method

.method static synthetic access$200(Lio/socket/client/Manager;)Lio/socket/client/Manager$Options;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    iget-object v0, p0, Lio/socket/client/Manager;->opts:Lio/socket/client/Manager$Options;

    return-object v0
.end method

.method static synthetic access$300(Lio/socket/client/Manager;)Z
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    iget-boolean v0, p0, Lio/socket/client/Manager;->skipReconnect:Z

    return v0
.end method

.method static synthetic access$302(Lio/socket/client/Manager;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;
    .param p1, "x1"    # Z

    .line 22
    iput-boolean p1, p0, Lio/socket/client/Manager;->skipReconnect:Z

    return p1
.end method

.method static synthetic access$400(Lio/socket/client/Manager;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    invoke-direct {p0}, Lio/socket/client/Manager;->onopen()V

    return-void
.end method

.method static synthetic access$500(Lio/socket/client/Manager;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    invoke-direct {p0}, Lio/socket/client/Manager;->cleanup()V

    return-void
.end method

.method static synthetic access$600(Lio/socket/client/Manager;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    invoke-direct {p0}, Lio/socket/client/Manager;->maybeReconnectOnOpen()V

    return-void
.end method

.method static synthetic access$700(Lio/socket/client/Manager;)J
    .locals 2
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    iget-wide v0, p0, Lio/socket/client/Manager;->_timeout:J

    return-wide v0
.end method

.method static synthetic access$800(Lio/socket/client/Manager;)Ljava/util/Queue;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    iget-object v0, p0, Lio/socket/client/Manager;->subs:Ljava/util/Queue;

    return-object v0
.end method

.method static synthetic access$900(Lio/socket/client/Manager;)Lio/socket/parser/Parser$Decoder;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Manager;

    .line 22
    iget-object v0, p0, Lio/socket/client/Manager;->decoder:Lio/socket/parser/Parser$Decoder;

    return-object v0
.end method

.method private cleanup()V
    .locals 3

    .line 436
    sget-object v0, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    const-string v1, "cleanup"

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 439
    :goto_0
    iget-object v0, p0, Lio/socket/client/Manager;->subs:Ljava/util/Queue;

    invoke-interface {v0}, Ljava/util/Queue;->poll()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/socket/client/On$Handle;

    move-object v1, v0

    .local v1, "sub":Lio/socket/client/On$Handle;
    if-eqz v0, :cond_0

    invoke-interface {v1}, Lio/socket/client/On$Handle;->destroy()V

    goto :goto_0

    .line 440
    :cond_0
    iget-object v0, p0, Lio/socket/client/Manager;->decoder:Lio/socket/parser/Parser$Decoder;

    const/4 v2, 0x0

    invoke-interface {v0, v2}, Lio/socket/parser/Parser$Decoder;->onDecoded(Lio/socket/parser/Parser$Decoder$Callback;)V

    .line 442
    iget-object v0, p0, Lio/socket/client/Manager;->packetBuffer:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 443
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/socket/client/Manager;->encoding:Z

    .line 445
    iget-object v0, p0, Lio/socket/client/Manager;->decoder:Lio/socket/parser/Parser$Decoder;

    invoke-interface {v0}, Lio/socket/parser/Parser$Decoder;->destroy()V

    .line 446
    return-void
.end method

.method private maybeReconnectOnOpen()V
    .locals 1

    .line 203
    iget-boolean v0, p0, Lio/socket/client/Manager;->reconnecting:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lio/socket/client/Manager;->_reconnection:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v0}, Lio/socket/backo/Backoff;->getAttempts()I

    move-result v0

    if-nez v0, :cond_0

    .line 204
    invoke-direct {p0}, Lio/socket/client/Manager;->reconnect()V

    .line 206
    :cond_0
    return-void
.end method

.method private onclose(Ljava/lang/String;)V
    .locals 2
    .param p1, "reason"    # Ljava/lang/String;

    .line 465
    sget-object v0, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    const-string v1, "onclose"

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 466
    invoke-direct {p0}, Lio/socket/client/Manager;->cleanup()V

    .line 467
    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v0}, Lio/socket/backo/Backoff;->reset()V

    .line 468
    sget-object v0, Lio/socket/client/Manager$ReadyState;->CLOSED:Lio/socket/client/Manager$ReadyState;

    iput-object v0, p0, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    .line 469
    const-string v0, "close"

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lio/socket/client/Manager;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 471
    iget-boolean v0, p0, Lio/socket/client/Manager;->_reconnection:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lio/socket/client/Manager;->skipReconnect:Z

    if-nez v0, :cond_0

    .line 472
    invoke-direct {p0}, Lio/socket/client/Manager;->reconnect()V

    .line 474
    :cond_0
    return-void
.end method

.method private ondecoded(Lio/socket/parser/Packet;)V
    .locals 2
    .param p1, "packet"    # Lio/socket/parser/Packet;

    .line 358
    const-string v0, "packet"

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lio/socket/client/Manager;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 359
    return-void
.end method

.method private onerror(Ljava/lang/Exception;)V
    .locals 3
    .param p1, "err"    # Ljava/lang/Exception;

    .line 362
    sget-object v0, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    sget-object v1, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    const-string v2, "error"

    invoke-virtual {v0, v1, v2, p1}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 363
    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v2, v0}, Lio/socket/client/Manager;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 364
    return-void
.end method

.method private onopen()V
    .locals 4

    .line 314
    sget-object v0, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    const-string v1, "open"

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 316
    invoke-direct {p0}, Lio/socket/client/Manager;->cleanup()V

    .line 318
    sget-object v0, Lio/socket/client/Manager$ReadyState;->OPEN:Lio/socket/client/Manager$ReadyState;

    iput-object v0, p0, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    .line 319
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v0}, Lio/socket/client/Manager;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 321
    iget-object v0, p0, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    .line 322
    .local v0, "socket":Lio/socket/engineio/client/Socket;
    iget-object v1, p0, Lio/socket/client/Manager;->subs:Ljava/util/Queue;

    new-instance v2, Lio/socket/client/Manager$2;

    invoke-direct {v2, p0}, Lio/socket/client/Manager$2;-><init>(Lio/socket/client/Manager;)V

    const-string v3, "data"

    invoke-static {v0, v3, v2}, Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 337
    iget-object v1, p0, Lio/socket/client/Manager;->subs:Ljava/util/Queue;

    new-instance v2, Lio/socket/client/Manager$3;

    invoke-direct {v2, p0}, Lio/socket/client/Manager$3;-><init>(Lio/socket/client/Manager;)V

    const-string v3, "error"

    invoke-static {v0, v3, v2}, Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 343
    iget-object v1, p0, Lio/socket/client/Manager;->subs:Ljava/util/Queue;

    new-instance v2, Lio/socket/client/Manager$4;

    invoke-direct {v2, p0}, Lio/socket/client/Manager$4;-><init>(Lio/socket/client/Manager;)V

    const-string v3, "close"

    invoke-static {v0, v3, v2}, Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 349
    iget-object v1, p0, Lio/socket/client/Manager;->decoder:Lio/socket/parser/Parser$Decoder;

    new-instance v2, Lio/socket/client/Manager$5;

    invoke-direct {v2, p0}, Lio/socket/client/Manager$5;-><init>(Lio/socket/client/Manager;)V

    invoke-interface {v1, v2}, Lio/socket/parser/Parser$Decoder;->onDecoded(Lio/socket/parser/Parser$Decoder$Callback;)V

    .line 355
    return-void
.end method

.method private onreconnect()V
    .locals 3

    .line 536
    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v0}, Lio/socket/backo/Backoff;->getAttempts()I

    move-result v0

    .line 537
    .local v0, "attempts":I
    const/4 v1, 0x0

    iput-boolean v1, p0, Lio/socket/client/Manager;->reconnecting:Z

    .line 538
    iget-object v1, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v1}, Lio/socket/backo/Backoff;->reset()V

    .line 539
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "reconnect"

    invoke-virtual {p0, v2, v1}, Lio/socket/client/Manager;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 540
    return-void
.end method

.method private processPacketQueue()V
    .locals 2

    .line 429
    iget-object v0, p0, Lio/socket/client/Manager;->packetBuffer:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lio/socket/client/Manager;->encoding:Z

    if-nez v0, :cond_0

    .line 430
    iget-object v0, p0, Lio/socket/client/Manager;->packetBuffer:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/socket/parser/Packet;

    .line 431
    .local v0, "pack":Lio/socket/parser/Packet;
    invoke-virtual {p0, v0}, Lio/socket/client/Manager;->packet(Lio/socket/parser/Packet;)V

    .line 433
    .end local v0    # "pack":Lio/socket/parser/Packet;
    :cond_0
    return-void
.end method

.method private reconnect()V
    .locals 6

    .line 477
    iget-boolean v0, p0, Lio/socket/client/Manager;->reconnecting:Z

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lio/socket/client/Manager;->skipReconnect:Z

    if-eqz v0, :cond_0

    goto :goto_1

    .line 479
    :cond_0
    move-object v0, p0

    .line 481
    .local v0, "self":Lio/socket/client/Manager;
    iget-object v1, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v1}, Lio/socket/backo/Backoff;->getAttempts()I

    move-result v1

    iget v2, p0, Lio/socket/client/Manager;->_reconnectionAttempts:I

    if-lt v1, v2, :cond_1

    .line 482
    sget-object v1, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    const-string v2, "reconnect failed"

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 483
    iget-object v1, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v1}, Lio/socket/backo/Backoff;->reset()V

    .line 484
    const-string v1, "reconnect_failed"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-virtual {p0, v1, v3}, Lio/socket/client/Manager;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 485
    iput-boolean v2, p0, Lio/socket/client/Manager;->reconnecting:Z

    goto :goto_0

    .line 487
    :cond_1
    iget-object v1, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v1}, Lio/socket/backo/Backoff;->duration()J

    move-result-wide v1

    .line 488
    .local v1, "delay":J
    sget-object v3, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    const-string v5, "will wait %dms before reconnect attempt"

    invoke-static {v5, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 490
    const/4 v3, 0x1

    iput-boolean v3, p0, Lio/socket/client/Manager;->reconnecting:Z

    .line 491
    new-instance v3, Ljava/util/Timer;

    invoke-direct {v3}, Ljava/util/Timer;-><init>()V

    .line 492
    .local v3, "timer":Ljava/util/Timer;
    new-instance v4, Lio/socket/client/Manager$7;

    invoke-direct {v4, p0, v0}, Lio/socket/client/Manager$7;-><init>(Lio/socket/client/Manager;Lio/socket/client/Manager;)V

    invoke-virtual {v3, v4, v1, v2}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    .line 526
    iget-object v4, p0, Lio/socket/client/Manager;->subs:Ljava/util/Queue;

    new-instance v5, Lio/socket/client/Manager$8;

    invoke-direct {v5, p0, v3}, Lio/socket/client/Manager$8;-><init>(Lio/socket/client/Manager;Ljava/util/Timer;)V

    invoke-interface {v4, v5}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 533
    .end local v1    # "delay":J
    .end local v3    # "timer":Ljava/util/Timer;
    :goto_0
    return-void

    .line 477
    .end local v0    # "self":Lio/socket/client/Manager;
    :cond_2
    :goto_1
    return-void
.end method


# virtual methods
.method close()V
    .locals 2

    .line 449
    sget-object v0, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    const-string v1, "disconnect"

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 450
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/socket/client/Manager;->skipReconnect:Z

    .line 451
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/socket/client/Manager;->reconnecting:Z

    .line 452
    iget-object v0, p0, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    sget-object v1, Lio/socket/client/Manager$ReadyState;->OPEN:Lio/socket/client/Manager$ReadyState;

    if-eq v0, v1, :cond_0

    .line 455
    invoke-direct {p0}, Lio/socket/client/Manager;->cleanup()V

    .line 457
    :cond_0
    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v0}, Lio/socket/backo/Backoff;->reset()V

    .line 458
    sget-object v0, Lio/socket/client/Manager$ReadyState;->CLOSED:Lio/socket/client/Manager$ReadyState;

    iput-object v0, p0, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    .line 459
    iget-object v0, p0, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    if-eqz v0, :cond_1

    .line 460
    iget-object v0, p0, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    invoke-virtual {v0}, Lio/socket/engineio/client/Socket;->close()Lio/socket/engineio/client/Socket;

    .line 462
    :cond_1
    return-void
.end method

.method destroy()V
    .locals 4

    .line 389
    iget-object v0, p0, Lio/socket/client/Manager;->nsps:Ljava/util/Map;

    monitor-enter v0

    .line 390
    :try_start_0
    iget-object v1, p0, Lio/socket/client/Manager;->nsps:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lio/socket/client/Socket;

    .line 391
    .local v2, "socket":Lio/socket/client/Socket;
    invoke-virtual {v2}, Lio/socket/client/Socket;->isActive()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 392
    sget-object v1, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    const-string v3, "socket is still active, skipping close"

    invoke-virtual {v1, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 393
    monitor-exit v0

    return-void

    .line 395
    .end local v2    # "socket":Lio/socket/client/Socket;
    :cond_0
    goto :goto_0

    .line 397
    :cond_1
    invoke-virtual {p0}, Lio/socket/client/Manager;->close()V

    .line 398
    monitor-exit v0

    .line 399
    return-void

    .line 398
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public isReconnecting()Z
    .locals 1

    .line 144
    iget-boolean v0, p0, Lio/socket/client/Manager;->reconnecting:Z

    return v0
.end method

.method public open()Lio/socket/client/Manager;
    .locals 1

    .line 209
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lio/socket/client/Manager;->open(Lio/socket/client/Manager$OpenCallback;)Lio/socket/client/Manager;

    move-result-object v0

    return-object v0
.end method

.method public open(Lio/socket/client/Manager$OpenCallback;)Lio/socket/client/Manager;
    .locals 1
    .param p1, "fn"    # Lio/socket/client/Manager$OpenCallback;

    .line 219
    new-instance v0, Lio/socket/client/Manager$1;

    invoke-direct {v0, p0, p1}, Lio/socket/client/Manager$1;-><init>(Lio/socket/client/Manager;Lio/socket/client/Manager$OpenCallback;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 310
    return-object p0
.end method

.method packet(Lio/socket/parser/Packet;)V
    .locals 3
    .param p1, "packet"    # Lio/socket/parser/Packet;

    .line 402
    sget-object v0, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    sget-object v1, Ljava/util/logging/Level;->FINE:Ljava/util/logging/Level;

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->isLoggable(Ljava/util/logging/Level;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 403
    sget-object v0, Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;

    const-string v1, "writing packet %s"

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 405
    :cond_0
    move-object v0, p0

    .line 407
    .local v0, "self":Lio/socket/client/Manager;
    iget-boolean v1, v0, Lio/socket/client/Manager;->encoding:Z

    if-nez v1, :cond_1

    .line 408
    const/4 v1, 0x1

    iput-boolean v1, v0, Lio/socket/client/Manager;->encoding:Z

    .line 409
    iget-object v1, p0, Lio/socket/client/Manager;->encoder:Lio/socket/parser/Parser$Encoder;

    new-instance v2, Lio/socket/client/Manager$6;

    invoke-direct {v2, p0, v0}, Lio/socket/client/Manager$6;-><init>(Lio/socket/client/Manager;Lio/socket/client/Manager;)V

    invoke-interface {v1, p1, v2}, Lio/socket/parser/Parser$Encoder;->encode(Lio/socket/parser/Packet;Lio/socket/parser/Parser$Encoder$Callback;)V

    goto :goto_0

    .line 424
    :cond_1
    iget-object v1, v0, Lio/socket/client/Manager;->packetBuffer:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 426
    :goto_0
    return-void
.end method

.method public final randomizationFactor()D
    .locals 2

    .line 169
    iget-wide v0, p0, Lio/socket/client/Manager;->_randomizationFactor:D

    return-wide v0
.end method

.method public randomizationFactor(D)Lio/socket/client/Manager;
    .locals 1
    .param p1, "v"    # D

    .line 173
    iput-wide p1, p0, Lio/socket/client/Manager;->_randomizationFactor:D

    .line 174
    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    if-eqz v0, :cond_0

    .line 175
    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v0, p1, p2}, Lio/socket/backo/Backoff;->setJitter(D)Lio/socket/backo/Backoff;

    .line 177
    :cond_0
    return-object p0
.end method

.method public reconnection(Z)Lio/socket/client/Manager;
    .locals 0
    .param p1, "v"    # Z

    .line 139
    iput-boolean p1, p0, Lio/socket/client/Manager;->_reconnection:Z

    .line 140
    return-object p0
.end method

.method public reconnection()Z
    .locals 1

    .line 135
    iget-boolean v0, p0, Lio/socket/client/Manager;->_reconnection:Z

    return v0
.end method

.method public reconnectionAttempts()I
    .locals 1

    .line 148
    iget v0, p0, Lio/socket/client/Manager;->_reconnectionAttempts:I

    return v0
.end method

.method public reconnectionAttempts(I)Lio/socket/client/Manager;
    .locals 0
    .param p1, "v"    # I

    .line 152
    iput p1, p0, Lio/socket/client/Manager;->_reconnectionAttempts:I

    .line 153
    return-object p0
.end method

.method public final reconnectionDelay()J
    .locals 2

    .line 157
    iget-wide v0, p0, Lio/socket/client/Manager;->_reconnectionDelay:J

    return-wide v0
.end method

.method public reconnectionDelay(J)Lio/socket/client/Manager;
    .locals 1
    .param p1, "v"    # J

    .line 161
    iput-wide p1, p0, Lio/socket/client/Manager;->_reconnectionDelay:J

    .line 162
    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    if-eqz v0, :cond_0

    .line 163
    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v0, p1, p2}, Lio/socket/backo/Backoff;->setMin(J)Lio/socket/backo/Backoff;

    .line 165
    :cond_0
    return-object p0
.end method

.method public final reconnectionDelayMax()J
    .locals 2

    .line 181
    iget-wide v0, p0, Lio/socket/client/Manager;->_reconnectionDelayMax:J

    return-wide v0
.end method

.method public reconnectionDelayMax(J)Lio/socket/client/Manager;
    .locals 1
    .param p1, "v"    # J

    .line 185
    iput-wide p1, p0, Lio/socket/client/Manager;->_reconnectionDelayMax:J

    .line 186
    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    if-eqz v0, :cond_0

    .line 187
    iget-object v0, p0, Lio/socket/client/Manager;->backoff:Lio/socket/backo/Backoff;

    invoke-virtual {v0, p1, p2}, Lio/socket/backo/Backoff;->setMax(J)Lio/socket/backo/Backoff;

    .line 189
    :cond_0
    return-object p0
.end method

.method public socket(Ljava/lang/String;)Lio/socket/client/Socket;
    .locals 1
    .param p1, "nsp"    # Ljava/lang/String;

    .line 385
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lio/socket/client/Manager;->socket(Ljava/lang/String;Lio/socket/client/Manager$Options;)Lio/socket/client/Socket;

    move-result-object v0

    return-object v0
.end method

.method public socket(Ljava/lang/String;Lio/socket/client/Manager$Options;)Lio/socket/client/Socket;
    .locals 3
    .param p1, "nsp"    # Ljava/lang/String;
    .param p2, "opts"    # Lio/socket/client/Manager$Options;

    .line 374
    iget-object v0, p0, Lio/socket/client/Manager;->nsps:Ljava/util/Map;

    monitor-enter v0

    .line 375
    :try_start_0
    iget-object v1, p0, Lio/socket/client/Manager;->nsps:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/socket/client/Socket;

    .line 376
    .local v1, "socket":Lio/socket/client/Socket;
    if-nez v1, :cond_0

    .line 377
    new-instance v2, Lio/socket/client/Socket;

    invoke-direct {v2, p0, p1, p2}, Lio/socket/client/Socket;-><init>(Lio/socket/client/Manager;Ljava/lang/String;Lio/socket/client/Manager$Options;)V

    move-object v1, v2

    .line 378
    iget-object v2, p0, Lio/socket/client/Manager;->nsps:Ljava/util/Map;

    invoke-interface {v2, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 380
    :cond_0
    monitor-exit v0

    return-object v1

    .line 381
    .end local v1    # "socket":Lio/socket/client/Socket;
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public timeout()J
    .locals 2

    .line 193
    iget-wide v0, p0, Lio/socket/client/Manager;->_timeout:J

    return-wide v0
.end method

.method public timeout(J)Lio/socket/client/Manager;
    .locals 0
    .param p1, "v"    # J

    .line 197
    iput-wide p1, p0, Lio/socket/client/Manager;->_timeout:J

    .line 198
    return-object p0
.end method
