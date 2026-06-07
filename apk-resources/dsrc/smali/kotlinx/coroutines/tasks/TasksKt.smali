.class public final Lkotlinx/coroutines/tasks/TasksKt;
.super Ljava/lang/Object;
.source "Tasks.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nTasks.kt\nKotlin\n*S Kotlin\n*F\n+ 1 Tasks.kt\nkotlinx/coroutines/tasks/TasksKt\n+ 2 CancellableContinuation.kt\nkotlinx/coroutines/CancellableContinuationKt\n*L\n1#1,164:1\n351#2,11:165\n*S KotlinDebug\n*F\n+ 1 Tasks.kt\nkotlinx/coroutines/tasks/TasksKt\n*L\n136#1:165,11\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0006\u001a\u001c\u0010\u0000\u001a\u0008\u0012\u0004\u0012\u0002H\u00020\u0001\"\u0004\u0008\u0000\u0010\u0002*\u0008\u0012\u0004\u0012\u0002H\u00020\u0003\u001a\u001c\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u0002H\u00020\u0003\"\u0004\u0008\u0000\u0010\u0002*\u0008\u0012\u0004\u0012\u0002H\u00020\u0001\u001a&\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u0002H\u00020\u0003\"\u0004\u0008\u0000\u0010\u0002*\u0008\u0012\u0004\u0012\u0002H\u00020\u00012\u0006\u0010\u0005\u001a\u00020\u0006H\u0007\u001a(\u0010\u0007\u001a\u0008\u0012\u0004\u0012\u0002H\u00020\u0003\"\u0004\u0008\u0000\u0010\u0002*\u0008\u0012\u0004\u0012\u0002H\u00020\u00012\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u0006H\u0002\u001a\u001e\u0010\u0008\u001a\u0002H\u0002\"\u0004\u0008\u0000\u0010\u0002*\u0008\u0012\u0004\u0012\u0002H\u00020\u0001H\u0086@\u00a2\u0006\u0002\u0010\t\u001a&\u0010\u0008\u001a\u0002H\u0002\"\u0004\u0008\u0000\u0010\u0002*\u0008\u0012\u0004\u0012\u0002H\u00020\u00012\u0006\u0010\u0005\u001a\u00020\u0006H\u0087@\u00a2\u0006\u0002\u0010\n\u001a(\u0010\u000b\u001a\u0002H\u0002\"\u0004\u0008\u0000\u0010\u0002*\u0008\u0012\u0004\u0012\u0002H\u00020\u00012\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u0006H\u0082@\u00a2\u0006\u0002\u0010\n\u00a8\u0006\u000c"
    }
    d2 = {
        "asTask",
        "Lcom/google/android/gms/tasks/Task;",
        "T",
        "Lkotlinx/coroutines/Deferred;",
        "asDeferred",
        "cancellationTokenSource",
        "Lcom/google/android/gms/tasks/CancellationTokenSource;",
        "asDeferredImpl",
        "await",
        "(Lcom/google/android/gms/tasks/Task;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "awaitImpl",
        "kotlinx-coroutines-play-services"
    }
    k = 0x2
    mv = {
        0x2,
        0x0,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static synthetic $r8$lambda$5f1mT_oG6KfnaA6v83cFog9ygp8(Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlinx/coroutines/Deferred;Lcom/google/android/gms/tasks/TaskCompletionSource;Ljava/lang/Throwable;)Lkotlin/Unit;
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lkotlinx/coroutines/tasks/TasksKt;->asTask$lambda$0(Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlinx/coroutines/Deferred;Lcom/google/android/gms/tasks/TaskCompletionSource;Ljava/lang/Throwable;)Lkotlin/Unit;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$KKtandt8fYuSCG03KTNU_gUwQgM(Lkotlinx/coroutines/CompletableDeferred;Lcom/google/android/gms/tasks/Task;)V
    .locals 0

    invoke-static {p0, p1}, Lkotlinx/coroutines/tasks/TasksKt;->asDeferredImpl$lambda$1(Lkotlinx/coroutines/CompletableDeferred;Lcom/google/android/gms/tasks/Task;)V

    return-void
.end method

.method public static synthetic $r8$lambda$WS4CsADCb8YgmqyOAgsLZD2JfF0(Lcom/google/android/gms/tasks/CancellationTokenSource;Ljava/lang/Throwable;)Lkotlin/Unit;
    .locals 0

    invoke-static {p0, p1}, Lkotlinx/coroutines/tasks/TasksKt;->asDeferredImpl$lambda$2(Lcom/google/android/gms/tasks/CancellationTokenSource;Ljava/lang/Throwable;)Lkotlin/Unit;

    move-result-object p0

    return-object p0
.end method

.method public static final synthetic access$awaitImpl(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$receiver"    # Lcom/google/android/gms/tasks/Task;
    .param p1, "cancellationTokenSource"    # Lcom/google/android/gms/tasks/CancellationTokenSource;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 1
    invoke-static {p0, p1, p2}, Lkotlinx/coroutines/tasks/TasksKt;->awaitImpl(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final asDeferred(Lcom/google/android/gms/tasks/Task;)Lkotlinx/coroutines/Deferred;
    .locals 1
    .param p0, "$this$asDeferred"    # Lcom/google/android/gms/tasks/Task;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/tasks/Task<",
            "TT;>;)",
            "Lkotlinx/coroutines/Deferred<",
            "TT;>;"
        }
    .end annotation

    .line 42
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lkotlinx/coroutines/tasks/TasksKt;->asDeferredImpl(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;)Lkotlinx/coroutines/Deferred;

    move-result-object v0

    return-object v0
.end method

.method public static final asDeferred(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;)Lkotlinx/coroutines/Deferred;
    .locals 1
    .param p0, "$this$asDeferred"    # Lcom/google/android/gms/tasks/Task;
    .param p1, "cancellationTokenSource"    # Lcom/google/android/gms/tasks/CancellationTokenSource;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/tasks/Task<",
            "TT;>;",
            "Lcom/google/android/gms/tasks/CancellationTokenSource;",
            ")",
            "Lkotlinx/coroutines/Deferred<",
            "TT;>;"
        }
    .end annotation

    .line 55
    invoke-static {p0, p1}, Lkotlinx/coroutines/tasks/TasksKt;->asDeferredImpl(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;)Lkotlinx/coroutines/Deferred;

    move-result-object v0

    return-object v0
.end method

.method private static final asDeferredImpl(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;)Lkotlinx/coroutines/Deferred;
    .locals 5
    .param p0, "$this$asDeferredImpl"    # Lcom/google/android/gms/tasks/Task;
    .param p1, "cancellationTokenSource"    # Lcom/google/android/gms/tasks/CancellationTokenSource;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/tasks/Task<",
            "TT;>;",
            "Lcom/google/android/gms/tasks/CancellationTokenSource;",
            ")",
            "Lkotlinx/coroutines/Deferred<",
            "TT;>;"
        }
    .end annotation

    .line 58
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-static {v0, v1, v0}, Lkotlinx/coroutines/CompletableDeferredKt;->CompletableDeferred$default(Lkotlinx/coroutines/Job;ILjava/lang/Object;)Lkotlinx/coroutines/CompletableDeferred;

    move-result-object v2

    .line 59
    .local v2, "deferred":Lkotlinx/coroutines/CompletableDeferred;
    invoke-virtual {p0}, Lcom/google/android/gms/tasks/Task;->isComplete()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 60
    invoke-virtual {p0}, Lcom/google/android/gms/tasks/Task;->getException()Ljava/lang/Exception;

    move-result-object v3

    .line 61
    .local v3, "e":Ljava/lang/Exception;
    if-nez v3, :cond_1

    .line 62
    invoke-virtual {p0}, Lcom/google/android/gms/tasks/Task;->isCanceled()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 63
    move-object v4, v2

    check-cast v4, Lkotlinx/coroutines/Job;

    invoke-static {v4, v0, v1, v0}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    goto :goto_0

    .line 66
    :cond_0
    invoke-virtual {p0}, Lcom/google/android/gms/tasks/Task;->getResult()Ljava/lang/Object;

    move-result-object v0

    invoke-interface {v2, v0}, Lkotlinx/coroutines/CompletableDeferred;->complete(Ljava/lang/Object;)Z

    goto :goto_0

    .line 69
    :cond_1
    move-object v0, v3

    check-cast v0, Ljava/lang/Throwable;

    invoke-interface {v2, v0}, Lkotlinx/coroutines/CompletableDeferred;->completeExceptionally(Ljava/lang/Throwable;)Z

    goto :goto_0

    .line 73
    .end local v3    # "e":Ljava/lang/Exception;
    :cond_2
    sget-object v0, Lkotlinx/coroutines/tasks/DirectExecutor;->INSTANCE:Lkotlinx/coroutines/tasks/DirectExecutor;

    check-cast v0, Ljava/util/concurrent/Executor;

    new-instance v1, Lkotlinx/coroutines/tasks/TasksKt$$ExternalSyntheticLambda0;

    invoke-direct {v1, v2}, Lkotlinx/coroutines/tasks/TasksKt$$ExternalSyntheticLambda0;-><init>(Lkotlinx/coroutines/CompletableDeferred;)V

    invoke-virtual {p0, v0, v1}, Lcom/google/android/gms/tasks/Task;->addOnCompleteListener(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/OnCompleteListener;)Lcom/google/android/gms/tasks/Task;

    .line 84
    :goto_0
    if-eqz p1, :cond_3

    .line 85
    new-instance v0, Lkotlinx/coroutines/tasks/TasksKt$$ExternalSyntheticLambda1;

    invoke-direct {v0, p1}, Lkotlinx/coroutines/tasks/TasksKt$$ExternalSyntheticLambda1;-><init>(Lcom/google/android/gms/tasks/CancellationTokenSource;)V

    invoke-interface {v2, v0}, Lkotlinx/coroutines/CompletableDeferred;->invokeOnCompletion(Lkotlin/jvm/functions/Function1;)Lkotlinx/coroutines/DisposableHandle;

    .line 91
    :cond_3
    new-instance v0, Lkotlinx/coroutines/tasks/TasksKt$asDeferredImpl$3;

    invoke-direct {v0, v2}, Lkotlinx/coroutines/tasks/TasksKt$asDeferredImpl$3;-><init>(Lkotlinx/coroutines/CompletableDeferred;)V

    check-cast v0, Lkotlinx/coroutines/Deferred;

    return-object v0
