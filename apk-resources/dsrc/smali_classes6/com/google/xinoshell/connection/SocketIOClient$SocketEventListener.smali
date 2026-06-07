.class public interface abstract Lcom/google/xinoshell/connection/SocketIOClient$SocketEventListener;
.super Ljava/lang/Object;
.source "SocketIOClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/xinoshell/connection/SocketIOClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "SocketEventListener"
.end annotation


# virtual methods
.method public abstract onConnectionStateChanged(Z)V
.end method

.method public varargs abstract onEventReceived(Ljava/lang/String;[Ljava/lang/Object;)V
.end method
