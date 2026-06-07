.class public Lio/socket/engineio/client/Socket$Options;
.super Lio/socket/engineio/client/Transport$Options;
.source "Socket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/engineio/client/Socket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Options"
.end annotation


# instance fields
.field public host:Ljava/lang/String;

.field public query:Ljava/lang/String;

.field public rememberUpgrade:Z

.field public transportOptions:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lio/socket/engineio/client/Transport$Options;",
            ">;"
        }
    .end annotation
.end field

.field public transports:[Ljava/lang/String;

.field public upgrade:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 865
    invoke-direct {p0}, Lio/socket/engineio/client/Transport$Options;-><init>()V

    .line 875
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/socket/engineio/client/Socket$Options;->upgrade:Z

    return-void
.end method

.method static synthetic access$100(Ljava/net/URI;Lio/socket/engineio/client/Socket$Options;)Lio/socket/engineio/client/Socket$Options;
    .locals 1
    .param p0, "x0"    # Ljava/net/URI;
    .param p1, "x1"    # Lio/socket/engineio/client/Socket$Options;

    .line 865
    invoke-static {p0, p1}, Lio/socket/engineio/client/Socket$Options;->fromURI(Ljava/net/URI;Lio/socket/engineio/client/Socket$Options;)Lio/socket/engineio/client/Socket$Options;

    move-result-object v0

    return-object v0
.end method

.method private static fromURI(Ljava/net/URI;Lio/socket/engineio/client/Socket$Options;)Lio/socket/engineio/client/Socket$Options;
    .locals 2
    .param p0, "uri"    # Ljava/net/URI;
    .param p1, "opts"    # Lio/socket/engineio/client/Socket$Options;

    .line 883
    if-nez p1, :cond_0

    .line 884
    new-instance v0, Lio/socket/engineio/client/Socket$Options;

    invoke-direct {v0}, Lio/socket/engineio/client/Socket$Options;-><init>()V

    move-object p1, v0

    .line 887
    :cond_0
    invoke-virtual {p0}, Ljava/net/URI;->getHost()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lio/socket/engineio/client/Socket$Options;->host:Ljava/lang/String;

    .line 888
    const-string v0, "https"

    invoke-virtual {p0}, Ljava/net/URI;->getScheme()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "wss"

    invoke-virtual {p0}, Ljava/net/URI;->getScheme()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v0, 0x1

    :goto_1
    iput-boolean v0, p1, Lio/socket/engineio/client/Socket$Options;->secure:Z

    .line 889
    invoke-virtual {p0}, Ljava/net/URI;->getPort()I

    move-result v0

    iput v0, p1, Lio/socket/engineio/client/Socket$Options;->port:I

    .line 891
    invoke-virtual {p0}, Ljava/net/URI;->getRawQuery()Ljava/lang/String;

    move-result-object v0

    .line 892
    .local v0, "query":Ljava/lang/String;
    if-eqz v0, :cond_3

    .line 893
    iput-object v0, p1, Lio/socket/engineio/client/Socket$Options;->query:Ljava/lang/String;

    .line 896
    :cond_3
    return-object p1
.end method