.end method

.method private static final asDeferredImpl$lambda$1(Lkotlinx/coroutines/CompletableDeferred;Lcom/google/android/gms/tasks/Task;)V
    .locals 4
    .param p0, "$deferred"    # Lkotlinx/coroutines/CompletableDeferred;
    .param p1, "it"    # Lcom/google/android/gms/tasks/Task;

    .line 74
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->getException()Ljava/lang/Exception;

    move-result-object v0

    .line 75
    .local v0, "e":Ljava/lang/Exception;
    if-nez v0, :cond_1

    .line 77
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->isCanceled()Z

    move-result v1

    if-eqz v1, :cond_0

    move-object v1, p0

    check-cast v1, Lkotlinx/coroutines/Job;

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-static {v1, v3, v2, v3}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->getResult()Ljava/lang/Object;

    move-result-object v1

    invoke-interface {p0, v1}, Lkotlinx/coroutines/CompletableDeferred;->complete(Ljava/lang/Object;)Z

    goto :goto_0

    .line 79
    :cond_1
    move-object v1, v0

    check-cast v1, Ljava/lang/Throwable;

    invoke-interface {p0, v1}, Lkotlinx/coroutines/CompletableDeferred;->completeExceptionally(Ljava/lang/Throwable;)Z

    .line 81
    :goto_0
    return-void
