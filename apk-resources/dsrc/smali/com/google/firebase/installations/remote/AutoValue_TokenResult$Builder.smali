.class final Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;
.super Lcom/google/firebase/installations/remote/TokenResult$Builder;
.source "AutoValue_TokenResult.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/firebase/installations/remote/AutoValue_TokenResult;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Builder"
.end annotation


# instance fields
.field private responseCode:Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;

.field private set$0:B

.field private token:Ljava/lang/String;

.field private tokenExpirationTimestamp:J


# direct methods
.method constructor <init>()V
    .locals 0

    .line 87
    invoke-direct {p0}, Lcom/google/firebase/installations/remote/TokenResult$Builder;-><init>()V

    .line 88
    return-void
.end method

.method private constructor <init>(Lcom/google/firebase/installations/remote/TokenResult;)V
    .locals 2
    .param p1, "source"    # Lcom/google/firebase/installations/remote/TokenResult;

    .line 89
    invoke-direct {p0}, Lcom/google/firebase/installations/remote/TokenResult$Builder;-><init>()V

    .line 90
    invoke-virtual {p1}, Lcom/google/firebase/installations/remote/TokenResult;->getToken()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->token:Ljava/lang/String;

    .line 91
    invoke-virtual {p1}, Lcom/google/firebase/installations/remote/TokenResult;->getTokenExpirationTimestamp()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->tokenExpirationTimestamp:J

    .line 92
    invoke-virtual {p1}, Lcom/google/firebase/installations/remote/TokenResult;->getResponseCode()Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;

    move-result-object v0

    iput-object v0, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->responseCode:Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;

    .line 93
    const/4 v0, 0x1

    iput-byte v0, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->set$0:B

    .line 94
    return-void
.end method

.method synthetic constructor <init>(Lcom/google/firebase/installations/remote/TokenResult;Lcom/google/firebase/installations/remote/AutoValue_TokenResult$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/google/firebase/installations/remote/TokenResult;
    .param p2, "x1"    # Lcom/google/firebase/installations/remote/AutoValue_TokenResult$1;

    .line 82
    invoke-direct {p0, p1}, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;-><init>(Lcom/google/firebase/installations/remote/TokenResult;)V

    return-void
.end method


# virtual methods
.method public build()Lcom/google/firebase/installations/remote/TokenResult;
    .locals 8

    .line 113
    iget-byte v0, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->set$0:B

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 117
    new-instance v2, Lcom/google/firebase/installations/remote/AutoValue_TokenResult;

    iget-object v3, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->token:Ljava/lang/String;

    iget-wide v4, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->tokenExpirationTimestamp:J

    iget-object v6, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->responseCode:Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;

    const/4 v7, 0x0

    invoke-direct/range {v2 .. v7}, Lcom/google/firebase/installations/remote/AutoValue_TokenResult;-><init>(Ljava/lang/String;JLcom/google/firebase/installations/remote/TokenResult$ResponseCode;Lcom/google/firebase/installations/remote/AutoValue_TokenResult$1;)V

    return-object v2

    .line 114
    :cond_0
    const-string v0, " tokenExpirationTimestamp"

    .line 115
    .local v0, "missing":Ljava/lang/String;
    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Missing required properties:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public setResponseCode(Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;)Lcom/google/firebase/installations/remote/TokenResult$Builder;
    .locals 0
    .param p1, "responseCode"    # Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;

    .line 108
    iput-object p1, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->responseCode:Lcom/google/firebase/installations/remote/TokenResult$ResponseCode;

    .line 109
    return-object p0
.end method

.method public setToken(Ljava/lang/String;)Lcom/google/firebase/installations/remote/TokenResult$Builder;
    .locals 0
    .param p1, "token"    # Ljava/lang/String;

    .line 97
    iput-object p1, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->token:Ljava/lang/String;

    .line 98
    return-object p0
.end method

.method public setTokenExpirationTimestamp(J)Lcom/google/firebase/installations/remote/TokenResult$Builder;
    .locals 1
    .param p1, "tokenExpirationTimestamp"    # J

    .line 102
    iput-wide p1, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->tokenExpirationTimestamp:J

    .line 103
    iget-byte v0, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->set$0:B

    or-int/lit8 v0, v0, 0x1

    int-to-byte v0, v0

    iput-byte v0, p0, Lcom/google/firebase/installations/remote/AutoValue_TokenResult$Builder;->set$0:B

    .line 104
    return-object p0
.end method
