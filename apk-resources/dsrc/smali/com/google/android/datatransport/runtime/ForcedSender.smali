.class public final Lcom/google/android/datatransport/runtime/ForcedSender;
.super Ljava/lang/Object;
.source "ForcedSender.java"


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "ForcedSender"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static sendBlocking(Lcom/google/android/datatransport/Transport;Lcom/google/android/datatransport/Priority;)V
    .locals 3
    .param p1, "priority"    # Lcom/google/android/datatransport/Priority;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/datatransport/Transport<",
            "*>;",
            "Lcom/google/android/datatransport/Priority;",
            ")V"
        }
    .end annotation

    .line 33
    .local p0, "transport":Lcom/google/android/datatransport/Transport;, "Lcom/google/android/datatransport/Transport<*>;"
    instance-of v0, p0, Lcom/google/android/datatransport/runtime/TransportImpl;

    if-eqz v0, :cond_0

    .line 34
    move-object v0, p0

    check-cast v0, Lcom/google/android/datatransport/runtime/TransportImpl;

    .line 35
    invoke-virtual {v0}, Lcom/google/android/datatransport/runtime/TransportImpl;->getTransportContext()Lcom/google/android/datatransport/runtime/TransportContext;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/google/android/datatransport/runtime/TransportContext;->withPriority(Lcom/google/android/datatransport/Priority;)Lcom/google/android/datatransport/runtime/TransportContext;

    move-result-object v0

    .line 36
    .local v0, "context":Lcom/google/android/datatransport/runtime/TransportContext;
    invoke-static {}, Lcom/google/android/datatransport/runtime/TransportRuntime;->getInstance()Lcom/google/android/datatransport/runtime/TransportRuntime;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/android/datatransport/runtime/TransportRuntime;->getUploader()Lcom/google/android/datatransport/runtime/scheduling/jobscheduling/Uploader;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v0, v2}, Lcom/google/android/datatransport/runtime/scheduling/jobscheduling/Uploader;->logAndUpdateState(Lcom/google/android/datatransport/runtime/TransportContext;I)Lcom/google/android/datatransport/runtime/backends/BackendResponse;

    .line 37
    .end local v0    # "context":Lcom/google/android/datatransport/runtime/TransportContext;
    goto :goto_0

    .line 38
    :cond_0
    const-string v0, "ForcedSender"

    const-string v1, "Expected instance of `TransportImpl`, got `%s`."

    invoke-static {v0, v1, p0}, Lcom/google/android/datatransport/runtime/logging/Logging;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    .line 40
    :goto_0
    return-void
.end method