.end method

.method private static final asDeferredImpl$lambda$2(Lcom/google/android/gms/tasks/CancellationTokenSource;Ljava/lang/Throwable;)Lkotlin/Unit;
    .locals 1
    .param p0, "$cancellationTokenSource"    # Lcom/google/android/gms/tasks/CancellationTokenSource;
    .param p1, "it"    # Ljava/lang/Throwable;

    .line 86
    invoke-virtual {p0}, Lcom/google/android/gms/tasks/CancellationTokenSource;->cancel()V

    .line 87
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public static final asTask(Lkotlinx/coroutines/Deferred;)Lcom/google/android/gms/tasks/Task;
    .locals 3
    .param p0, "$this$asTask"    # Lkotlinx/coroutines/Deferred;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlinx/coroutines/Deferred<",
            "+TT;>;)",
            "Lcom/google/android/gms/tasks/Task<",
            "TT;>;"
        }
    .end annotation

    .line 16
    new-instance v0, Lcom/google/android/gms/tasks/CancellationTokenSource;

    invoke-direct {v0}, Lcom/google/android/gms/tasks/CancellationTokenSource;-><init>()V

    .line 17
    .local v0, "cancellation":Lcom/google/android/gms/tasks/CancellationTokenSource;
    new-instance v1, Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-virtual {v0}, Lcom/google/android/gms/tasks/CancellationTokenSource;->getToken()Lcom/google/android/gms/tasks/CancellationToken;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>(Lcom/google/android/gms/tasks/CancellationToken;)V

    .line 19
    .local v1, "source":Lcom/google/android/gms/tasks/TaskCompletionSource;
    new-instance v2, Lkotlinx/coroutines/tasks/TasksKt$$ExternalSyntheticLambda2;

    invoke-direct {v2, v0, p0, v1}, Lkotlinx/coroutines/tasks/TasksKt$$ExternalSyntheticLambda2;-><init>(Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlinx/coroutines/Deferred;Lcom/google/android/gms/tasks/TaskCompletionSource;)V

    invoke-interface {p0, v2}, Lkotlinx/coroutines/Deferred;->invokeOnCompletion(Lkotlin/jvm/functions/Function1;)Lkotlinx/coroutines/DisposableHandle;

    .line 33
    invoke-virtual {v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    move-result-object v2

    return-object v2
.end method

.method private static final asTask$lambda$0(Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlinx/coroutines/Deferred;Lcom/google/android/gms/tasks/TaskCompletionSource;Ljava/lang/Throwable;)Lkotlin/Unit;
    .locals 2
    .param p0, "$cancellation"    # Lcom/google/android/gms/tasks/CancellationTokenSource;
    .param p1, "$this_asTask"    # Lkotlinx/coroutines/Deferred;
    .param p2, "$source"    # Lcom/google/android/gms/tasks/TaskCompletionSource;
    .param p3, "it"    # Ljava/lang/Throwable;

    .line 20
    instance-of v0, p3, Ljava/util/concurrent/CancellationException;

    if-eqz v0, :cond_0

    .line 21
    invoke-virtual {p0}, Lcom/google/android/gms/tasks/CancellationTokenSource;->cancel()V

    .line 22
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 25
    :cond_0
    invoke-interface {p1}, Lkotlinx/coroutines/Deferred;->getCompletionExceptionOrNull()Ljava/lang/Throwable;

    move-result-object v0

    .line 26
    .local v0, "t":Ljava/lang/Throwable;
    if-nez v0, :cond_1

    .line 27
    invoke-interface {p1}, Lkotlinx/coroutines/Deferred;->getCompleted()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p2, v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->setResult(Ljava/lang/Object;)V

    goto :goto_1

    .line 29
    :cond_1
    instance-of v1, v0, Ljava/lang/Exception;

    if-eqz v1, :cond_2

    move-object v1, v0

    check-cast v1, Ljava/lang/Exception;

    goto :goto_0

    :cond_2
    const/4 v1, 0x0

    :goto_0
    if-nez v1, :cond_3

    new-instance v1, Lcom/google/android/gms/tasks/RuntimeExecutionException;

    invoke-direct {v1, v0}, Lcom/google/android/gms/tasks/RuntimeExecutionException;-><init>(Ljava/lang/Throwable;)V

    check-cast v1, Ljava/lang/Exception;

    :cond_3
    invoke-virtual {p2, v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->setException(Ljava/lang/Exception;)V

    .line 31
    :goto_1
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1
.end method

.method public static final await(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this$await"    # Lcom/google/android/gms/tasks/Task;
    .param p1, "cancellationTokenSource"    # Lcom/google/android/gms/tasks/CancellationTokenSource;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/tasks/Task<",
            "TT;>;",
            "Lcom/google/android/gms/tasks/CancellationTokenSource;",
            "Lkotlin/coroutines/Continuation<",
            "-TT;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 118
    invoke-static {p0, p1, p2}, Lkotlinx/coroutines/tasks/TasksKt;->awaitImpl(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final await(Lcom/google/android/gms/tasks/Task;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this$await"    # Lcom/google/android/gms/tasks/Task;
    .param p1, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/tasks/Task<",
            "TT;>;",
            "Lkotlin/coroutines/Continuation<",
            "-TT;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 103
    const/4 v0, 0x0

    invoke-static {p0, v0, p1}, Lkotlinx/coroutines/tasks/TasksKt;->awaitImpl(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method private static final awaitImpl(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/CancellationTokenSource;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 8
    .param p0, "$this$awaitImpl"    # Lcom/google/android/gms/tasks/Task;
    .param p1, "cancellationTokenSource"    # Lcom/google/android/gms/tasks/CancellationTokenSource;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/google/android/gms/tasks/Task<",
            "TT;>;",
            "Lcom/google/android/gms/tasks/CancellationTokenSource;",
            "Lkotlin/coroutines/Continuation<",
            "-TT;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 122
    invoke-virtual {p0}, Lcom/google/android/gms/tasks/Task;->isComplete()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 123
    invoke-virtual {p0}, Lcom/google/android/gms/tasks/Task;->getException()Ljava/lang/Exception;

    move-result-object v0

    .line 124
    .local v0, "e":Ljava/lang/Exception;
    if-nez v0, :cond_1

    .line 125
    invoke-virtual {p0}, Lcom/google/android/gms/tasks/Task;->isCanceled()Z

    move-result v1

    if-nez v1, :cond_0

    .line 129
    invoke-virtual {p0}, Lcom/google/android/gms/tasks/Task;->getResult()Ljava/lang/Object;

    move-result-object v1

    .line 124
    return-object v1

    .line 126
    :cond_0
    new-instance v1, Ljava/util/concurrent/CancellationException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Task "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " was cancelled normally."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/concurrent/CancellationException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 132
    :cond_1
    throw v0

    .line 136
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_2
    const/4 v0, 0x0

    .line 165
    .local v0, "$i$f$suspendCancellableCoroutine":I
    move-object v1, p2

    .local v1, "uCont$iv":Lkotlin/coroutines/Continuation;
    const/4 v2, 0x0

    .line 166
    .local v2, "$i$a$-suspendCoroutineUninterceptedOrReturn-CancellableContinuationKt$suspendCancellableCoroutine$2$iv":I
    new-instance v3, Lkotlinx/coroutines/CancellableContinuationImpl;

    invoke-static {v1}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->intercepted(Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v4

    const/4 v5, 0x1

    invoke-direct {v3, v4, v5}, Lkotlinx/coroutines/CancellableContinuationImpl;-><init>(Lkotlin/coroutines/Continuation;I)V

    .line 172
    .local v3, "cancellable$iv":Lkotlinx/coroutines/CancellableContinuationImpl;
    invoke-virtual {v3}, Lkotlinx/coroutines/CancellableContinuationImpl;->initCancellability()V

    .line 173
    move-object v4, v3

    check-cast v4, Lkotlinx/coroutines/CancellableContinuation;

    .local v4, "cont":Lkotlinx/coroutines/CancellableContinuation;
    const/4 v5, 0x0

    .line 138
    .local v5, "$i$a$-suspendCancellableCoroutine-TasksKt$awaitImpl$2":I
    sget-object v6, Lkotlinx/coroutines/tasks/DirectExecutor;->INSTANCE:Lkotlinx/coroutines/tasks/DirectExecutor;

    check-cast v6, Ljava/util/concurrent/Executor;

    new-instance v7, Lkotlinx/coroutines/tasks/TasksKt$awaitImpl$2$1;

    invoke-direct {v7, v4}, Lkotlinx/coroutines/tasks/TasksKt$awaitImpl$2$1;-><init>(Lkotlinx/coroutines/CancellableContinuation;)V

    check-cast v7, Lcom/google/android/gms/tasks/OnCompleteListener;

    invoke-virtual {p0, v6, v7}, Lcom/google/android/gms/tasks/Task;->addOnCompleteListener(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/OnCompleteListener;)Lcom/google/android/gms/tasks/Task;

    .line 148
    if-eqz p1, :cond_3

    .line 149
    new-instance v6, Lkotlinx/coroutines/tasks/TasksKt$awaitImpl$2$2;

    invoke-direct {v6, p1}, Lkotlinx/coroutines/tasks/TasksKt$awaitImpl$2$2;-><init>(Lcom/google/android/gms/tasks/CancellationTokenSource;)V

    check-cast v6, Lkotlin/jvm/functions/Function1;

    invoke-interface {v4, v6}, Lkotlinx/coroutines/CancellableContinuation;->invokeOnCancellation(Lkotlin/jvm/functions/Function1;)V

    .line 153
    :cond_3
    nop

    .line 173
    .end local v4    # "cont":Lkotlinx/coroutines/CancellableContinuation;
    .end local v5    # "$i$a$-suspendCancellableCoroutine-TasksKt$awaitImpl$2":I
    nop

    .line 174
    invoke-virtual {v3}, Lkotlinx/coroutines/CancellableContinuationImpl;->getResult()Ljava/lang/Object;

    move-result-object v1

    .line 165
    .end local v1    # "uCont$iv":Lkotlin/coroutines/Continuation;
    .end local v2    # "$i$a$-suspendCoroutineUninterceptedOrReturn-CancellableContinuationKt$suspendCancellableCoroutine$2$iv":I
    .end local v3    # "cancellable$iv":Lkotlinx/coroutines/CancellableContinuationImpl;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v2

    if-ne v1, v2, :cond_4

    invoke-static {p2}, Lkotlin/coroutines/jvm/internal/DebugProbesKt;->probeCoroutineSuspended(Lkotlin/coroutines/Continuation;)V

    .line 175
    :cond_4
    nop

    .line 136
    .end local v0    # "$i$f$suspendCancellableCoroutine":I
    return-object v1
.end method
