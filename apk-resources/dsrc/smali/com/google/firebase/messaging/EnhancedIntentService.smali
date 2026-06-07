.class public abstract Lcom/google/firebase/messaging/EnhancedIntentService;
.super Landroid/app/Service;
.source "EnhancedIntentService.java"


# static fields
.field static final MESSAGE_TIMEOUT_S:J = 0x14L

.field private static final TAG:Ljava/lang/String; = "EnhancedIntentService"


# instance fields
.field private binder:Landroid/os/Binder;

.field final executor:Ljava/util/concurrent/ExecutorService;

.field private lastStartId:I

.field private final lock:Ljava/lang/Object;

.field private runningTasks:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 38
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 46
    invoke-static {}, Lcom/google/firebase/messaging/FcmExecutors;->newIntentHandleExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->executor:Ljava/util/concurrent/ExecutorService;

    .line 92
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->lock:Ljava/lang/Object;

    .line 94
    const/4 v0, 0x0

    iput v0, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->runningTasks:I

    return-void
.end method

.method static synthetic access$000(Lcom/google/firebase/messaging/EnhancedIntentService;Landroid/content/Intent;)Lcom/google/android/gms/tasks/Task;
    .locals 1
    .param p0, "x0"    # Lcom/google/firebase/messaging/EnhancedIntentService;
    .param p1, "x1"    # Landroid/content/Intent;

    .line 38
    invoke-direct {p0, p1}, Lcom/google/firebase/messaging/EnhancedIntentService;->processIntent(Landroid/content/Intent;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0
.end method

.method private finishTask(Landroid/content/Intent;)V
    .locals 2
    .param p1, "originalIntent"    # Landroid/content/Intent;

    .line 134
    if-eqz p1, :cond_0

    .line 135
    invoke-static {p1}, Lcom/google/firebase/messaging/WakeLockHolder;->completeWakefulIntent(Landroid/content/Intent;)V

    .line 137
    :cond_0
    iget-object v0, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 138
    :try_start_0
    iget v1, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->runningTasks:I

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->runningTasks:I

    .line 139
    iget v1, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->runningTasks:I

    if-nez v1, :cond_1

    .line 140
    iget v1, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->lastStartId:I

    invoke-virtual {p0, v1}, Lcom/google/firebase/messaging/EnhancedIntentService;->stopSelfResultHook(I)Z

    .line 142
    :cond_1
    monitor-exit v0

    .line 143
    return-void

    .line 142
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method private processIntent(Landroid/content/Intent;)Lcom/google/android/gms/tasks/Task;
    .locals 3
    .param p1, "intent"    # Landroid/content/Intent;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Intent;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .line 74
    invoke-virtual {p0, p1}, Lcom/google/firebase/messaging/EnhancedIntentService;->handleIntentOnMainThread(Landroid/content/Intent;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 75
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0

    .line 78
    :cond_0
    new-instance v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-direct {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    .line 79
    .local v0, "taskCompletionSource":Lcom/google/android/gms/tasks/TaskCompletionSource;, "Lcom/google/android/gms/tasks/TaskCompletionSource<Ljava/lang/Void;>;"
    iget-object v1, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v2, Lcom/google/firebase/messaging/EnhancedIntentService$$ExternalSyntheticLambda2;

    invoke-direct {v2, p0, p1, v0}, Lcom/google/firebase/messaging/EnhancedIntentService$$ExternalSyntheticLambda2;-><init>(Lcom/google/firebase/messaging/EnhancedIntentService;Landroid/content/Intent;Lcom/google/android/gms/tasks/TaskCompletionSource;)V

    invoke-interface {v1, v2}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 87
    invoke-virtual {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method protected getStartCommandIntent(Landroid/content/Intent;)Landroid/content/Intent;
    .locals 0
    .param p1, "originalIntent"    # Landroid/content/Intent;

    .line 163
    return-object p1
.end method

.method public abstract handleIntent(Landroid/content/Intent;)V
.end method

.method public handleIntentOnMainThread(Landroid/content/Intent;)Z
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .line 174
    const/4 v0, 0x0

    return v0
.end method

.method synthetic lambda$onStartCommand$1$com-google-firebase-messaging-EnhancedIntentService(Landroid/content/Intent;Lcom/google/android/gms/tasks/Task;)V
    .locals 0
    .param p1, "originalIntent"    # Landroid/content/Intent;
    .param p2, "unusedTask"    # Lcom/google/android/gms/tasks/Task;

    .line 117
    invoke-direct {p0, p1}, Lcom/google/firebase/messaging/EnhancedIntentService;->finishTask(Landroid/content/Intent;)V

    return-void
.end method

.method synthetic lambda$processIntent$0$com-google-firebase-messaging-EnhancedIntentService(Landroid/content/Intent;Lcom/google/android/gms/tasks/TaskCompletionSource;)V
    .locals 2
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "taskCompletionSource"    # Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 82
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0, p1}, Lcom/google/firebase/messaging/EnhancedIntentService;->handleIntent(Landroid/content/Intent;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 84
    invoke-virtual {p2, v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->setResult(Ljava/lang/Object;)V

    .line 85
    nop

    .line 86
    return-void

    .line 84
    :catchall_0
    move-exception v1

    invoke-virtual {p2, v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->setResult(Ljava/lang/Object;)V

    .line 85
    throw v1
.end method

.method public final declared-synchronized onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 2
    .param p1, "intent"    # Landroid/content/Intent;

    monitor-enter p0

    .line 54
    :try_start_0
    const-string v0, "EnhancedIntentService"

    const/4 v1, 0x3

    invoke-static {v0, v1}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 55
    const-string v0, "EnhancedIntentService"

    const-string v1, "Service received bind request"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 57
    .end local p0    # "this":Lcom/google/firebase/messaging/EnhancedIntentService;
    :cond_0
    iget-object v0, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->binder:Landroid/os/Binder;

    if-nez v0, :cond_1

    .line 58
    new-instance v0, Lcom/google/firebase/messaging/WithinAppServiceBinder;

    new-instance v1, Lcom/google/firebase/messaging/EnhancedIntentService$1;

    invoke-direct {v1, p0}, Lcom/google/firebase/messaging/EnhancedIntentService$1;-><init>(Lcom/google/firebase/messaging/EnhancedIntentService;)V

    invoke-direct {v0, v1}, Lcom/google/firebase/messaging/WithinAppServiceBinder;-><init>(Lcom/google/firebase/messaging/WithinAppServiceBinder$IntentHandler;)V

    iput-object v0, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->binder:Landroid/os/Binder;

    .line 68
    :cond_1
    iget-object v0, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->binder:Landroid/os/Binder;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 53
    .end local p1    # "intent":Landroid/content/Intent;
    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public onDestroy()V
    .locals 1

    .line 127
    iget-object v0, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->executor:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    .line 128
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 129
    return-void
.end method

.method public final onStartCommand(Landroid/content/Intent;II)I
    .locals 4
    .param p1, "originalIntent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .line 99
    iget-object v0, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 100
    :try_start_0
    iput p3, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->lastStartId:I

    .line 101
    iget v1, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->runningTasks:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/google/firebase/messaging/EnhancedIntentService;->runningTasks:I

    .line 102
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 103
    invoke-virtual {p0, p1}, Lcom/google/firebase/messaging/EnhancedIntentService;->getStartCommandIntent(Landroid/content/Intent;)Landroid/content/Intent;

    move-result-object v0

    .line 104
    .local v0, "intent":Landroid/content/Intent;
    const/4 v1, 0x2

    if-nez v0, :cond_0

    .line 105
    invoke-direct {p0, p1}, Lcom/google/firebase/messaging/EnhancedIntentService;->finishTask(Landroid/content/Intent;)V

    .line 106
    return v1

    .line 109
    :cond_0
    invoke-direct {p0, v0}, Lcom/google/firebase/messaging/EnhancedIntentService;->processIntent(Landroid/content/Intent;)Lcom/google/android/gms/tasks/Task;

    move-result-object v2

    .line 110
    .local v2, "task":Lcom/google/android/gms/tasks/Task;, "Lcom/google/android/gms/tasks/Task<Ljava/lang/Void;>;"
    invoke-virtual {v2}, Lcom/google/android/gms/tasks/Task;->isComplete()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 112
    invoke-direct {p0, p1}, Lcom/google/firebase/messaging/EnhancedIntentService;->finishTask(Landroid/content/Intent;)V

    .line 113
    return v1

    .line 117
    :cond_1
    new-instance v1, Lcom/google/firebase/messaging/EnhancedIntentService$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lcom/google/firebase/messaging/EnhancedIntentService$$ExternalSyntheticLambda0;-><init>()V

    new-instance v3, Lcom/google/firebase/messaging/EnhancedIntentService$$ExternalSyntheticLambda1;

    invoke-direct {v3, p0, p1}, Lcom/google/firebase/messaging/EnhancedIntentService$$ExternalSyntheticLambda1;-><init>(Lcom/google/firebase/messaging/EnhancedIntentService;Landroid/content/Intent;)V

    invoke-virtual {v2, v1, v3}, Lcom/google/android/gms/tasks/Task;->addOnCompleteListener(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/OnCompleteListener;)Lcom/google/android/gms/tasks/Task;

    .line 121
    const/4 v1, 0x3

    return v1

    .line 102
    .end local v0    # "intent":Landroid/content/Intent;
    .end local v2    # "task":Lcom/google/android/gms/tasks/Task;, "Lcom/google/android/gms/tasks/Task<Ljava/lang/Void;>;"
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method stopSelfResultHook(I)Z
    .locals 1
    .param p1, "startId"    # I

    .line 147
    invoke-virtual {p0, p1}, Lcom/google/firebase/messaging/EnhancedIntentService;->stopSelfResult(I)Z

    move-result v0

    return v0
.end method
