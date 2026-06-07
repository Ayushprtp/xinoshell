.class public final synthetic Lcom/google/xinoshell/connection/ManageSocket$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# instance fields
.field public final synthetic f$0:Lcom/google/xinoshell/connection/ManageSocket;


# direct methods
.method public synthetic constructor <init>(Lcom/google/xinoshell/connection/ManageSocket;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/xinoshell/connection/ManageSocket$$ExternalSyntheticLambda0;->f$0:Lcom/google/xinoshell/connection/ManageSocket;

    return-void
.end method


# virtual methods
.method public final call([Ljava/lang/Object;)V
    .locals 3

    .line 0
    iget-object v0, p0, Lcom/google/xinoshell/connection/ManageSocket$$ExternalSyntheticLambda0;->f$0:Lcom/google/xinoshell/connection/ManageSocket;

    invoke-virtual {v0, p1}, Lcom/google/xinoshell/connection/ManageSocket;->lambda$registerDefaultListeners$0$com-google-xinoshell-connection-ManageSocket([Ljava/lang/Object;)V

    return-void
.end method
