.class final Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "JavaDataStorage.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/firebase/datastorage/JavaDataStorage;->editSync(Lkotlin/jvm/functions/Function1;)Landroidx/datastore/preferences/core/Preferences;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/SuspendLambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Lkotlinx/coroutines/CoroutineScope;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Landroidx/datastore/preferences/core/Preferences;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\n"
    }
    d2 = {
        "<anonymous>",
        "Landroidx/datastore/preferences/core/Preferences;",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x2,
        0x0,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.google.firebase.datastorage.JavaDataStorage$editSync$1"
    f = "JavaDataStorage.kt"
    i = {}
    l = {
        0xcf
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $transform:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Landroidx/datastore/preferences/core/MutablePreferences;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field label:I

.field final synthetic this$0:Lcom/google/firebase/datastorage/JavaDataStorage;


# direct methods
.method constructor <init>(Lcom/google/firebase/datastorage/JavaDataStorage;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/firebase/datastorage/JavaDataStorage;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Landroidx/datastore/preferences/core/MutablePreferences;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->this$0:Lcom/google/firebase/datastorage/JavaDataStorage;

    iput-object p2, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->$transform:Lkotlin/jvm/functions/Function1;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p3}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "*>;)",
            "Lkotlin/coroutines/Continuation<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;

    iget-object v1, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->this$0:Lcom/google/firebase/datastorage/JavaDataStorage;

    iget-object v2, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->$transform:Lkotlin/jvm/functions/Function1;

    invoke-direct {v0, v1, v2, p2}, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;-><init>(Lcom/google/firebase/datastorage/JavaDataStorage;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CoroutineScope;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Landroidx/datastore/preferences/core/Preferences;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 8

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 194
    iget v1, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->label:I

    const/4 v2, 0x0

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .local p1, "$result":Ljava/lang/Object;
    :pswitch_0
    :try_start_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v0, p1

    goto :goto_0

    .line 209
    :catchall_0
    move-exception v0

    goto :goto_1

    .line 194
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 195
    .restart local p1    # "$result":Ljava/lang/Object;
    iget-object v1, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->this$0:Lcom/google/firebase/datastorage/JavaDataStorage;

    invoke-static {v1}, Lcom/google/firebase/datastorage/JavaDataStorage;->access$getEditLock$p(Lcom/google/firebase/datastorage/JavaDataStorage;)Ljava/lang/ThreadLocal;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v1

    const/4 v3, 0x1

    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 205
    iget-object v1, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->this$0:Lcom/google/firebase/datastorage/JavaDataStorage;

    invoke-static {v1}, Lcom/google/firebase/datastorage/JavaDataStorage;->access$getEditLock$p(Lcom/google/firebase/datastorage/JavaDataStorage;)Ljava/lang/ThreadLocal;

    move-result-object v1

    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 206
    nop

    .line 207
    :try_start_1
    iget-object v1, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->this$0:Lcom/google/firebase/datastorage/JavaDataStorage;

    invoke-static {v1}, Lcom/google/firebase/datastorage/JavaDataStorage;->access$getDataStore$p(Lcom/google/firebase/datastorage/JavaDataStorage;)Landroidx/datastore/core/DataStore;

    move-result-object v1

    new-instance v4, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1$1;

    iget-object v5, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->$transform:Lkotlin/jvm/functions/Function1;

    const/4 v6, 0x0

    invoke-direct {v4, v5, v6}, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1$1;-><init>(Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v4, Lkotlin/jvm/functions/Function2;

    move-object v5, p0

    check-cast v5, Lkotlin/coroutines/Continuation;

    iput v3, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->label:I

    invoke-static {v1, v4, v5}, Landroidx/datastore/preferences/core/PreferencesKt;->edit(Landroidx/datastore/core/DataStore;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-ne v1, v0, :cond_0

    .line 194
    return-object v0

    .line 207
    :cond_0
    move-object v0, p1

    move-object p1, v1

    .line 194
    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "$result":Ljava/lang/Object;
    :goto_0
    :try_start_2
    check-cast p1, Landroidx/datastore/preferences/core/Preferences;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 209
    iget-object v1, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->this$0:Lcom/google/firebase/datastorage/JavaDataStorage;

    invoke-static {v1}, Lcom/google/firebase/datastorage/JavaDataStorage;->access$getEditLock$p(Lcom/google/firebase/datastorage/JavaDataStorage;)Ljava/lang/ThreadLocal;

    move-result-object v1

    invoke-static {v2}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 210
    return-object p1

    .line 209
    :catchall_1
    move-exception p1

    move-object v7, v0

    move-object v0, p1

    move-object p1, v7

    .end local v0    # "$result":Ljava/lang/Object;
    .restart local p1    # "$result":Ljava/lang/Object;
    :goto_1
    iget-object v1, p0, Lcom/google/firebase/datastorage/JavaDataStorage$editSync$1;->this$0:Lcom/google/firebase/datastorage/JavaDataStorage;

    invoke-static {v1}, Lcom/google/firebase/datastorage/JavaDataStorage;->access$getEditLock$p(Lcom/google/firebase/datastorage/JavaDataStorage;)Ljava/lang/ThreadLocal;

    move-result-object v1

    invoke-static {v2}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    throw v0

    .line 196
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    .line 202
    nop

    .line 196
    const-string v1, "Don\'t call JavaDataStorage.edit() from within an existing edit() callback.\nThis causes deadlocks, and is generally indicative of a code smell.\nInstead, either pass around the initial `MutablePreferences` instance, or don\'t do everything in a single callback. "

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
