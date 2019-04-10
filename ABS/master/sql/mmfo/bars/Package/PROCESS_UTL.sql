PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/PROCESS_UTL       ====== *** End ***
PROMPT ===================================================================================== 

create or replace package PROCESS_UTL is

   -- Author  : OLEH.YAROSHENKO
   -- Created : 4/25/2018 3:54:31 PM
   -- Purpose : Пакет для работы с процессами

   gc_header_version  constant varchar2(64)  := 'version 1.0 04/25/2018';

   --Declare constant for Process State
   GC_PROCESS_STATE         constant list_type.list_code%type    := 'PROCESS_STATE';

   GC_PROCESS_STATE_UNDEF   constant list_item.list_item_id%type := 0;
   GC_PROCESS_STATE_CREATE  constant list_item.list_item_id%type := 1;
   GC_PROCESS_STATE_RUN     constant list_item.list_item_id%type := 2;
   GC_PROCESS_STATE_FAILURE constant list_item.list_item_id%type := 3;
   GC_PROCESS_STATE_DISCARD constant list_item.list_item_id%type := 4;
   GC_PROCESS_STATE_SUCCESS constant list_item.list_item_id%type := 5;

   LT_ACTIVITY_STATE  constant varchar2(30) := 'PROCESS_ACTIVITY_STATE';
   ACT_STATE_CREATED  constant integer := 1;
   ACT_STATE_OMITED   constant integer := 2;
   ACT_STATE_FAILED   constant integer := 3;
   ACT_STATE_REMOVED  constant integer := 4;
   ACT_STATE_DONE     constant integer := 5;

   type t_proc_flow_dep_lst is table of process_workflow_dependency%rowtype;

   function header_version return varchar2;

   function body_version return varchar2;

   function read_proc_type(
                             p_proc_type_id in process_type.id%type
                             , p_lock       in boolean default false
                             , p_raise_ndf  in boolean default false
                          )
   return process_type%rowtype;

   function read_proc_type(
                             p_proc_type_code in process_type.process_code%type
                             , p_module_code  in process_type.module_code%type
                             , p_lock         in boolean default false
                             , p_raise_ndf    in boolean default false
                          )
   return process_type%rowtype;

   function get_proc_type_id(
                               p_proc_type_code in process_type.process_code%type
                               , p_module_code  in process_type.module_code%type
                               , p_raise_ndf    in boolean default false
                            )
   return bars.process_type.id%type;

   function get_proc_type_module(
                                   p_proc_type_id in process_type.id%type
                                   , p_raise_ndf  in boolean default false
                                )
   return bars.process_type.module_code%type;

   function get_proc_type_code(
                                 p_proc_type_id in process_type.id%type
                                 , p_raise_ndf  in boolean default false
                              )
   return bars.process_type.process_code%type;

   function get_proc_type_name(
                                 p_proc_type_id in process_type.id%type
                                 , p_raise_ndf  in boolean default false
                              )
   return bars.process_type.process_name%type;

   function get_proc_type_can_create(
                                       p_proc_type_id in process_type.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_type.can_create%type;

   function get_proc_type_can_run(
                                    p_proc_type_id in process_type.id%type
                                    , p_raise_ndf  in boolean default false
                                 )
   return bars.process_type.can_run%type;

   function get_proc_type_can_revert(
                                       p_proc_type_id in process_type.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_type.can_revert%type;

   function get_proc_type_can_remove(
                                       p_proc_type_id in process_type.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_type.can_remove%type;

   function get_proc_type_on_create(
                                      p_proc_type_id in process_type.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_type.on_create%type;

   function get_proc_type_on_run(
                                   p_proc_type_id in process_type.id%type
                                   , p_raise_ndf  in boolean default false
                                )
   return bars.process_type.on_run%type;

   function get_proc_type_on_revert(
                                      p_proc_type_id in process_type.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_type.on_revert%type;

   function get_proc_type_on_remove(
                                      p_proc_type_id in process_type.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_type.on_remove%type;

   function get_proc_type_is_active(
                                      p_proc_type_id in process_type.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_type.is_active%type;

   procedure set_proc_type_module(
                                    p_proc_type_id in bars.process_type.id%type
                                    , p_value      in bars.process_type.module_code%type
                                    , p_raise_ndf  in boolean default false
                                 );

   procedure set_proc_type_code(
                                  p_proc_type_id in bars.process_type.id%type
                                  , p_value      in bars.process_type.process_code%type
                                  , p_raise_ndf  in boolean default false
                               );

   procedure set_proc_type_name(
                                  p_proc_type_id in bars.process_type.id%type
                                  , p_value      in bars.process_type.process_name%type
                                  , p_raise_ndf  in boolean default false
                               );

   procedure set_proc_type_can_create(
                                        p_proc_type_id in bars.process_type.id%type
                                        , p_value      in bars.process_type.can_create%type
                                        , p_raise_ndf  in boolean default false
                                     );

   procedure set_proc_type_can_run(
                                     p_proc_type_id in bars.process_type.id%type
                                     , p_value      in bars.process_type.can_run%type
                                     , p_raise_ndf  in boolean default false
                                  );

   procedure set_proc_type_can_revert(
                                        p_proc_type_id in bars.process_type.id%type
                                        , p_value      in bars.process_type.can_revert%type
                                        , p_raise_ndf  in boolean default false
                                     );

   procedure set_proc_type_can_remove(
                                        p_proc_type_id in bars.process_type.id%type
                                        , p_value      in bars.process_type.can_remove%type
                                        , p_raise_ndf  in boolean default false
                                     );

   procedure set_proc_type_on_create(
                                       p_proc_type_id in bars.process_type.id%type
                                       , p_value      in bars.process_type.on_create%type
                                       , p_raise_ndf  in boolean default false
                                    );

   procedure set_proc_type_on_run(
                                    p_proc_type_id in bars.process_type.id%type
                                    , p_value      in bars.process_type.on_run%type
                                    , p_raise_ndf  in boolean default false
                                 );

   procedure set_proc_type_on_revert(
                                       p_proc_type_id in bars.process_type.id%type
                                       , p_value      in bars.process_type.on_revert%type
                                       , p_raise_ndf  in boolean default false
                                    );

   procedure set_proc_type_on_remove(
                                       p_proc_type_id in bars.process_type.id%type
                                       , p_value      in bars.process_type.on_remove%type
                                       , p_raise_ndf  in boolean default false
                                    );

   procedure set_proc_type_is_active(
                                       p_proc_type_id in bars.process_type.id%type
                                       , p_value      in bars.process_type.is_active%type
                                       , p_raise_ndf  in boolean default false
                                    );

   function corr_proc_type(
                             p_module_code    in process_type.module_code%type
                             , p_process_code in process_type.process_code%type
                             , p_process_name in process_type.process_name%type
                             , p_can_create   in process_type.can_create%type   default null
                             , p_can_run      in process_type.can_run%type      default null
                             , p_can_revert   in process_type.can_revert%type   default null
                             , p_can_remove   in process_type.can_remove%type   default null
                             , p_on_create    in process_type.on_create%type    default null
                             , p_on_run       in process_type.on_run%type       default null
                             , p_on_revert    in process_type.on_revert%type    default null
                             , p_on_remove    in process_type.on_remove%type    default null
                             , p_is_active    in process_type.is_active%type    default 'N'
                             , p_raise_ndf    in boolean                        default false
                      )
   return process_type.id%type;

   function read_proc_flow(
                             p_proc_flow_id  in process_type.id%type
                             , p_lock        in boolean default false
                             , p_raise_ndf   in boolean default false
                          )
   return process_workflow%rowtype;

   function read_proc_flow(
                             p_proc_flow_code in process_workflow.activity_code%type
                             , p_proc_type_id in process_type.id%type
                             , p_lock         in boolean default false
                             , p_raise_ndf    in boolean default false
                          )
   return process_workflow%rowtype;

   function get_proc_flow_id(
                               p_proc_flow_code in process_workflow.activity_code%type
                               , p_proc_type_id in process_workflow.process_type_id%type
                               , p_raise_ndf    in boolean default false
                            )
   return bars.process_workflow.id%type;

   function get_proc_flow_proc_type(
                                      p_proc_flow_id in process_workflow.id%type
                                     , p_raise_ndf   in boolean default false
                                   )
   return bars.process_workflow.process_type_id%type;

   function get_proc_flow_code(
                                 p_proc_flow_id in process_workflow.id%type
                                 , p_raise_ndf  in boolean default false
                              )
   return bars.process_workflow.activity_code%type;

   function get_proc_flow_name(
                                 p_proc_flow_id in process_workflow.id%type
                                 , p_raise_ndf  in boolean default false
                              )
   return bars.process_workflow.activity_name%type;

   function get_proc_flow_manual_run(
                                       p_proc_flow_id in process_workflow.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_workflow.manual_run_flag%type;

   function get_proc_flow_manual_revert(
                                          p_proc_flow_id in process_workflow.id%type
                                          , p_raise_ndf  in boolean default false
                                       )
   return bars.process_workflow.manual_revert_flag%type;

   function get_proc_flow_need_create(
                                        p_proc_flow_id in process_workflow.id%type
                                       , p_raise_ndf   in boolean default false
                                     )
   return bars.process_workflow.need_create%type;

   function get_proc_flow_can_create(
                                       p_proc_flow_id in process_workflow.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_workflow.can_create%type;

   function get_proc_flow_can_run(
                                    p_proc_flow_id in process_workflow.id%type
                                   , p_raise_ndf   in boolean default false
                                 )
   return bars.process_workflow.can_run%type;

   function get_proc_flow_can_revert(
                                       p_proc_flow_id in process_workflow.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_workflow.can_revert%type;

   function get_proc_flow_can_remove(
                                       p_proc_flow_id in process_workflow.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_workflow.can_remove%type;

   function get_proc_flow_can_omit(
                                     p_proc_flow_id in process_workflow.id%type
                                     , p_raise_ndf  in boolean default false
                                  )
   return bars.process_workflow.can_omit%type;

   function get_proc_flow_on_create(
                                      p_proc_flow_id in process_workflow.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_workflow.on_create%type;

   function get_proc_flow_on_run(
                                   p_proc_flow_id in process_workflow.id%type
                                   , p_raise_ndf  in boolean default false
                                )
   return bars.process_workflow.on_run%type;

   function get_proc_flow_on_revert(
                                      p_proc_flow_id in process_workflow.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_workflow.on_revert%type;

   function get_proc_flow_on_remove(
                                      p_proc_flow_id in process_workflow.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_workflow.on_remove%type;

   function get_proc_flow_is_active(
                                      p_proc_flow_id in process_workflow.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_workflow.is_active%type;

   procedure set_proc_flow_proc_type(
                                       p_proc_flow_id in bars.process_workflow.id%type
                                       , p_value      in bars.process_workflow.process_type_id%type
                                       , p_raise_ndf  in boolean default false
                                    );

   procedure set_proc_flow_code(
                                  p_proc_flow_id in bars.process_workflow.id%type
                                  , p_value      in bars.process_workflow.activity_code%type
                                  , p_raise_ndf  in boolean default false
                               );

   procedure set_proc_flow_name(
                                  p_proc_flow_id in bars.process_workflow.id%type
                                  , p_value      in bars.process_workflow.activity_name%type
                                  , p_raise_ndf  in boolean default false
                               );

   procedure set_proc_flow_manual_run(
                                        p_proc_flow_id in bars.process_workflow.id%type
                                        , p_value      in bars.process_workflow.manual_run_flag%type
                                        , p_raise_ndf  in boolean default false
                                     );

   procedure set_proc_flow_manual_revert(
                                           p_proc_flow_id in bars.process_workflow.id%type
                                           , p_value      in bars.process_workflow.manual_revert_flag%type
                                           , p_raise_ndf  in boolean default false
                                        );

   procedure set_proc_flow_need_create(
                                         p_proc_flow_id in bars.process_workflow.id%type
                                         , p_value      in bars.process_workflow.need_create%type
                                         , p_raise_ndf  in boolean default false
                                      );

   procedure set_proc_flow_can_create(
                                        p_proc_flow_id in bars.process_workflow.id%type
                                        , p_value      in bars.process_workflow.can_create%type
                                        , p_raise_ndf  in boolean default false
                                     );

   procedure set_proc_flow_can_run(
                                     p_proc_flow_id in bars.process_workflow.id%type
                                     , p_value      in bars.process_workflow.can_run%type
                                     , p_raise_ndf  in boolean default false
                                  );

   procedure set_proc_flow_can_revert(
                                        p_proc_flow_id in bars.process_workflow.id%type
                                        , p_value      in bars.process_workflow.can_revert%type
                                        , p_raise_ndf  in boolean default false
                                     );

   procedure set_proc_flow_can_remove(
                                        p_proc_flow_id in bars.process_workflow.id%type
                                        , p_value      in bars.process_workflow.can_remove%type
                                        , p_raise_ndf  in boolean default false
                                     );

   procedure set_proc_flow_can_omit(
                                      p_proc_flow_id in bars.process_workflow.id%type
                                      , p_value      in bars.process_workflow.can_omit%type
                                      , p_raise_ndf  in boolean default false
                                   );

   procedure set_proc_flow_on_create(
                                       p_proc_flow_id in bars.process_workflow.id%type
                                       , p_value      in bars.process_workflow.on_create%type
                                       , p_raise_ndf  in boolean default false
                                    );

   procedure set_proc_flow_on_run(
                                    p_proc_flow_id in bars.process_workflow.id%type
                                    , p_value      in bars.process_workflow.on_run%type
                                    , p_raise_ndf  in boolean default false
                                 );

   procedure set_proc_flow_on_revert(
                                       p_proc_flow_id in bars.process_workflow.id%type
                                       , p_value      in bars.process_workflow.on_revert%type
                                       , p_raise_ndf  in boolean default false
                                    );

   procedure set_proc_flow_on_remove(
                                       p_proc_flow_id in bars.process_workflow.id%type
                                       , p_value      in bars.process_workflow.on_remove%type
                                       , p_raise_ndf  in boolean default false
                                    );

   procedure set_proc_flow_is_active(
                                       p_proc_flow_id in bars.process_workflow.id%type
                                       , p_value      in bars.process_workflow.is_active%type
                                       , p_raise_ndf  in boolean default false
                                    );

   function corr_proc_flow(
                             p_proc_type_id         in process_workflow.process_type_id%type
                             , p_activity_code      in process_workflow.activity_code%type
                             , p_activity_name      in process_workflow.activity_name%type
                             , p_manual_run_flag    in process_workflow.manual_run_flag%type
                             , p_manual_revert_flag in process_workflow.manual_revert_flag%type
                             , p_need_create        in process_workflow.need_create%type        default null
                             , p_can_create         in process_workflow.can_create%type         default null
                             , p_can_run            in process_workflow.can_run%type            default null
                             , p_can_revert         in process_workflow.can_revert%type         default null
                             , p_can_remove         in process_workflow.can_remove%type         default null
                             , p_can_omit           in process_workflow.can_omit%type           default null
                             , p_on_create          in process_workflow.on_create%type          default null
                             , p_on_run             in process_workflow.on_run%type             default null
                             , p_on_revert          in process_workflow.on_revert%type          default null
                             , p_on_remove          in process_workflow.on_remove%type          default null
                             , p_is_active          in process_workflow.is_active%type
                             , p_raise_ndf          in boolean                                  default false
                          )
   return process_workflow.id%type;

   function corr_proc_flow(
                             p_proc_type_code     in process_type.process_code%type
                             , p_proc_type_module   in process_type.module_code%type
                             , p_activity_code      in process_workflow.activity_code%type
                             , p_activity_name      in process_workflow.activity_name%type
                             , p_manual_run_flag    in process_workflow.manual_run_flag%type
                             , p_manual_revert_flag in process_workflow.manual_revert_flag%type
                             , p_need_create        in process_workflow.need_create%type        default null
                             , p_can_create         in process_workflow.can_create%type         default null
                             , p_can_run            in process_workflow.can_run%type            default null
                             , p_can_revert         in process_workflow.can_revert%type         default null
                             , p_can_remove         in process_workflow.can_remove%type         default null
                             , p_can_omit           in process_workflow.can_omit%type           default null
                             , p_on_create          in process_workflow.on_create%type          default null
                             , p_on_run             in process_workflow.on_run%type             default null
                             , p_on_revert          in process_workflow.on_revert%type          default null
                             , p_on_remove          in process_workflow.on_remove%type          default null
                             , p_is_active          in process_workflow.is_active%type
                             , p_raise_ndf          in boolean                                  default false
                          )
   return process_workflow.id%type;

   procedure add_proc_flow_dependence(
                                        p_primary_id  in process_workflow.id%type
                                        , p_follow_id in process_workflow.id%type
                                     );

   procedure add_proc_flow_dependence(
                                        p_proc_type_id             in process_type.id%type
                                        , p_proc_flow_code_primary in process_workflow.activity_code%type
                                        , p_proc_flow_code_follow  in process_workflow.activity_code%type
                                     );

   procedure add_proc_flow_dependence(
                                        p_proc_type_code           in process_type.process_code%type
                                        , p_proc_type_module       in process_type.module_code%type
                                        , p_proc_flow_code_primary in process_workflow.activity_code%type
                                        , p_proc_flow_code_follow  in process_workflow.activity_code%type
                                     );

   procedure delete_proc_flow_dependence(
                                           p_primary_id  in process_workflow.id%type
                                           , p_follow_id in process_workflow.id%type
                                        );

   procedure delete_proc_flow_dependence(
                                           p_proc_type_id             in process_type.id%type
                                           , p_proc_flow_code_primary in process_workflow.activity_code%type
                                           , p_proc_flow_code_follow  in process_workflow.activity_code%type
                                        );

   procedure delete_proc_flow_dependence(
                                           p_proc_type_code           in process_type.process_code%type
                                           , p_proc_type_module       in process_type.module_code%type
                                           , p_proc_flow_code_primary in process_workflow.activity_code%type
                                           , p_proc_flow_code_follow  in process_workflow.activity_code%type
                                        );

   function get_proc_flow_dependence_list(
                                            p_proc_type_id in process_type.id%type
                                         )
   return t_proc_flow_dep_lst;

   function get_proc_flow_dependence_pipe(
                                            p_proc_type_id in process_type.id%type
                                         )
   return t_proc_flow_dep_lst pipelined;

   function get_proc_flow_primary_list(
                                         p_proc_flow_id in process_type.id%type
                                      )
   return t_proc_flow_dep_lst;

   function get_proc_flow_primary_pipe(
                                         p_proc_flow_id in process_type.id%type
                                      )
   return t_proc_flow_dep_lst pipelined;

   function get_proc_flow_following_list(
                                           p_proc_flow_id in process_type.id%type
                                        )
   return t_proc_flow_dep_lst;

   function get_proc_flow_following_pipe(
                                           p_proc_flow_id in process_type.id%type
                                        )
   return t_proc_flow_dep_lst pipelined;

   function read_process(
                           p_process_id  in process.id%type
                           , p_lock      in boolean default false
                           , p_raise_ndf in boolean default false
                        )
   return process%rowtype;

   function get_process_name(
                               p_process_id  in process_type.id%type
                               , p_raise_ndf in boolean default false
                            )
   return bars.process.process_name%type;

   function get_process_proc_type_id(
                                       p_process_id  in process_type.id%type
                                       , p_raise_ndf in boolean default false
                                    )
   return bars.process.process_type_id%type;

   function get_process_data(
                               p_process_id  in process_type.id%type
                               , p_raise_ndf in boolean default false
                            )
   return bars.process.process_data%type;

   function get_process_object_id(
                                    p_process_id  in process_type.id%type
                                    , p_raise_ndf in boolean default false
                                 )
   return bars.process.object_id%type;

   function get_process_state_id(
                                   p_process_id  in process_type.id%type
                                   , p_raise_ndf in boolean default false
                                )
   return bars.process.state_id%type;

   procedure set_process_name(
                                p_process_id  in bars.process.id%type
                                , p_value     in bars.process.process_name%type
                                , p_raise_ndf in boolean default false
                             );

   procedure set_process_data(
                                p_process_id  in bars.process.id%type
                                , p_value     in bars.process.process_data%type
                                , p_raise_ndf in boolean default false
                             );

   procedure set_process_object_id(
                                     p_process_id  in bars.process.id%type
                                     , p_value     in bars.process.object_id%type
                                     , p_raise_ndf in boolean default false
                                  );

   procedure set_process_state_id(
                                    p_process_id  in bars.process.id%type
                                    , p_value     in bars.process.state_id%type
                                    , p_raise_ndf in boolean default false
                                 );

   function read_activity(
                            p_activity_id in activity.id%type
                            , p_lock      in boolean default false
                            , p_raise_ndf in boolean default true
                         )
   return activity%rowtype;

   procedure set_activity_name(
                                 p_activity_id  in bars.activity.id%type
                                 , p_value      in bars.activity.activity_name%type
                                 , p_raise_ndf  in boolean default false
                              );

   procedure set_activity_data(
                                 p_activity_id  in bars.activity.id%type
                                 , p_value      in bars.activity.activity_data%type
                                 , p_raise_ndf  in boolean default false
                              );

   procedure set_activity_object_id(
                                      p_activity_id  in bars.activity.id%type
                                      , p_value      in bars.activity.object_id%type
                                      , p_raise_ndf  in boolean default false
                                   );

   procedure activity_run(
                            p_activity_row in activity%rowtype
                            , p_activity_type_row process_workflow%rowtype
                            , p_silent_mode in boolean default false
                         );

   procedure activity_run(
                            p_activity_id in activity.id%type
                            , p_silent_mode in boolean default false
                         );

   procedure activity_revert(
                               p_activity_id in activity.id%type
                               , p_comment   in activity_history.comment_text%type default null
                            );

   procedure activity_remove(
                               p_activity_id in activity.id%type
                               , p_comment   in activity_history.comment_text%type default null
                            );

   function process_create(
                             p_proc_type_id        in process_type.id%type
                             , p_process_name      in process.process_name%type
                             , p_process_data      in process.process_data%type default null
                             , p_process_object_id in process.object_id%type    default null
                          )
   return process.id%type;

   function process_create(
                             p_proc_type_code      in process_type.process_code%type
                             , p_proc_type_module  in process_type.module_code%type
                             , p_process_name      in process.process_name%type
                             , p_process_data      in process.process_data%type default null
                             , p_process_object_id in process.object_id%type    default null
                          )
   return process.id%type;

   procedure process_run(
                           p_process_id        in process_type.id%type
                        );

   procedure process_revert(
                              p_process_id in process_type.id%type
                              , p_comment  in varchar2 default null
                           );

   procedure process_remove(
                              p_process_id in process_type.id%type
                           );

   procedure process_success(
                               p_process_id in process_type.id%type
                            );
end PROCESS_UTL;
/
create or replace package body PROCESS_UTL is

   gc_body_version    constant varchar2(64)  := 'version 1.0 04/25/2018';

   e_action_run          EXCEPTION;
   e_action_run_trace    EXCEPTION;
   e_action_run_rollback EXCEPTION;

   e_process_id          EXCEPTION;
   e_process_state       EXCEPTION;
   e_process_can         EXCEPTION;
   
   --Declare constant for Process Type
   GC_PROC_TYPE_TABLE        constant varchar2(30) := 'PROCESS_TYPE';

   GC_PROC_TYPE_ID           constant varchar2(30) := 'ID';
   GC_PROC_TYPE_MODULE_CODE  constant varchar2(30) := 'MODULE_CODE';
   GC_PROC_TYPE_PROCESS_CODE constant varchar2(30) := 'PROCESS_CODE';
   GC_PROC_TYPE_PROCESS_NAME constant varchar2(30) := 'PROCESS_NAME';
   GC_PROC_TYPE_CAN_CREATE   constant varchar2(30) := 'CAN_CREATE';
   GC_PROC_TYPE_CAN_RUN      constant varchar2(30) := 'CAN_RUN';
   GC_PROC_TYPE_CAN_REVERT   constant varchar2(30) := 'CAN_REVERT';
   GC_PROC_TYPE_CAN_REMOVE   constant varchar2(30) := 'CAN_REMOVE';
   GC_PROC_TYPE_ON_CREATE    constant varchar2(30) := 'ON_CREATE';
   GC_PROC_TYPE_ON_RUN       constant varchar2(30) := 'ON_RUN';
   GC_PROC_TYPE_ON_REVERT    constant varchar2(30) := 'ON_REVERT';
   GC_PROC_TYPE_ON_REMOVE    constant varchar2(30) := 'ON_REMOVE';
   GC_PROC_TYPE_IS_ACTIVE    constant varchar2(30) := 'IS_ACTIVE';

   --Declare constant for Process Workflow
   GC_PROC_FLOW_TABLE              constant varchar2(30) := 'PROCESS_WORKFLOW';

   GC_PROC_FLOW_ID                 constant varchar2(30) := 'ID';
   GC_PROC_FLOW_PROCESS_TYPE_ID    constant varchar2(30) := 'PROCESS_TYPE_ID';
   GC_PROC_FLOW_ACTIVITY_CODE      constant varchar2(30) := 'ACTIVITY_CODE';
   GC_PROC_FLOW_ACTIVITY_NAME      constant varchar2(30) := 'ACTIVITY_NAME';
   GC_PROC_FLOW_MANUAL_RUN_FL      constant varchar2(30) := 'MANUAL_RUN_FLAG';
   GC_PROC_FLOW_MANUAL_REVERT_FL   constant varchar2(30) := 'MANUAL_REVERT_FLAG';
   GC_PROC_FLOW_NEED_CREATE        constant varchar2(30) := 'NEED_CREATE';
   GC_PROC_FLOW_CAN_CREATE         constant varchar2(30) := 'CAN_CREATE';
   GC_PROC_FLOW_CAN_RUN            constant varchar2(30) := 'CAN_RUN';
   GC_PROC_FLOW_CAN_REVERT         constant varchar2(30) := 'CAN_REVERT';
   GC_PROC_FLOW_CAN_REMOVE         constant varchar2(30) := 'CAN_REMOVE';
   GC_PROC_FLOW_CAN_OMIT           constant varchar2(30) := 'CAN_OMIT';
   GC_PROC_FLOW_ON_CREATE          constant varchar2(30) := 'ON_CREATE';
   GC_PROC_FLOW_ON_RUN             constant varchar2(30) := 'ON_RUN';
   GC_PROC_FLOW_ON_REVERT          constant varchar2(30) := 'ON_REVERT';
   GC_PROC_FLOW_ON_REMOVE          constant varchar2(30) := 'ON_REMOVE';
   GC_PROC_FLOW_IS_ACTIVE          constant varchar2(30) := 'IS_ACTIVE';

   --Declare constant for Process
   GC_PROCESS_TABLE              constant varchar2(30) := 'PROCESS';

   GC_PROCESS_ID                 constant varchar2(30) := 'ID';
   -- GC_PROCESS_PROCESS_TYPE_ID    constant varchar2(30) := 'PROCESS_TYPE_ID';
   GC_PROCESS_PROCESS_NAME       constant varchar2(30) := 'PROCESS_NAME';
   GC_PROCESS_PROCESS_DATA       constant varchar2(30) := 'PROCESS_DATA';
   GC_PROCESS_OBJECT_ID          constant varchar2(30) := 'OBJECT_ID';
   GC_PROCESS_STATE_ID           constant varchar2(30) := 'STATE_ID';

   --Declare constant for Activity
   GC_ACTIVITY_TABLE              constant varchar2(30) := 'ACTIVITY';

   GC_ACTIVITY_ID                 constant varchar2(30) := 'ID';
   -- GC_ACTIVITY_PROCESS_ID         constant varchar2(30) := 'PROCESS_ID';
   GC_ACTIVITY_ACTIVITY_NAME      constant varchar2(30) := 'ACTIVITY_NAME';
   GC_ACTIVITY_ACTIVITY_DATA      constant varchar2(30) := 'ACTIVITY_DATA';
   GC_ACTIVITY_OBJECT_ID          constant varchar2(30) := 'OBJECT_ID';
   GC_ACTIVITY_STATE_ID           constant varchar2(30) := 'STATE_ID';

   -- header_version - возвращает версию заголовка пакета
   function header_version return varchar2 is
   begin
      return 'Package header process_utl ' || gc_header_version;
   end header_version;

   -- body_version - возвращает версию тела пакета
   function body_version return varchar2 is
   begin
      return 'Package body process_utl ' || gc_body_version;
   end body_version;

   -- get_process_type_new_id - Return new id for process type
   function get_process_type_new_id return number is
   begin
      return bars.s_process_type.nextval;
   end get_process_type_new_id;

   -- get_process_new_id - Return new id for process
   function get_process_new_id return number is
   begin
      return bars.s_process.nextval;
   end get_process_new_id;

   -- get_process_workflow_new_id - Return new id for process workflow
   function get_process_workflow_new_id return number is
   begin
      return bars.s_process_workflow.nextval;
   end get_process_workflow_new_id;

   -- get_activity_new_id - Return new id for activity
   function get_activity_new_id return number is
   begin
      return bars.s_activity.nextval;
   end get_activity_new_id;

   -- get_update_statement - Return statement for update field in table
   -- Parameters
   --             p_table        - name of table for update
   --             p_field_update - name of field for update
   --             p_field_id     - name of field in where clause
   function get_update_statement(
                                   p_table          in varchar2
                                   , p_field_update in varchar2
                                   , p_field_id     in varchar2
                                )
   return varchar2
   as
      l_statement varchar2(32767 byte);
   begin
      l_statement := ' update ' || p_table ||
                     ' set ' || p_field_update || ' = :value' ||
                     ' where ' || p_field_id || ' = :object_id';
   return l_statement;
   end get_update_statement;

   -- read_proc_type - Return parameters of process type as record
   -- Parameters
   --             p_proc_type_id - id of type of process
   --             p_lock         - sign blocking record
   --             p_raise_ndf    - sign raising exceptin when type of process is not found
   function read_proc_type(
                             p_proc_type_id in process_type.id%type
                             , p_lock       in boolean default false
                             , p_raise_ndf  in boolean default false
                          )
   return process_type%rowtype
   is
      l_proc_type_row process_type%rowtype;
   begin
      if (p_lock) then
         select *
         into   l_proc_type_row
         from   process_type p
         where  p.id = p_proc_type_id
         for update;
      else
         select *
         into   l_proc_type_row
         from   process_type p
         where  p.id = p_proc_type_id;
      end if;

      return l_proc_type_row;
   exception
      when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Тип процесу з ідентифікатором {' || p_proc_type_id ||'} не знайдений');
           else return null;
           end if;
   end read_proc_type;

   -- read_proc_type - Return parameters of process type as record
   -- Parameters
   --             p_proc_type_code - code of type of process
   --             p_module_code    - module code
   --             p_lock           - sign blocking record
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function read_proc_type(
                             p_proc_type_code in process_type.process_code%type
                             , p_module_code  in process_type.module_code%type
                             , p_lock         in boolean default false
                             , p_raise_ndf    in boolean default false
                          )
   return process_type%rowtype
   is
      l_proc_type_row process_type%rowtype;
   begin
      if (p_lock) then
         select *
         into   l_proc_type_row
         from   process_type p
         where  p.process_code = p_proc_type_code
                and p.module_code = p_module_code
         for update;
      else
         select *
         into   l_proc_type_row
         from   process_type p
         where  p.process_code = p_proc_type_code
             and p.module_code = p_module_code;
      end if;

      return l_proc_type_row;
   exception
      when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Тип процесу з кодом {' || p_proc_type_code || '} для модулю {'||p_module_code||'} не знайдений');
           else return null;
           end if;
   end read_proc_type;

   /*Begin Function section for obtaining process type parameters*/

   -- get_proc_type_id - Return id of type of process
   -- Parameters
   --             p_proc_type_code - code of type of process
   --             p_module_code    - module code
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_id(
                               p_proc_type_code in process_type.process_code%type
                               , p_module_code  in process_type.module_code%type
                               , p_raise_ndf    in boolean default false
                            )
   return bars.process_type.id%type
   as
   begin
      return read_proc_type(p_proc_type_code, p_module_code, p_raise_ndf => p_raise_ndf).id;
   end get_proc_type_id;

   -- get_proc_type_module - Return module code of type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_module(
                                   p_proc_type_id in process_type.id%type
                                   , p_raise_ndf  in boolean default false
                                )
   return bars.process_type.module_code%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).module_code;
   end get_proc_type_module;

   -- get_proc_type_code - Return code of type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_code(
                                 p_proc_type_id in process_type.id%type
                                 , p_raise_ndf  in boolean default false
                              )
   return bars.process_type.process_code%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).process_code;
   end  get_proc_type_code;

   -- get_proc_type_name - Return code of type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_name(
                                 p_proc_type_id in process_type.id%type
                                 , p_raise_ndf  in boolean default false
                              )
   return bars.process_type.process_name%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).process_name;
   end get_proc_type_name;

   -- get_proc_type_can_create - Return name of procedute check right for create new process for this type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_can_create(
                                       p_proc_type_id in process_type.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_type.can_create%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).can_create;
   end  get_proc_type_can_create;

   -- get_proc_type_can_run - Return name of procedute check right for run process for this type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_can_run(
                                    p_proc_type_id in process_type.id%type
                                    , p_raise_ndf  in boolean default false
                                 )
   return bars.process_type.can_run%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).can_run;
   end get_proc_type_can_run;

   -- get_proc_type_can_revert - Return name of procedute check right for revert process for this type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_can_revert(
                                       p_proc_type_id in process_type.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_type.can_revert%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).can_revert;
   end get_proc_type_can_revert;

   -- get_proc_type_can_remove - Return name of procedute check right for remove process for this type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_can_remove(
                                       p_proc_type_id in process_type.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_type.can_remove%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).can_remove;
   end get_proc_type_can_remove;

   -- get_proc_type_on_create - Return name of procedute for create new process for this type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_on_create(
                                      p_proc_type_id in process_type.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_type.on_create%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).on_create;
   end get_proc_type_on_create;

   -- get_proc_type_on_run - Return name of procedute for run process for this type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_on_run(
                                   p_proc_type_id in process_type.id%type
                                   , p_raise_ndf  in boolean default false
                                )
   return bars.process_type.on_run%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).on_run;
   end get_proc_type_on_run;

   -- get_proc_type_on_revert - Return name of procedute for revert process for this type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_on_revert(
                                      p_proc_type_id in process_type.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_type.on_revert%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).on_revert;
   end get_proc_type_on_revert;

   -- get_proc_type_on_remove - Return name of procedute for remove process for this type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_on_remove(
                                      p_proc_type_id in process_type.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_type.on_remove%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).on_remove;
   end get_proc_type_on_remove;

   -- get_proc_type_is_active - Return activity sign of type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function get_proc_type_is_active(
                                      p_proc_type_id in process_type.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_type.is_active%type
   as
   begin
      return read_proc_type(p_proc_type_id, p_raise_ndf => p_raise_ndf).is_active;
   end get_proc_type_is_active;
   /*End Function section for obtaining process type parameters*/

   -- set_proc_type_statement - Return statement for update field in Process Type
   -- Parameters
   --            p_field_update - name of field for update
   function set_proc_type_statement(
                                      p_field_update in varchar2
                                   )
   return varchar2
   as
   begin
      return get_update_statement(GC_PROC_TYPE_TABLE, p_field_update, GC_PROC_TYPE_ID);
   end set_proc_type_statement;

   -- raise_proc_type_set - raise exception when DML statement not change table PROCESS_TYPE
   --                       Using is procedures SET_ for table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id - id of process type
   procedure raise_proc_type_set(
                                   p_proc_type_id in bars.process_type.id%type
                                )
   as
   begin
      if (sql%rowcount = 0) then
         raise_application_error(-20000, 'Тип процесу з ідентифікатором {' || p_proc_type_id || '} не знайдений');
      end if;
   end raise_proc_type_set;

   /*Begin Procedure section for set process type parameters*/

   -- set_proc_type_module - Set new value in field MODULE_CODE in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_module(
                                    p_proc_type_id in bars.process_type.id%type
                                    , p_value      in bars.process_type.module_code%type
                                    , p_raise_ndf  in boolean default false
                                 )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_MODULE_CODE)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_module;

   -- set_proc_type_code - Set new value in field PROCESS_CODE in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_code(
                                  p_proc_type_id in bars.process_type.id%type
                                  , p_value      in bars.process_type.process_code%type
                                  , p_raise_ndf  in boolean default false
                               )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_PROCESS_CODE)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_code;

   -- set_proc_type_name - Set new value in field PROCESS_NAME in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_name(
                                  p_proc_type_id in bars.process_type.id%type
                                  , p_value      in bars.process_type.process_name%type
                                  , p_raise_ndf  in boolean default false
                               )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_PROCESS_NAME)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_name;

   -- set_proc_type_can_create - Set new value in field CAN_CREATE in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_can_create(
                                        p_proc_type_id in bars.process_type.id%type
                                        , p_value      in bars.process_type.can_create%type
                                        , p_raise_ndf  in boolean default false
                                     )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_CAN_CREATE)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_can_create;

   -- set_proc_type_can_run - Set new value in field CAN_run in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_can_run(
                                     p_proc_type_id in bars.process_type.id%type
                                     , p_value      in bars.process_type.can_run%type
                                     , p_raise_ndf  in boolean default false
                                  )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_CAN_RUN)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_can_run;

   -- set_proc_type_can_revert - Set new value in field CAN_REVERT in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_can_revert(
                                        p_proc_type_id in bars.process_type.id%type
                                        , p_value      in bars.process_type.can_revert%type
                                        , p_raise_ndf  in boolean default false
                                     )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_CAN_REVERT)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_can_revert;

   -- set_proc_type_can_remove - Set new value in field CAN_REMOVE in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_can_remove(
                                        p_proc_type_id in bars.process_type.id%type
                                        , p_value      in bars.process_type.can_remove%type
                                        , p_raise_ndf  in boolean default false
                                     )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_CAN_REMOVE)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_can_remove;

   -- set_proc_type_on_create - Set new value in field ON_CREATE in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_on_create(
                                       p_proc_type_id in bars.process_type.id%type
                                       , p_value      in bars.process_type.on_create%type
                                       , p_raise_ndf  in boolean default false
                                    )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_ON_CREATE)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_on_create;

   -- set_proc_type_on_run - Set new value in field ON_RUN in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_on_run(
                                    p_proc_type_id in bars.process_type.id%type
                                    , p_value      in bars.process_type.on_run%type
                                    , p_raise_ndf  in boolean default false
                                 )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_ON_RUN)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_on_run;

   -- set_proc_type_on_revert - Set new value in field ON_REVERT in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_on_revert(
                                       p_proc_type_id in bars.process_type.id%type
                                       , p_value      in bars.process_type.on_revert%type
                                       , p_raise_ndf  in boolean default false
                                    )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_ON_REVERT)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_on_revert;

   -- set_proc_type_on_remove - Set new value in field ON_REMOVE in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_on_remove(
                                       p_proc_type_id in bars.process_type.id%type
                                       , p_value      in bars.process_type.on_remove%type
                                       , p_raise_ndf  in boolean default false
                                    )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_ON_REMOVE)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_on_remove;

   -- set_proc_type_is_active - Set new value in field IS_ACTIVE in table PROCESS_TYPE
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_TYPE
   procedure set_proc_type_is_active(
                                       p_proc_type_id in bars.process_type.id%type
                                       , p_value      in bars.process_type.is_active%type
                                       , p_raise_ndf  in boolean default false
                                    )
   as
   begin
      execute immediate set_proc_type_statement(GC_PROC_TYPE_IS_ACTIVE)
      using p_value, p_proc_type_id;

      if p_raise_ndf then
         raise_proc_type_set(p_proc_type_id);
      end if;

   end set_proc_type_is_active;
   /*End Procedure section for set process type parameters*/

   -- corr_proc_type - Add or Update (if present) process type.
   --                  Search field - MODULE_CODE and PROCESS_CODE
   --                  Return id of process type
   -- Parameters
   --            p_module_code  - code of module for process type
   --            p_process_code - code of process type
   --            p_process_name - name of process type
   --            p_can_create   - name of the procedure that check the rights to create the process
   --            p_can_run      - name of the procedure that check the rights to run the process
   --            p_can_revert   - name of the procedure that check the rights to revert the process
   --            p_can_remove   - name of the procedure that check the rights to remove the process
   --            p_on_create    - name of the procedure that creates the process
   --            p_on_run       - name of the procedure that runs the process
   --            p_on_revert    - name of the procedure that reverts the process
   --            p_on_remove    - name of the procedure that remove the process
   --            p_is_active    - sign activity of process type
   --            p_raise_ndf    - sign of exception generation when an error occurred
   function corr_proc_type(
                             p_module_code    in process_type.module_code%type
                             , p_process_code in process_type.process_code%type
                             , p_process_name in process_type.process_name%type
                             , p_can_create   in process_type.can_create%type   default null
                             , p_can_run      in process_type.can_run%type      default null
                             , p_can_revert   in process_type.can_revert%type   default null
                             , p_can_remove   in process_type.can_remove%type   default null
                             , p_on_create    in process_type.on_create%type    default null
                             , p_on_run       in process_type.on_run%type       default null
                             , p_on_revert    in process_type.on_revert%type    default null
                             , p_on_remove    in process_type.on_remove%type    default null
                             , p_is_active    in process_type.is_active%type
                             , p_raise_ndf    in boolean                        default false
                          )
   return process_type.id%type
   as
      l_proc_type    process_type%rowtype;
      l_proc_type_id process_type.id%type;
   begin
      if (p_module_code is null) then
         raise_application_error(-20001, 'Код модуля для типу процесу не вказано');
      end if;

      if (p_process_code is null) then
         raise_application_error(-20002, 'Код типу процесу не вказано');
      end if;

      if (p_process_name is null) then
         raise_application_error(-20003, 'Найменування типу процесу не вказано');
      end if;

      if (p_is_active is null) then
         raise_application_error(-20004, 'Ознаку активності процесу не вказано');
      end if;

      l_proc_type := read_proc_type(p_process_code, p_module_code);
      if l_proc_type.id is null then
         l_proc_type_id := get_process_type_new_id();
         insert into process_type (id, module_code, process_code, process_name, is_active)
         values (l_proc_type_id, p_module_code, p_process_code, p_process_name, p_is_active);
      else
         l_proc_type_id := l_proc_type.id;
         if not tools.equals(l_proc_type.module_code, p_module_code) then
            set_proc_type_module(l_proc_type_id, p_module_code , p_raise_ndf);
         end if;
         if not tools.equals(l_proc_type.process_code, p_process_code) then
            set_proc_type_code(l_proc_type_id, p_process_code, p_raise_ndf);
         end if;
         if not tools.equals(l_proc_type.process_name, p_process_name) then
            set_proc_type_name(l_proc_type_id, p_process_name, p_raise_ndf);
         end if;
         if not tools.equals(l_proc_type.is_active, p_is_active) then
            set_proc_type_is_active(l_proc_type_id, p_is_active, p_raise_ndf);
         end if;
      end if;

      if not tools.equals(l_proc_type.can_create, p_can_create) then
         set_proc_type_can_create(l_proc_type_id, p_can_create, p_raise_ndf);
      end if;
      if not tools.equals(l_proc_type.can_run, p_can_run) then
         set_proc_type_can_run(l_proc_type_id, p_can_run, p_raise_ndf);
      end if;
      if not tools.equals(l_proc_type.can_revert, p_can_revert) then
         set_proc_type_can_revert(l_proc_type_id, p_can_revert, p_raise_ndf);
      end if;
      if not tools.equals(l_proc_type.can_remove, p_can_remove) then
         set_proc_type_can_remove(l_proc_type_id, p_can_remove, p_raise_ndf);
      end if;
      if not tools.equals(l_proc_type.on_create, p_on_create) then
         set_proc_type_on_create(l_proc_type_id, p_on_create, p_raise_ndf);
      end if;
      if not tools.equals(l_proc_type.on_run, p_on_run) then
         set_proc_type_on_run(l_proc_type_id, p_on_run, p_raise_ndf);
      end if;
      if not tools.equals(l_proc_type.on_revert, p_on_revert) then
         set_proc_type_on_revert(l_proc_type_id, p_on_revert, p_raise_ndf);
      end if;
      if not tools.equals(l_proc_type.on_remove, p_on_remove) then
         set_proc_type_on_remove(l_proc_type_id, p_on_remove, p_raise_ndf);
      end if;

      return l_proc_type_id;
   end corr_proc_type;

   -- read_proc_flow - Return parameters of process workflow as record
   -- Parameters
   --             p_proc_flow_id - id of process workflow
   --             p_lock         - sign blocking record
   --             p_raise_ndf    - sign raising exceptin when type of process is not found
   function read_proc_flow(
                             p_proc_flow_id  in process_type.id%type
                             , p_lock        in boolean default false
                             , p_raise_ndf   in boolean default false
                          )
   return process_workflow%rowtype
   is
      l_proc_flow_row process_workflow%rowtype;
   begin
      if (p_lock) then
         select *
         into   l_proc_flow_row
         from   process_workflow p
         where  p.id = p_proc_flow_id
         for update;
      else
         select *
         into   l_proc_flow_row
         from   process_workflow p
         where  p.id = p_proc_flow_id;
      end if;

      return l_proc_flow_row;
   exception
      when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Крок процесу з ідентифікатором {' || p_proc_flow_id ||'} не знайдений');
           else return null;
           end if;
   end read_proc_flow;

   -- read_proc_flow - Return parameters of process workflow as record
   -- Parameters
   --             p_proc_flow_code - code process workflow
   --             p_proc_type_id   - id of process type
   --             p_lock           - sign blocking record
   --             p_raise_ndf      - sign raising exceptin when type of process is not found
   function read_proc_flow(
                             p_proc_flow_code in process_workflow.activity_code%type
                             , p_proc_type_id in process_type.id%type
                             , p_lock         in boolean default false
                             , p_raise_ndf    in boolean default false
                          )
   return process_workflow%rowtype
   is
      l_proc_flow_row process_workflow%rowtype;
   begin
      if (p_lock) then
         select *
         into   l_proc_flow_row
         from   process_workflow p
         where  p.activity_code = p_proc_flow_code
                and p.process_type_id = p_proc_type_id
         for update;
      else
         select *
         into   l_proc_flow_row
         from   process_workflow p
         where  p.activity_code = p_proc_flow_code
             and p.process_type_id = p_proc_type_id;
      end if;

      return l_proc_flow_row;
   exception
      when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Крок процесу з кодом {' || p_proc_flow_code || '} для типу процесу з ідентифікатором {'||p_proc_type_id||'} не знайдений');
           else return null;
           end if;
   end read_proc_flow;

   /*Begin Function section for obtaining process workflow parameters*/

   -- get_proc_flow_id - Return id of process workflow
   -- Parameters
   --             p_proc_type_code - code of process workflow
   --             p_proc_type_id   - id of process type
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_id(
                               p_proc_flow_code in process_workflow.activity_code%type
                               , p_proc_type_id in process_workflow.process_type_id%type
                               , p_raise_ndf    in boolean default false
                            )
   return bars.process_workflow.id%type
   as
   begin
      return read_proc_flow(p_proc_flow_code, p_proc_type_id, p_raise_ndf => p_raise_ndf).id;
   end get_proc_flow_id;

   -- get_proc_flow_proc_type - Return process type of process workflow
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_proc_type(
                                      p_proc_flow_id in process_workflow.id%type
                                     , p_raise_ndf   in boolean default false
                                   )
   return bars.process_workflow.process_type_id%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).process_type_id;
   end get_proc_flow_proc_type;

   -- get_proc_flow_code - Return activity code of process workflow
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_code(
                                 p_proc_flow_id in process_workflow.id%type
                                 , p_raise_ndf  in boolean default false
                              )
   return bars.process_workflow.activity_code%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).activity_code;
   end get_proc_flow_code;

   -- get_proc_flow_name - Return activity name of process workflow
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_name(
                                 p_proc_flow_id in process_workflow.id%type
                                 , p_raise_ndf  in boolean default false
                              )
   return bars.process_workflow.activity_name%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).activity_name;
   end get_proc_flow_name;

   -- get_proc_flow_manual_run - Return sign of manual run of process workflow
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_manual_run(
                                       p_proc_flow_id in process_workflow.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_workflow.manual_run_flag%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).manual_run_flag;
   end get_proc_flow_manual_run;

   -- get_proc_flow_manual_revert - Return sign of manual reveret of process workflow
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_manual_revert(
                                          p_proc_flow_id in process_workflow.id%type
                                          , p_raise_ndf  in boolean default false
                                       )
   return bars.process_workflow.manual_revert_flag%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).manual_revert_flag;
   end get_proc_flow_manual_revert;

   -- get_proc_flow_need_create - Return name of procedute check of need create activity
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_need_create(
                                        p_proc_flow_id in process_workflow.id%type
                                       , p_raise_ndf   in boolean default false
                                     )
   return bars.process_workflow.need_create%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).need_create;
   end get_proc_flow_need_create;

   -- get_proc_flow_can_create - Return name of procedute check right create activity
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_can_create(
                                       p_proc_flow_id in process_workflow.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_workflow.can_create%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).can_create;
   end get_proc_flow_can_create;

   -- get_proc_flow_can_run - Return name of procedute check right run activity
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_can_run(
                                    p_proc_flow_id in process_workflow.id%type
                                   , p_raise_ndf   in boolean default false
                                 )
   return bars.process_workflow.can_run%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).can_run;
   end get_proc_flow_can_run;

   -- get_proc_flow_can_revert - Return name of procedute check right revert activity
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_can_revert(
                                       p_proc_flow_id in process_workflow.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_workflow.can_revert%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).can_revert;
   end get_proc_flow_can_revert;

   -- get_proc_flow_can_remove - Return name of procedute check right remove activity
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_can_remove(
                                       p_proc_flow_id in process_workflow.id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   return bars.process_workflow.can_remove%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).can_remove;
   end get_proc_flow_can_remove;

   -- get_proc_flow_can_omit - Return name of procedute check can omit activity
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_can_omit(
                                     p_proc_flow_id in process_workflow.id%type
                                     , p_raise_ndf  in boolean default false
                                  )
   return bars.process_workflow.can_omit%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).can_omit;
   end get_proc_flow_can_omit;

   -- get_proc_flow_on_create - Return name of procedute for create activity
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_on_create(
                                      p_proc_flow_id in process_workflow.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_workflow.on_create%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).on_create;
   end get_proc_flow_on_create;

   -- get_proc_flow_on_run - Return name of procedute for run activity
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_on_run(
                                   p_proc_flow_id in process_workflow.id%type
                                   , p_raise_ndf  in boolean default false
                                )
   return bars.process_workflow.on_run%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).on_run;
   end get_proc_flow_on_run;

   -- get_proc_flow_on_revert - Return name of procedute for revert activity
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_on_revert(
                                      p_proc_flow_id in process_workflow.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_workflow.on_revert%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).on_revert;
   end get_proc_flow_on_revert;

   -- get_proc_flow_on_remove - Return name of procedute for remove activity
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_on_remove(
                                      p_proc_flow_id in process_workflow.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_workflow.on_remove%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).on_remove;
   end get_proc_flow_on_remove;

   -- get_proc_flow_on_ - Return sing of activity of process workflow
   -- Parameters
   --             p_proc_flow_id   - id of process workflow
   --             p_raise_ndf      - sign raising exceptin when process workflow is not found
   function get_proc_flow_is_active(
                                      p_proc_flow_id in process_workflow.id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   return bars.process_workflow.is_active%type
   as
   begin
      return read_proc_flow(p_proc_flow_id, p_raise_ndf => p_raise_ndf).is_active;
   end get_proc_flow_is_active;
   /*End Function section for obtaining process workflow parameters*/

   -- set_proc_flow_statement - Return statement for update field in Process Workflow
   -- Parameters
   --            p_field_update - name of field for update
   function set_proc_flow_statement(
                                      p_field_update in varchar2
                                   )
   return varchar2
   as
   begin
      return get_update_statement(GC_PROC_FLOW_TABLE, p_field_update, GC_PROC_FLOW_ID);
   end set_proc_flow_statement;

   -- raise_proc_flow_set - raise exception when DML statement not change table PROCESS_WORKFLOW
   --                       Using is procedures SET_ for table PROCESS_WORKFLOW
   -- Parameters
   --            p_proc_flow_id - id of process workflow
   procedure raise_proc_flow_set(
                                   p_proc_flow_id in bars.process_workflow.id%type
                                )
   as
   begin
      if (sql%rowcount = 0) then
         raise_application_error(-20000, 'Крок процесу з ідентифікатором {' || p_proc_flow_id || '} не знайдений');
      end if;
   end raise_proc_flow_set;

   /*Begin Procedure section for set process workflow parameters*/

   -- set_proc_flow_proc_type - Set new value in field PROCES_TYPE_ID in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_proc_type(
                                       p_proc_flow_id in bars.process_workflow.id%type
                                       , p_value      in bars.process_workflow.process_type_id%type
                                       , p_raise_ndf  in boolean default false
                                    )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_PROCESS_TYPE_ID)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_proc_type;

   -- set_proc_flow_code - Set new value in field ACTIVITY_CODE in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_code(
                                  p_proc_flow_id in bars.process_workflow.id%type
                                  , p_value      in bars.process_workflow.activity_code%type
                                  , p_raise_ndf  in boolean default false
                               )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_ACTIVITY_CODE)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_code;

   -- set_proc_flow_name - Set new value in field ACTIVITY_NAME in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_name(
                                  p_proc_flow_id in bars.process_workflow.id%type
                                  , p_value      in bars.process_workflow.activity_name%type
                                  , p_raise_ndf  in boolean default false
                               )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_ACTIVITY_NAME)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_name;

   -- set_proc_flow_manual_run - Set new value in field MANUAL_RUN_FLAG in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_manual_run(
                                        p_proc_flow_id in bars.process_workflow.id%type
                                        , p_value      in bars.process_workflow.manual_run_flag%type
                                        , p_raise_ndf  in boolean default false
                                     )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_MANUAL_RUN_FL)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_manual_run;

   -- set_proc_flow_manual_revert - Set new value in field MANUAL_REVERT_FLAG in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_manual_revert(
                                           p_proc_flow_id in bars.process_workflow.id%type
                                           , p_value      in bars.process_workflow.manual_revert_flag%type
                                           , p_raise_ndf  in boolean default false
                                        )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_MANUAL_REVERT_FL)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_manual_revert;

   -- set_proc_flow_need_craete - Set new value in field NEED_CREATE in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_need_create(
                                         p_proc_flow_id in bars.process_workflow.id%type
                                         , p_value      in bars.process_workflow.need_create%type
                                         , p_raise_ndf  in boolean default false
                                      )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_NEED_CREATE)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_need_create;

   -- set_proc_flow_can_create - Set new value in field CAN_CREATE in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_can_create(
                                        p_proc_flow_id in bars.process_workflow.id%type
                                        , p_value      in bars.process_workflow.can_create%type
                                        , p_raise_ndf  in boolean default false
                                     )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_CAN_CREATE)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_can_create;

   -- set_proc_flow_can_run - Set new value in field CAN_RUN in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_can_run(
                                     p_proc_flow_id in bars.process_workflow.id%type
                                     , p_value      in bars.process_workflow.can_run%type
                                     , p_raise_ndf  in boolean default false
                                  )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_CAN_RUN)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_can_run;

   -- set_proc_flow_can_revert - Set new value in field CAN_REVERT in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_can_revert(
                                        p_proc_flow_id in bars.process_workflow.id%type
                                        , p_value      in bars.process_workflow.can_revert%type
                                        , p_raise_ndf  in boolean default false
                                     )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_CAN_REVERT)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_can_revert;

   -- set_proc_flow_can_remove - Set new value in field CAN_REMOVE in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_can_remove(
                                        p_proc_flow_id in bars.process_workflow.id%type
                                        , p_value      in bars.process_workflow.can_remove%type
                                        , p_raise_ndf  in boolean default false
                                     )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_CAN_REMOVE)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_can_remove;

   -- set_proc_flow_can_omit - Set new value in field CAN_OMIT in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_can_omit(
                                      p_proc_flow_id in bars.process_workflow.id%type
                                      , p_value      in bars.process_workflow.can_omit%type
                                      , p_raise_ndf  in boolean default false
                                   )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_CAN_OMIT)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_can_omit;

   -- set_proc_flow_on_create - Set new value in field ON_CREATE in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_on_create(
                                       p_proc_flow_id in bars.process_workflow.id%type
                                       , p_value      in bars.process_workflow.on_create%type
                                       , p_raise_ndf  in boolean default false
                                    )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_ON_CREATE)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_on_create;

   -- set_proc_flow_on_run - Set new value in field ON_RUN in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_on_run(
                                    p_proc_flow_id in bars.process_workflow.id%type
                                    , p_value      in bars.process_workflow.on_run%type
                                    , p_raise_ndf  in boolean default false
                                 )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_ON_RUN)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_on_run;

   -- set_proc_flow_on_revert - Set new value in field ON_REVERT in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_on_revert(
                                       p_proc_flow_id in bars.process_workflow.id%type
                                       , p_value      in bars.process_workflow.on_revert%type
                                       , p_raise_ndf  in boolean default false
                                    )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_ON_REVERT)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_on_revert;

   -- set_proc_flow_on_remove - Set new value in field ON_REMOVE in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_on_remove(
                                       p_proc_flow_id in bars.process_workflow.id%type
                                       , p_value      in bars.process_workflow.on_remove%type
                                       , p_raise_ndf  in boolean default false
                                    )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_ON_REMOVE)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_on_remove;

   -- set_proc_flow_is_active - Set new value in field IS_ACTIVE in table PROCESS_WORKFLOW
   -- Parameters
   --             p_proc_type_id   - id of process workflow
   --             p_value          - new value
   --             p_raise_ndf      - sign raising exceptin when DML statement not change table PROCESS_WORKFLOW
   procedure set_proc_flow_is_active(
                                       p_proc_flow_id in bars.process_workflow.id%type
                                       , p_value      in bars.process_workflow.is_active%type
                                       , p_raise_ndf  in boolean default false
                                    )
   as
   begin
      execute immediate set_proc_flow_statement(GC_PROC_FLOW_IS_ACTIVE)
      using p_value, p_proc_flow_id;

      if p_raise_ndf then
         raise_proc_flow_set(p_proc_flow_id);
      end if;

   end set_proc_flow_is_active;
   /*End Procedure section for set process workflow parameters*/

   -- corr_proc_flow - Add or Update (if present) process workflow.
   --                  Search field - PROCESS_TYPE_ID and ACTIVITY_CODE
   --                  Return id of process workflow
   -- Parameters
   --            p_proc_type_id       - id of process workflow
   --            p_activity_code      - code of process workflow
   --            p_activity_name      - name of process workflow
   --            p_manual_run_flag    - sign of manual run process workflow
   --            p_manual_revert_flag - sign of manual revert process workflow
   --            p_need_create        - name of the procedure that check need create the activity
   --            p_can_create         - name of the procedure that check the rights to create the activity
   --            p_can_run            - name of the procedure that check the rights to run the activity
   --            p_can_revert         - name of the procedure that check the rights to revert the activity
   --            p_can_remove         - name of the procedure that check the rights to remove the activity
   --            p_can_omit           - name of the procedure that check can omit the activity
   --            p_on_create          - name of the procedure that creates the activity
   --            p_on_run             - name of the procedure that runs the activity
   --            p_on_revert          - name of the procedure that reverts the activity
   --            p_on_remove          - name of the procedure that remove the activity
   --            p_is_active          - sign activity of process workflow
   --            p_raise_ndf          - sign of exception generation when an error occurred
   function corr_proc_flow(
                             p_proc_type_id         in process_workflow.process_type_id%type
                             , p_activity_code      in process_workflow.activity_code%type
                             , p_activity_name      in process_workflow.activity_name%type
                             , p_manual_run_flag    in process_workflow.manual_run_flag%type
                             , p_manual_revert_flag in process_workflow.manual_revert_flag%type
                             , p_need_create        in process_workflow.need_create%type        default null
                             , p_can_create         in process_workflow.can_create%type         default null
                             , p_can_run            in process_workflow.can_run%type            default null
                             , p_can_revert         in process_workflow.can_revert%type         default null
                             , p_can_remove         in process_workflow.can_remove%type         default null
                             , p_can_omit           in process_workflow.can_omit%type           default null
                             , p_on_create          in process_workflow.on_create%type          default null
                             , p_on_run             in process_workflow.on_run%type             default null
                             , p_on_revert          in process_workflow.on_revert%type          default null
                             , p_on_remove          in process_workflow.on_remove%type          default null
                             , p_is_active          in process_workflow.is_active%type
                             , p_raise_ndf          in boolean                                  default false
                          )
   return process_workflow.id%type
   as
      l_proc_flow    process_workflow%rowtype;
      l_proc_flow_id process_workflow.id%type;
   begin
      if (p_proc_type_id is null) then
         raise_application_error(-20001, 'Тип процесу для кроку процесу не вказано');
      end if;

      if (p_activity_code is null) then
         raise_application_error(-20002, 'Код кроку процесу не вказано');
      end if;

      if (p_activity_name is null) then
         raise_application_error(-20003, 'Найменування кроку процесу не вказано');
      end if;

      if (p_manual_run_flag is null) then
         raise_application_error(-20004, 'Ознака того, що ініціювати виконання даного кроку повинна людина або інша процедура - автоматично виконувати даний крок механізм процесів не повинен, не вказана');
      end if;

      if (p_manual_revert_flag is null) then
         raise_application_error(-20005, 'Ознака того, що даний крок заборонено відміняти автоматично при частковій або повній відміні процесу- його відміну повинна ініціювати людина або інша процедура, не вказана');
      end if;

      if (p_is_active is null) then
         raise_application_error(-20006, 'Ознаку активності кроку в межах робочого процесу не вказано');
      end if;

      l_proc_flow := read_proc_flow(p_activity_code, p_proc_type_id);
      if l_proc_flow.id is null then
         l_proc_flow_id := get_process_workflow_new_id();
         insert into process_workflow (id, process_type_id, activity_code, activity_name, manual_run_flag, manual_revert_flag, is_active)
         values (l_proc_flow_id, p_proc_type_id, p_activity_code, p_activity_name, p_manual_run_flag, p_manual_revert_flag, p_is_active);
      else
         l_proc_flow_id := l_proc_flow.id;
         if not tools.equals(l_proc_flow.process_type_id, p_proc_type_id) then
            set_proc_flow_proc_type(l_proc_flow_id, p_proc_type_id, p_raise_ndf => p_raise_ndf);
         end if;
         if not tools.equals(l_proc_flow.activity_code, p_activity_code) then
            set_proc_flow_code(l_proc_flow_id, p_activity_code, p_raise_ndf => p_raise_ndf);
         end if;
         if not tools.equals(l_proc_flow.activity_name, p_activity_name) then
            set_proc_flow_name(l_proc_flow_id, p_activity_name, p_raise_ndf => p_raise_ndf);
         end if;
         if not tools.equals(l_proc_flow.manual_run_flag, p_manual_run_flag) then
            set_proc_flow_manual_run(l_proc_flow_id, p_manual_run_flag, p_raise_ndf => p_raise_ndf);
         end if;
         if not tools.equals(l_proc_flow.manual_revert_flag, p_manual_revert_flag) then
            set_proc_flow_manual_revert(l_proc_flow_id, p_manual_revert_flag, p_raise_ndf => p_raise_ndf);
         end if;
         if not tools.equals(l_proc_flow.is_active, p_is_active) then
            set_proc_flow_is_active(l_proc_flow_id, p_is_active, p_raise_ndf => p_raise_ndf);
         end if;
      end if;

      if not tools.equals(l_proc_flow.need_create, p_need_create) then
         set_proc_flow_need_create(l_proc_flow_id, p_need_create, p_raise_ndf => p_raise_ndf);
      end if;
      if not tools.equals(l_proc_flow.can_create, p_can_create) then
         set_proc_flow_can_create(l_proc_flow_id, p_can_create, p_raise_ndf => p_raise_ndf);
      end if;
      if not tools.equals(l_proc_flow.can_run, p_can_run) then
         set_proc_flow_can_run(l_proc_flow_id, p_can_run, p_raise_ndf => p_raise_ndf);
      end if;
      if not tools.equals(l_proc_flow.can_revert, p_can_revert) then
         set_proc_flow_can_revert(l_proc_flow_id, p_can_revert, p_raise_ndf => p_raise_ndf);
      end if;
      if not tools.equals(l_proc_flow.can_remove, p_can_remove) then
         set_proc_flow_can_remove(l_proc_flow_id, p_can_remove, p_raise_ndf => p_raise_ndf);
      end if;
      if not tools.equals(l_proc_flow.can_omit, p_can_omit) then
         set_proc_flow_can_omit(l_proc_flow_id, p_can_omit, p_raise_ndf => p_raise_ndf);
      end if;
      if not tools.equals(l_proc_flow.on_create, p_on_create) then
         set_proc_flow_on_create(l_proc_flow_id, p_on_create, p_raise_ndf => p_raise_ndf);
      end if;
      if not tools.equals(l_proc_flow.on_run, p_on_run) then
         set_proc_flow_on_run(l_proc_flow_id, p_on_run, p_raise_ndf => p_raise_ndf);
      end if;
      if not tools.equals(l_proc_flow.on_revert, p_on_revert) then
         set_proc_flow_on_revert(l_proc_flow_id, p_on_revert, p_raise_ndf => p_raise_ndf);
      end if;
      if not tools.equals(l_proc_flow.on_remove, p_on_remove) then
         set_proc_flow_on_remove(l_proc_flow_id, p_on_remove, p_raise_ndf => p_raise_ndf);
      end if;

      return l_proc_flow_id;
   end corr_proc_flow;

   -- corr_proc_flow - Add or Update (if present) process workflow.
   --                  Search field - PROCESS_TYPE_ID and ACTIVITY_CODE
   --                  Return id of process workflow
   -- Parameters
   --            p_proc_type_code     - code of process type
   --            p_proc_type_module   - module code of process type
   --            p_activity_code      - code of process workflow
   --            p_activity_name      - name of process workflow
   --            p_manual_run_flag    - sign of manual run process workflow
   --            p_manual_revert_flag - sign of manual revert process workflow
   --            p_need_create        - name of the procedure that check need create the activity
   --            p_can_create         - name of the procedure that check the rights to create the activity
   --            p_can_run            - name of the procedure that check the rights to run the activity
   --            p_can_revert         - name of the procedure that check the rights to revert the activity
   --            p_can_remove         - name of the procedure that check the rights to remove the activity
   --            p_can_omit           - name of the procedure that check can omit the activity
   --            p_on_create          - name of the procedure that creates the activity
   --            p_on_run             - name of the procedure that runs the activity
   --            p_on_revert          - name of the procedure that reverts the activity
   --            p_on_remove          - name of the procedure that remove the activity
   --            p_is_active          - sign activity of process workflow
   --            p_raise_ndf          - sign of exception generation when an error occurred
   function corr_proc_flow(
                             p_proc_type_code     in process_type.process_code%type
                             , p_proc_type_module   in process_type.module_code%type
                             , p_activity_code      in process_workflow.activity_code%type
                             , p_activity_name      in process_workflow.activity_name%type
                             , p_manual_run_flag    in process_workflow.manual_run_flag%type
                             , p_manual_revert_flag in process_workflow.manual_revert_flag%type
                             , p_need_create        in process_workflow.need_create%type        default null
                             , p_can_create         in process_workflow.can_create%type         default null
                             , p_can_run            in process_workflow.can_run%type            default null
                             , p_can_revert         in process_workflow.can_revert%type         default null
                             , p_can_remove         in process_workflow.can_remove%type         default null
                             , p_can_omit           in process_workflow.can_omit%type           default null
                             , p_on_create          in process_workflow.on_create%type          default null
                             , p_on_run             in process_workflow.on_run%type             default null
                             , p_on_revert          in process_workflow.on_revert%type          default null
                             , p_on_remove          in process_workflow.on_remove%type          default null
                             , p_is_active          in process_workflow.is_active%type
                             , p_raise_ndf          in boolean                                  default false
                          )
   return process_workflow.id%type
   as
      l_proc_type_id process_type.id%type;
      l_proc_flow_id process_workflow.id%type;
   begin
      if (p_proc_type_code is null) then
         raise_application_error(-20001, 'Код типу процесу для кроку процесу не вказано');
      end if;

      if (p_proc_type_module is null) then
         raise_application_error(-20002, 'Код модуля типу процесу для кроку процесу не вказано');
      end if;

      l_proc_type_id := get_proc_type_id(
                                           p_proc_type_code => p_proc_type_code
                                           , p_module_code  => p_proc_type_module
                                           , p_raise_ndf    => p_raise_ndf
                                        );
      l_proc_flow_id := corr_proc_flow(
                                         l_proc_type_id
                                         , p_activity_code
                                         , p_activity_name
                                         , p_manual_run_flag
                                         , p_manual_revert_flag
                                         , p_need_create
                                         , p_can_create
                                         , p_can_run
                                         , p_can_revert
                                         , p_can_remove
                                         , p_can_omit
                                         , p_on_create
                                         , p_on_run
                                         , p_on_revert
                                         , p_on_remove
                                         , p_is_active
                                         , p_raise_ndf
                                      );

      return l_proc_flow_id;
   end corr_proc_flow;

   -- add_proc_flow_dependence - Create dependency between process workflow
   -- Parameters
   --            p_primary_id - id of primary process workflow
   --            p_follow_id  - id of following process workflow
   procedure add_proc_flow_dependence(
                                       p_primary_id  in process_workflow.id%type
                                        , p_follow_id in process_workflow.id%type
                                    )
   as
      l_process_type_id integer;
      l_cycle_path varchar2(2000 char);
   begin
      if (p_primary_id is null) then
         raise_application_error(-20000, 'Головний крок процесу не вказано');
      end if;

      if (p_follow_id is null) then
         raise_application_error(-20000, 'Наступний крок процесу не вказано');
      end if;

      l_process_type_id := get_proc_flow_proc_type(p_primary_id);

      if l_process_type_id = get_proc_flow_proc_type(p_follow_id) then
         insert into process_workflow_dependency( primary_activity_id, following_activity_id)
         values(p_primary_id, p_follow_id);
      else
         raise_application_error(-20000, 'Кроки процесу не належать одному типу процесу');
      end if;

      -- перевірка на замкнутий цикл з кроків процесу (текст запиту краще читати знизу вверх)

      select -- строку, отриману за допомогою sys_connect_by_path розділяємо на колекцію ідентифікаторів і шукаємо
             -- імена кроків щоб сформувати текст повідомлення. Результат конкатенуємо в одну строку з переліком імен, що утворюють замкнуту послідовність
             tools.words_to_string(
                                     cast(
                                            collect(
                                                      (
                                                         select ww.activity_name
                                                         from process_workflow ww
                                                         where  ww.id = c.column_value
                                                      )
                                                   ) as string_list
                                         )
                                     , p_splitting_symbol => ' -> '
                                     , p_ceiling_length => 2000
                                     , p_ignore_nulls => 'Y'
                                  ) cycle_path
      into l_cycle_path
      from table(
                   select tools.string_to_number_list(path, p_splitting_symbol => ';', p_ignore_nulls => 'Y')
                   from (  -- визначаємо ланцюжки пов'язаних між собою задач - відбираємо один з ланцюжків, що утворюює замкнену послідовність
                           select sys_connect_by_path(d.primary_activity_id, ';') || ';' || d.following_activity_id path,
                                  connect_by_iscycle is_cycle
                           from process_workflow_dependency d
                           connect by nocycle d.primary_activity_id = prior d.following_activity_id
                           start with d.primary_activity_id in (-- визначаємо повний перелік кроків, що належать нашому процесу.
                                                                -- ті з них, хто знаходяться в primary_activity_id виступають коренями дерев - з них
                                                                -- починається пошук пов'язаних задач
                                                                  select w.id
                                                                  from   process_workflow w
                                                                  where w.process_type_id = l_process_type_id
                                                               )
                        )
                   where is_cycle = 1 
                         and rownum = 1
                ) c;

      if (l_cycle_path is not null) then
         raise_application_error(-20000, 'Послідовність кроків {' || l_cycle_path || '} утворюють замкнену послідовність');
      end if;
   end add_proc_flow_dependence;

   -- add_proc_flow_dependence - Create dependency between process workflow
   -- Parameters
   --            p_proc_type_id           - id of process type
   --            p_proc_flow_code_primary - code of primary process workflow
   --            p_proc_flow_code_follow  - code of following process workflow
   procedure add_proc_flow_dependence(
                                        p_proc_type_id             in process_type.id%type
                                        , p_proc_flow_code_primary in process_workflow.activity_code%type
                                        , p_proc_flow_code_follow  in process_workflow.activity_code%type
                                     )
   as
      l_primary_id process_workflow.id%type;
      l_follow_id  process_workflow.id%type;
   begin
      if (p_proc_type_id is null) then
         raise_application_error(-20000, 'Тип процесу не вказано');
      end if;

      if (p_proc_flow_code_primary is null) then
         raise_application_error(-20000, 'Код головного кроку процесу не вказано');
      end if;

      if (p_proc_flow_code_follow is null) then
         raise_application_error(-20000, 'Код наступного кроку процесу не вказано');
      end if;

      l_primary_id := get_proc_flow_id(p_proc_flow_code_primary, p_proc_type_id, true);
      l_follow_id  := get_proc_flow_id(p_proc_flow_code_follow , p_proc_type_id, true);

      add_proc_flow_dependence(l_primary_id, l_follow_id);
   end add_proc_flow_dependence;

   -- add_proc_flow_dependence - Create dependency between process workflow
   -- Parameters
   --            p_proc_type_code         - code of process type
   --            p_proc_type_module       - module of process type
   --            p_proc_flow_code_primary - code of primary process workflow
   --            p_proc_flow_code_follow  - code of following process workflow
   procedure add_proc_flow_dependence(
                                        p_proc_type_code           in process_type.process_code%type
                                        , p_proc_type_module       in process_type.module_code%type
                                        , p_proc_flow_code_primary in process_workflow.activity_code%type
                                        , p_proc_flow_code_follow  in process_workflow.activity_code%type
                                     )
   as
      l_proc_type_id process_type.id%type;
   begin
      if (p_proc_type_code is null) then
         raise_application_error(-20000, 'Код типу процесу не вказано');
      end if;

      if (p_proc_type_module is null) then
         raise_application_error(-20000, 'Модуль типу процесу не вказано');
      end if;

      l_proc_type_id := get_proc_type_id(p_proc_type_code, p_proc_type_module, true);

      add_proc_flow_dependence(l_proc_type_id, p_proc_flow_code_primary, p_proc_flow_code_follow );
   end add_proc_flow_dependence;

   -- delete_proc_flow_dependence - Delete dependency between process workflow
   -- Parameters
   --            p_primary_id - id of primary process workflow
   --            p_follow_id  - id of following process workflow
   procedure delete_proc_flow_dependence(
                                           p_primary_id  in process_workflow.id%type
                                           , p_follow_id in process_workflow.id%type
                                        )
   as
   begin
      if (p_primary_id is null) then
         raise_application_error(-20000, 'Головний крок процесу не вказано');
      end if;

      if (p_primary_id is null) then
         raise_application_error(-20000, 'Наступний крок процесу не вказано');
      end if;
      
      delete from process_workflow_dependency
      where primary_activity_id = p_primary_id
            and following_activity_id = p_follow_id;
   end delete_proc_flow_dependence;

   -- delete_proc_flow_dependence - Delete dependency between process workflow
   -- Parameters
   --            p_proc_type_id           - id of process type
   --            p_proc_flow_code_primary - code of primary process workflow
   --            p_proc_flow_code_follow  - code of following process workflow
   procedure delete_proc_flow_dependence(
                                           p_proc_type_id             in process_type.id%type
                                           , p_proc_flow_code_primary in process_workflow.activity_code%type
                                           , p_proc_flow_code_follow  in process_workflow.activity_code%type
                                        )
   as
      l_primary_id process_workflow.id%type;
      l_follow_id  process_workflow.id%type;
   begin
      if (p_proc_type_id is null) then
         raise_application_error(-20000, 'Тип процесу не вказано');
      end if;

      if (p_proc_flow_code_primary is null) then
         raise_application_error(-20000, 'Код головного кроку процесу не вказано');
      end if;

      if (p_proc_flow_code_follow is null) then
         raise_application_error(-20000, 'Код наступного кроку процесу не вказано');
      end if;

      l_primary_id := get_proc_flow_id(p_proc_flow_code_primary, p_proc_type_id, true);
      l_follow_id  := get_proc_flow_id(p_proc_flow_code_follow , p_proc_type_id, true);

      delete_proc_flow_dependence(l_primary_id, l_follow_id);
   end delete_proc_flow_dependence;

   -- delete_proc_flow_dependence - Delete dependency between process workflow
   -- Parameters
   --            p_proc_type_code         - code of process type
   --            p_proc_type_module       - module of process type
   --            p_proc_flow_code_primary - code of primary process workflow
   --            p_proc_flow_code_follow  - code of following process workflow
   procedure delete_proc_flow_dependence(
                                           p_proc_type_code           in process_type.process_code%type
                                           , p_proc_type_module       in process_type.module_code%type
                                           , p_proc_flow_code_primary in process_workflow.activity_code%type
                                           , p_proc_flow_code_follow  in process_workflow.activity_code%type
                                        )
   as
      l_proc_type_id process_type.id%type;
   begin
      if (p_proc_type_code is null) then
         raise_application_error(-20000, 'Код типу процесу не вказано');
      end if;

      if (p_proc_type_module is null) then
         raise_application_error(-20000, 'Модуль типу процесу не вказано');
      end if;

      l_proc_type_id := get_proc_type_id(p_proc_type_code, p_proc_type_module, true);

      delete_proc_flow_dependence(l_proc_type_id, p_proc_flow_code_primary, p_proc_flow_code_follow );
   end delete_proc_flow_dependence;

   -- get_proc_flow_dependence_list - Return all dependencies of process type steps sorted by level
   --                                 Return as table
   --                                 if primary_activity_id = following_activity_id = root step (there may be several)
   -- Parameters
   --            p_proc_type_id - id of process type
   function get_proc_flow_dependence_list(
                                            p_proc_type_id in process_type.id%type
                                         )
   return t_proc_flow_dep_lst
   as
      l_proc_flow_dep t_proc_flow_dep_lst := t_proc_flow_dep_lst();
   begin
      SELECT nvl(pfd.primary_activity_id, pf.id)
             , nvl(pfd.following_activity_id, pf.id)
      BULK collect
      into l_proc_flow_dep
      FROM process_workflow pf
      left join process_workflow_dependency pfd on pfd.following_activity_id = pf.id
      where pf.process_type_id = p_proc_type_id
      START WITH pfd.primary_activity_id is null
      CONNECT BY prior pf.id = pfd.primary_activity_id
      order by level;

      return l_proc_flow_dep;
   end;

   -- get_proc_flow_dependence_pipe - Return all dependencies of process type steps sorted by level
   --                                 Return as table pipe
   --                                 if primary_activity_id = following_activity_id = root step (there may be several)
   -- Parameters
   --            p_proc_type_id - id of process type
   function get_proc_flow_dependence_pipe(
                                            p_proc_type_id in process_type.id%type
                                         )
   return t_proc_flow_dep_lst pipelined
   as
      l_proc_flow_dep t_proc_flow_dep_lst := t_proc_flow_dep_lst();
   begin

      l_proc_flow_dep :=  get_proc_flow_dependence_list(p_proc_type_id);

      for i in 1..l_proc_flow_dep.count
      loop
        pipe row (l_proc_flow_dep(i));
      end loop;
   end;

   -- get_proc_flow_dependence_list - Return all primary process workflow for process workflow
   --                                 Return as table
   -- Parameters
   --            p_proc_flow_id - id of process workflow
   function get_proc_flow_primary_list(
                                         p_proc_flow_id in process_type.id%type
                                      )
   return t_proc_flow_dep_lst
   as
      l_proc_flow_dep t_proc_flow_dep_lst := t_proc_flow_dep_lst();
   begin
      SELECT pfd.primary_activity_id
             , pfd.following_activity_id
      BULK collect
      into l_proc_flow_dep
      FROM process_workflow_dependency pfd
      where pfd.following_activity_id = p_proc_flow_id;

      return l_proc_flow_dep;
   end;

   -- get_proc_flow_dependence_pipe - Return all primary process workflow for process workflow
   --                                 Return as table pipe
   -- Parameters
   --            p_proc_flow_id - id of process workflow
   function get_proc_flow_primary_pipe(
                                         p_proc_flow_id in process_type.id%type
                                      )
   return t_proc_flow_dep_lst pipelined
   as
      l_proc_flow_dep t_proc_flow_dep_lst := t_proc_flow_dep_lst();
   begin
      l_proc_flow_dep :=  get_proc_flow_primary_list(p_proc_flow_id);

      for i in 1..l_proc_flow_dep.count
      loop
        pipe row (l_proc_flow_dep(i));
      end loop;
   end;

   -- get_proc_flow_dependence_list - Return all following process workflow for process workflow
   --                                 Return as table
   -- Parameters
   --            p_proc_flow_id - id of process workflow
   function get_proc_flow_following_list(
                                           p_proc_flow_id in process_type.id%type
                                        )
   return t_proc_flow_dep_lst
   as
      l_proc_flow_dep t_proc_flow_dep_lst := t_proc_flow_dep_lst();
   begin
      SELECT pfd.primary_activity_id
             , pfd.following_activity_id
      BULK collect
      into l_proc_flow_dep
      FROM process_workflow_dependency pfd
      where pfd.primary_activity_id = p_proc_flow_id;

      return l_proc_flow_dep;
   end;

   -- get_proc_flow_dependence_pipe - Return all following process workflow for process workflow
   --                                 Return as table pipe
   -- Parameters
   --            p_proc_flow_id - id of process workflow
   function get_proc_flow_following_pipe(
                                           p_proc_flow_id in process_type.id%type
                                        )
   return t_proc_flow_dep_lst pipelined
   as
      l_proc_flow_dep t_proc_flow_dep_lst := t_proc_flow_dep_lst();
   begin
      l_proc_flow_dep :=  get_proc_flow_following_list(p_proc_flow_id);

      for i in 1..l_proc_flow_dep.count
      loop
        pipe row (l_proc_flow_dep(i));
      end loop;
   end;

   -- read_process - Return parameters of process as record
   -- Parameters
   --             p_process_id - id of process
   --             p_lock       - sign blocking record
   --             p_raise_ndf  - sign raising exceptin when type of process is not found
   function read_process(
                           p_process_id  in process.id%type
                           , p_lock      in boolean default false
                           , p_raise_ndf in boolean default false
                        )
   return process%rowtype
   is
      l_process_row process%rowtype;
   begin
      if (p_lock) then
         select *
         into   l_process_row
         from   process p
         where  p.id = p_process_id
         for update;
      else
         select *
         into   l_process_row
         from   process p
         where  p.id = p_process_id;
      end if;

      return l_process_row;
   exception
      when no_data_found then
           if (p_raise_ndf) then
              raise_application_error(-20000, 'Процес з ідентифікатором {' || p_process_id ||'} не знайдений');
           else return null;
           end if;
   end read_process;

   -- track_process - Add activity to history
   -- Parameters
   --             p_process_id       - id of process
   --             p_process_state_id - state of process
   --             p_comment           - comment
   procedure track_process(
                             p_process_id          in process.id%type
                             , p_process_state_id in process.state_id%type
                             , p_comment           in process_history.comment_text%type default null
                          )
   is
   begin
       insert into process_history
       values (s_process_history.nextval, p_process_id, p_process_state_id, sysdate, sys_context('bars_global', 'user_id'), substrb(p_comment, 1, 4000));
   end;

   /*Begin Function section for obtaining process  parameters*/

   -- get_process_name - Return name of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when process is not found
   function get_process_name(
                               p_process_id  in process_type.id%type
                               , p_raise_ndf in boolean default false
                            )
   return bars.process.process_name%type
   as
   begin
      return read_process(p_process_id, p_raise_ndf => p_raise_ndf).process_name;
   end  get_process_name;

   -- get_process_proc_type_id - Return id of process type of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when process is not found
   function get_process_proc_type_id(
                                       p_process_id  in process_type.id%type
                                       , p_raise_ndf in boolean default false
                                    )
   return bars.process.process_type_id%type
   as
   begin
      return read_process(p_process_id, p_raise_ndf => p_raise_ndf).process_type_id;
   end  get_process_proc_type_id;

   -- get_process_data - Return date of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when process is not found
   function get_process_data(
                               p_process_id  in process_type.id%type
                               , p_raise_ndf in boolean default false
                            )
   return bars.process.process_data%type
   as
   begin
      return read_process(p_process_id, p_raise_ndf => p_raise_ndf).process_data;
   end  get_process_data;

   -- get_process_object_id - Return id of object of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when process is not found
   function get_process_object_id(
                                    p_process_id  in process_type.id%type
                                    , p_raise_ndf in boolean default false
                                 )
   return bars.process.object_id%type
   as
   begin
      return read_process(p_process_id, p_raise_ndf => p_raise_ndf).object_id;
   end  get_process_object_id;

   -- get_process_state_id - Return id of state of process
   -- Parameters
   --             p_proc_type_id   - id of type of process
   --             p_raise_ndf      - sign raising exceptin when process is not found
   function get_process_state_id(
                                   p_process_id  in process_type.id%type
                                   , p_raise_ndf in boolean default false
                                )
   return bars.process.state_id%type
   as
   begin
      return read_process(p_process_id, p_raise_ndf => p_raise_ndf).state_id;
   end  get_process_state_id;
   /*End Function section for obtaining process parameters*/

   -- set_process_statement - Return statement for update field in Process
   -- Parameters
   --            p_field_update - name of field for update
   function set_process_statement(
                                    p_field_update in varchar2
                                 )
   return varchar2
   as
   begin
      return get_update_statement(GC_PROCESS_TABLE, p_field_update, GC_PROCESS_ID);
   end set_process_statement;

   -- raise_process_set - raise exception when DML statement not change table PROCESS
   --                     Using is procedures SET_ for table PROCESS
   -- Parameters
   --             p_process_id - id of process
   procedure raise_process_set(
                                 p_process_id in bars.process.id%type
                              )
   as
   begin
      if (sql%rowcount = 0) then
         raise_application_error(-20000, 'Процес з ідентифікатором {' || p_process_id || '} не знайдений');
      end if;
   end raise_process_set;

   /*Begin Procedure section for set process parameters*/

   -- set_process_name - Set new value in field PROCESS_NAME in table PROCESS
   -- Parameters
   --             p_process_id - id of process
   --             p_value      - new value
   --             p_raise_ndf  - sign raising exceptin when DML statement not change table PROCESS
   procedure set_process_name(
                                p_process_id  in bars.process.id%type
                                , p_value     in bars.process.process_name%type
                                , p_raise_ndf in boolean default false
                             )
   as
   begin
      execute immediate set_process_statement(GC_PROCESS_PROCESS_NAME)
      using p_value, p_process_id;

      if p_raise_ndf then
         raise_process_set(p_process_id);
      end if;

   end set_process_name;

   -- set_process_data - Set new value in field PROCESS_DATA in table PROCESS
   -- Parameters
   --             p_process_id - id of process
   --             p_value      - new value
   --             p_raise_ndf  - sign raising exceptin when DML statement not change table PROCESS
   procedure set_process_data(
                                p_process_id  in bars.process.id%type
                                , p_value     in bars.process.process_data%type
                                , p_raise_ndf in boolean default false
                             )
   as
   begin
      execute immediate set_process_statement(GC_PROCESS_PROCESS_DATA)
      using p_value, p_process_id;

      if p_raise_ndf then
         raise_process_set(p_process_id);
      end if;

   end set_process_data;

   -- set_process_object_ - Set new value in field OBJECT_ID in table PROCESS
   -- Parameters
   --             p_process_id - id of process
   --             p_value      - new value
   --             p_raise_ndf  - sign raising exceptin when DML statement not change table PROCESS
   procedure set_process_object_id(
                                     p_process_id  in bars.process.id%type
                                     , p_value     in bars.process.object_id%type
                                     , p_raise_ndf in boolean default false
                                  )
   as
   begin
      execute immediate set_process_statement(GC_PROCESS_OBJECT_ID)
      using p_value, p_process_id;

      if p_raise_ndf then
         raise_process_set(p_process_id);
      end if;

   end set_process_object_id;

   -- set_process_state_id - Set new value in field STATE_ID in table PROCESS
   -- Parameters
   --             p_process_id - id of process
   --             p_value      - new value
   --             p_raise_ndf  - sign raising exceptin when DML statement not change table PROCESS
   procedure set_process_state_id(
                                    p_process_id  in bars.process.id%type
                                    , p_value     in bars.process.state_id%type
                                    , p_raise_ndf in boolean default false
                                 )
   as
   begin
      execute immediate set_process_statement(GC_PROCESS_STATE_ID)
      using p_value, p_process_id;

      track_process (p_process_id, p_value);

      if p_raise_ndf then
         raise_process_set(p_process_id);
      end if;

   end set_process_state_id;
   /*End Procedure section for set process parameters*/


   -- check_process_can_ - Check the ability to action process
   -- Parameters
   --             p_process_id            - id of process
   --             p_process_can_procedure - name of procedure
   --             p_can_run               - return ability to start activity (Y/N)
   --             p_explanation           - explanation
   procedure check_process_can_(
                                  p_process_id              in process.id%type
                                  , p_process_can_procedure in varchar2
                                  , p_can_run               in out nocopy char
                                  , p_explanation           in out nocopy varchar2
                               )
   is
   begin
       p_can_run := 'Y';

       if (p_process_can_procedure is not null) then
          execute immediate 'begin ' || p_process_can_procedure || '(:process_id, :can_, :explanation); end;'
          using p_process_id, in out p_can_run, in out p_explanation;
       end if;
   end;

   -- check_process_can_ - Check the ability to action process
   -- Parameters
   --             p_process_data          - data of process
   --             p_process_type_id       - process type id
   --             p_process_can_procedure - name of procedure
   --             p_can_run               - return ability to start activity (Y/N)
   --             p_explanation           - explanation
   procedure check_process_can_(
                                  p_process_data            in process.process_data%type
                                  , p_process_type_id       in process_type.id%type 
                                  , p_process_can_procedure in varchar2
                                  , p_can_run               in out nocopy char
                                  , p_explanation           in out nocopy varchar2
                               )
   is
   begin
       p_can_run := 'Y';

       if (p_process_can_procedure is not null) then
          execute immediate 'begin ' || p_process_can_procedure || '(:process_id, :process_type_id, :can_, :explanation); end;'
          using p_process_data, p_process_type_id , in out p_can_run, in out p_explanation;
       end if;
   end;

   -- check_process_activity_not_state - check whether all process activities in state
   -- Parameters
   --             p_process_id            - id of process
   --             p_activity_state_check  - id of activity state
   function check_process_activity_not_st(
                                            p_process_id           in process.id%type
                                            , p_activity_state_check in activity.state_id%type
                                         )
   return integer
   as
      l_ret integer;
   begin
      select count(*)
      into l_ret
      from activity a
      where a.process_id = p_process_id
            and (
                   a.state_id != ACT_STATE_REMOVED
                   and a.state_id != p_activity_state_check
                );

     return l_ret;
   end;

   -- read_activity - Return parameters of activity as record
   -- Parameters
   --             p_activity_id - id of activity
   --             p_lock        - sign blocking record
   --             p_raise_ndf   - sign raising exceptin when type of process is not found
   function read_activity(
                            p_activity_id in activity.id%type
                            , p_lock      in boolean default false
                            , p_raise_ndf in boolean default true
                         )
   return activity%rowtype
   is
       l_activity_row activity%rowtype;
   begin
       if (p_lock) then
           select *
           into   l_activity_row
           from   activity t
           where  t.id = p_activity_id
           for update;
       else
           select *
           into   l_activity_row
           from   activity t
           where  t.id = p_activity_id;
       end if;

       return l_activity_row;
   exception
       when no_data_found then
            if (p_raise_ndf) then
                raise_application_error(-20000, 'Крок процесу з ідентифікатором {' || p_activity_id || '} не знайдений');
            else return null;
            end if;
   end;

   -- track_activity - Add activity to history
   -- Parameters
   --             p_activity_id       - id of activity
   --             p_activity_state_id - state of activity
   --             p_comment           - comment
   procedure track_activity(
                              p_activity_id         in activity.id%type
                              , p_activity_state_id in activity.state_id%type
                              , p_comment           in activity_history.comment_text%type default null
                           )
   is
   begin
       insert into activity_history
       values (s_activity_history.nextval, p_activity_id, p_activity_state_id, sysdate, sys_context('bars_global', 'user_id'), substrb(p_comment, 1, 4000));
   end;

   -- set_activity_statement - Return statement for update field in Activity
   -- Parameters
   --            p_field_update - name of field for update
   function set_activity_statement(
                                     p_field_update in varchar2
                                  )
   return varchar2
   as
   begin
      return get_update_statement(GC_ACTIVITY_TABLE, p_field_update, GC_ACTIVITY_ID);
   end set_activity_statement;

   -- raise_activity_set - raise exception when DML statement not change table ACTIVITY
   --                      Using is procedures SET_ for table ACTIVITY
   -- Parameters
   --             p_activity_id - id of process
   procedure raise_activity_set(
                                  p_activity_id in bars.activity.id%type
                               )
   as
   begin
      if (sql%rowcount = 0) then
         raise_application_error(-20000, 'Крок процесу з ідентифікатором {' || p_activity_id || '} не знайдений');
      end if;
   end raise_activity_set;

   -- set_activity_name - Set new value in field ACTIVITY_NAME in table ACTIVITY
   -- Parameters
   --             p_activity_id - id of process
   --             p_value       - new value
   --             p_raise_ndf   - sign raising exceptin when DML statement not change table ACTIVITY
   procedure set_activity_name(
                                 p_activity_id  in bars.activity.id%type
                                 , p_value      in bars.activity.activity_name%type
                                 , p_raise_ndf  in boolean default false
                              )
   as
   begin
      execute immediate set_activity_statement(GC_ACTIVITY_ACTIVITY_NAME)
      using p_value, p_activity_id;

      if p_raise_ndf then
         raise_activity_set(p_activity_id);
      end if;

   end set_activity_name;

   -- set_activity_data - Set new value in field ACTIVITY_DATA in table ACTIVITY
   -- Parameters
   --             p_activity_id - id of process
   --             p_value       - new value
   --             p_raise_ndf   - sign raising exceptin when DML statement not change table ACTIVITY
   procedure set_activity_data(
                                 p_activity_id  in bars.activity.id%type
                                 , p_value      in bars.activity.activity_data%type
                                 , p_raise_ndf  in boolean default false
                              )
   as
   begin
      execute immediate set_activity_statement(GC_ACTIVITY_ACTIVITY_DATA)
      using p_value, p_activity_id;

      if p_raise_ndf then
         raise_activity_set(p_activity_id);
      end if;

   end set_activity_data;

   -- set_activity_object_id - Set new value in field OBJECT_ID in table ACTIVITY
   -- Parameters
   --             p_activity_id - id of process
   --             p_value       - new value
   --             p_raise_ndf   - sign raising exceptin when DML statement not change table ACTIVITY
   procedure set_activity_object_id(
                                      p_activity_id  in bars.activity.id%type
                                      , p_value      in bars.activity.object_id%type
                                      , p_raise_ndf  in boolean default false
                                   )
   as
   begin
      execute immediate set_activity_statement(GC_ACTIVITY_OBJECT_ID)
      using p_value, p_activity_id;

      if p_raise_ndf then
         raise_activity_set(p_activity_id);
      end if;

   end set_activity_object_id;

   -- set_activity_state_id - Set new value in field STATE_ID in table ACTIVITY
   -- Parameters
   --             p_activity_id - id of process
   --             p_value       - new value
   --             p_raise_ndf   - sign raising exceptin when DML statement not change table ACTIVITY
   procedure set_activity_state_id(
                                     p_activity_id  in bars.activity.id%type
                                     , p_value      in bars.activity.state_id%type
                                     , p_raise_ndf  in boolean default false
                                  )
   as
   begin
      execute immediate set_activity_statement(GC_ACTIVITY_STATE_ID)
      using p_value, p_activity_id;

      if p_raise_ndf then
         raise_activity_set(p_activity_id);
      end if;

   end set_activity_state_id;
   
   -- set_activity_state - change activity state
   -- Parameters
   --             p_activity_id       - id of activity
   --             p_activity_state_id - new state of activity
   --             p_comment           - comment
   procedure set_activity_state(
                                  p_activity_id         in activity.id%type
                                  , p_activity_state_id in activity.state_id%type
                                  , p_comment           in activity_history.comment_text%type default null
                               )
   is
   begin
      set_activity_state_id(p_activity_id, p_activity_state_id);

      track_activity(p_activity_id, p_activity_state_id, p_comment);
   end;

   -- get_unfinished_activity - Get pevious unfinished activity
   -- Parameters
   --             p_activity_id - activity id
   function get_unfinished_activity(
                                      p_activity_id in integer
                                   )
   return activity%rowtype
   is
      l_unfinished_activity_row activity%rowtype;
   begin
      select *
      into   l_unfinished_activity_row
      from   activity a
      where  a.id in (
                        select ad.primary_activity_id
                        from   activity_dependency ad
                        where  ad.following_activity_id = p_activity_id
                     ) 
             and a.state_id in (process_utl.ACT_STATE_CREATED, process_utl.ACT_STATE_FAILED) 
             and rownum = 1;
   exception
      when no_data_found then
           return null;
   end;

   -- check_activity_can_ - Check the ability to action activity
   -- Parameters
   --             p_activity_id            - id of activity
   --             p_activity_can_procedure - name of procedure
   --             p_can_run                - return ability to start (Y/N)
   --             p_explanation            - explanation
   procedure check_activity_can_(
                                   p_activity_id              in  process.id%type
                                   , p_activity_can_procedure in  varchar2
                                   , p_can_run                in out nocopy char
                                   , p_explanation            in out nocopy varchar2
                                )
   is
   begin
      p_can_run := 'Y';

      if (p_activity_can_procedure is not null) then
         execute immediate 'begin ' || p_activity_can_procedure || '(:activity_id, :can_, :explanation); end;'
         using p_activity_id, in out p_can_run, in out p_explanation;
      end if;
   end;

   -- add_activity_dependency - add activity dependency
   -- Parameters
   --             p_process_id    - id of process
   --             p_proc_flow_dep - describe process workflow dependency
   --             p_comment       - new following activity
   procedure add_activity_dependency(
                                       p_process_id      in process.id%type
                                       , p_proc_flow_dep in activity_dependency%rowtype
                                       , p_activity_id   in activity.state_id%type
                                    )
   is
      l_primary_activity_id activity.id%type;
   begin
      select a.id
      into l_primary_activity_id
      from activity a
      join process_workflow_dependency pfd on a.activity_type_id = pfd.primary_activity_id
      where a.process_id = p_process_id
            and a.state_id != process_utl.ACT_STATE_REMOVED
            and pfd.primary_activity_id = p_proc_flow_dep.primary_activity_id
            and pfd.following_activity_id = p_proc_flow_dep.following_activity_id;

      insert into activity_dependency
      values(l_primary_activity_id, p_activity_id);
   end;

-- get_first_activities - Return list primary activity
   -- Parameters
   --             p_process_id - id of process
   function get_first_activities(
                                   p_process_id in process.id%type
                                )
   return number_list
   is
      l_primary_activities number_list;
   begin
      select a.id
      bulk collect into l_primary_activities
      from activity a
      left join activity_dependency ad on a.id = ad.primary_activity_id
      where  a.process_id = p_process_id
             and a.state_id != ACT_STATE_REMOVED
             and not exists (select 1 from activity_dependency adc where adc.following_activity_id = a.id);

      return l_primary_activities;
   end;

   -- get_next_activities - Return list following activity
   -- Parameters
   --             p_activity_id - id of activity
   function get_next_activities(
                                  p_activity_id in activity.id%type
                               )
   return number_list
   is
      l_following_activities number_list;
   begin
      select ad.following_activity_id
      bulk collect into l_following_activities
      from   activity_dependency ad
      where  ad.primary_activity_id = p_activity_id;

      return l_following_activities;
   end;

   -- get_previous_activities - Return list previous activity
   -- Parameters
   --             p_activity_id - id of activity
   function get_previous_activities(
                                      p_activity_id in activity.id%type
                                   )
   return number_list
   is
      l_primary_activities number_list;
   begin
      select ad.primary_activity_id
      bulk collect into l_primary_activities
      from   activity_dependency ad
      where  ad.following_activity_id = p_activity_id;

      return l_primary_activities;
   end;

   -- get_last_activities - Returns a list of activities that do not have the following activities
   -- Parameters
   --             p_process_id - id of process
   function get_last_activities(
                                  p_process_id in process.id%type
                               )
   return number_list
   is
      l_following_activities number_list;
   begin
      select a.id
      bulk collect into l_following_activities
      from activity a
      join activity_dependency ad on a.id = ad.following_activity_id
      where  a.process_id = p_process_id
             and a.state_id != ACT_STATE_REMOVED
             and not exists (select 1 from activity_dependency adc where adc.primary_activity_id = a.id);

      return l_following_activities;
   end;

   -- activity_create - Add activity to process
   -- Parameters
   --             p_activity_type_id - id of process workflow
   --             p_process_id       - id of process
   --             p_object_id        - id of object
   --             p_activity_name    - activity name
   function activity_create(
                              p_activity_type_id in activity.activity_type_id%type
                              , p_process_id     in activity.process_id%type
                              , p_object_id      in activity.object_id%type
                              , p_activity_name  in activity.activity_name%type
                           )
   return activity.id%type
   is
      l_activity_type_row process_workflow%rowtype;
      l_activity_id integer;

      l_can_create_flag char(1 char);
      l_can_create_explanation varchar2(32767 byte);

   begin
      l_activity_type_row := read_proc_flow(p_activity_type_id);

      check_activity_can_(l_activity_id, l_activity_type_row.can_create, l_can_create_flag, l_can_create_explanation);

      if (l_can_create_flag <> 'Y') then
         raise_application_error(-20000, l_can_create_explanation);
      end if;

      insert into activity
      values (s_activity.nextval, p_activity_type_id, p_object_id, p_activity_name, p_process_id, null, ACT_STATE_CREATED)
      returning id
      into l_activity_id;

      -- run current activity
      if (l_activity_type_row.on_create is not null) then
         execute immediate 'begin ' || l_activity_type_row.on_create || '(:activity_id); end;'
         using l_activity_id;
      end if;

      track_activity(l_activity_id, ACT_STATE_CREATED);

      return l_activity_id;
   end;

   -- forward declaration
   procedure activity_run_control(
                                    p_activity_id in activity.id%type
                                    , p_silent_mode in boolean default false
                                 );

   procedure activity_revert_control(
                                       p_activity_id in activity.id%type
                                       , p_comment   in activity_history.comment_text%type default null
                                    );

   -- activity_run - Run current activity
   -- Parameters
   --             p_activity_row      - activity row
   --             p_activity_type_row - process workflow row
   --             p_silent_mode       - raise or no exception
   procedure activity_run(
                            p_activity_row in activity%rowtype
                            , p_activity_type_row process_workflow%rowtype
                            , p_silent_mode in boolean default false
                         )
   is
      l_unfinished_activity_row activity%rowtype;
      l_can_run_flag char(1 byte);

      l_following_activities number_list;

      l_err_msg varchar2(32767);
   begin
      if (p_activity_row.state_id in (process_utl.ACT_STATE_REMOVED)) then
         raise_application_error(-20099, 'Крок {' || p_activity_row.id || ' - ' || p_activity_type_row.activity_name || '} видалений - виконання видаленого кроку неможливо');
      end if;

      --- поки що залишаємо дану перевірку, але в майбутньому можливо буде доступна можливість повторно виконати дії на певному кроці (без запуску наступних кроків)
      if (p_activity_row.state_id in (process_utl.ACT_STATE_DONE)) then
         raise_application_error(-20099, 'Крок {' || p_activity_row.id || ' - ' || p_activity_type_row.activity_name || '} вже виконаний - повторне виконання кроку заборонено');
      end if;

      if (p_activity_row.state_id in (process_utl.ACT_STATE_CREATED, process_utl.ACT_STATE_FAILED)) then
         -- check primary activity is done
         l_unfinished_activity_row := get_unfinished_activity(p_activity_row.id);

         if (l_unfinished_activity_row.id is not null) then
            -- if primary activity is not done raise exception
            l_err_msg := 'Перед виконанням задачі {' || p_activity_row.id || ' - ' || p_activity_type_row.activity_name ||
                         '} повинен бути виконаний попередній крок {' || l_unfinished_activity_row.id || ' - ' ||
                         get_proc_flow_name(l_unfinished_activity_row.activity_type_id) || '}';
            raise e_action_run;
         end if;

         savepoint before_activity;

         begin
            -- check can run activity
            check_activity_can_(p_activity_row.id, p_activity_type_row.can_run, l_can_run_flag, l_err_msg);
         exception
            when others then
                 l_err_msg := 'Помилка при перевірці можливості виконання кроку:' || tools.crlf ||
                              sqlerrm || tools.crlf || dbms_utility.format_error_backtrace();
                 raise e_action_run_rollback;
         end;

         if (l_can_run_flag = 'N') then
            -- if can not run activity raise exception
            raise e_action_run_trace;
         end if;

         if (p_activity_type_row.on_run is not null) then
            begin
               -- run current activity
               execute immediate 'begin ' || p_activity_type_row.on_run || '(:activity_id); end;'
               using p_activity_row.id;
            exception
               when others then
                    l_err_msg := 'Помилка при виконанні кроку:' || tools.crlf ||
                                  sqlerrm || tools.crlf || dbms_utility.format_error_backtrace();
                    raise e_action_run_rollback;
            end;
         end if;

         -- set activity state as done
         set_activity_state(p_activity_row.id, process_utl.ACT_STATE_DONE);

      elsif (p_activity_row.state_id = process_utl.ACT_STATE_OMITED) then
           -- просто переходимо до наступних кроків
         null;
      end if;

      -- get following activity
      l_following_activities := get_next_activities(p_activity_row.id);
      for i in 1..l_following_activities.count loop
         activity_run_control(l_following_activities(i), true);
      end loop;

      -- if activity don`t have following activities ( is last)
      if l_following_activities.count = 0 then
         -- Check all activities is DONE
         if check_process_activity_not_st(p_activity_row.process_id, ACT_STATE_DONE) = 0 then
            -- set process state as SUCCESS
            set_process_state_id(p_activity_row.process_id, process_utl.GC_PROCESS_STATE_SUCCESS, p_raise_ndf => true);
         end if;
      end if;

   exception
      when e_action_run then
           -- log error
           bars_audit.log_error('process_utl.activity_run (exception)', l_err_msg, p_object_id => p_activity_row.id);

           -- if activity not run in silent mode
           if not p_silent_mode then
              -- raise exception
              raise_application_error(-20000, l_err_msg);
           end if;
      when e_action_run_trace then
           -- log error
           bars_audit.log_error('process_utl.activity_run (exception)', l_err_msg, p_object_id => p_activity_row.id);

           -- if activity run in silent mode
           if p_silent_mode then
              -- track activity
              track_activity(p_activity_row.id, p_activity_row.state_id, l_err_msg);
           else
              -- else raise exception
              raise_application_error(-20000, l_err_msg);
           end if;
      when e_action_run_rollback then
           rollback to before_activity;

           -- log error
           bars_audit.log_error('process_utl.activity_run  (exception)',
                                sqlerrm || tools.crlf || dbms_utility.format_error_backtrace() ||
                                tools.crlf || dbms_utility.format_call_stack(),
                                p_object_id => p_activity_row.id);

           -- if activity run in silent mode
           if p_silent_mode then
              -- set activity state and process state as FAILURE
              set_activity_state(
                                   p_activity_row.id
                                   , process_utl.ACT_STATE_FAILED
                                   , l_err_msg
                                );
              set_process_state_id(p_activity_row.process_id, process_utl.GC_PROCESS_STATE_FAILURE);
           else
              -- else raise exception
              raise_application_error(-20000, l_err_msg);
           end if;
   end;

   -- activity_run - Run current activity
   -- Parameters
   --             p_activity_id       - activity id
   --             p_silent_mode       - raise or no exception
   procedure activity_run(
                            p_activity_id in activity.id%type
                            , p_silent_mode in boolean default false
                         )
   is
      l_activity_row      activity%rowtype;
      l_activity_type_row process_workflow%rowtype;
   begin
      l_activity_row := read_activity(p_activity_id);
      l_activity_type_row := read_proc_flow(l_activity_row.activity_type_id);

      activity_run(l_activity_row, l_activity_type_row, p_silent_mode);
   end;

   -- activity_run_control - Run current activity
   -- Parameters
   --             p_activity_id - id of activity
   --             p_silent_mode - raise or no exception
   procedure activity_run_control(
                                    p_activity_id in activity.id%type
                                    , p_silent_mode in boolean default false
                                 )
   is
      l_activity_row activity%rowtype;
      l_activity_type_row process_workflow%rowtype;
   begin
      l_activity_row := read_activity(p_activity_id);
      l_activity_type_row := read_proc_flow(l_activity_row.activity_type_id);

      -- check manual run activity
      if (l_activity_type_row.manual_run_flag = 'N') then

         -- if manual run activity set to 'N' run current activity
         activity_run(l_activity_row, l_activity_type_row, p_silent_mode);
      end if;
   end;

   -- activity_revert - Revert current activity
   -- Parameters
   --             p_activity_id - id of activity
   --             p_comment    - comments
   procedure activity_revert(
                               p_activity_id in activity.id%type
                               , p_comment   in activity_history.comment_text%type default null
                            )
   is
      l_activity_type_row process_workflow%rowtype;
      l_activity_row activity%rowtype;

      l_can_revert_flag char(1 char);
      l_can_revert_explanation varchar2(32767 byte);

      l_following_activities number_list;
   begin
      savepoint before_activity;

      l_activity_row := read_activity(p_activity_id, p_lock => true);
      l_activity_type_row := read_proc_flow(l_activity_row.activity_type_id);

      if (l_activity_row.state_id = process_utl.ACT_STATE_REMOVED) then
         raise_application_error(-20099, 'Крок {' || l_activity_row.id || ' - ' || l_activity_type_row.activity_name || '} видалений - повернення видаленого кроку неможливо');
      end if;

      -- Skip revert activity if activity state CREATED
      if (l_activity_row.state_id != process_utl.ACT_STATE_CREATED) then
         -- check activity can revert
         check_activity_can_(l_activity_row.id, l_activity_type_row.can_revert, l_can_revert_flag, l_can_revert_explanation);

         if (l_can_revert_flag <> 'Y') then
            raise_application_error(-20000, l_can_revert_explanation);
         end if;

         -- revert current activity
         if (l_activity_type_row.on_revert is not null) then
            execute immediate 'begin ' || l_activity_type_row.on_revert || '(:activity_id); end;'
            using p_activity_id;
         end if;

         set_activity_state(l_activity_row.id, ACT_STATE_CREATED, p_comment);
      end if;

      -- Geting list of folloving activity
      l_following_activities := get_next_activities(p_activity_id);
      for i in 1..l_following_activities.count loop
         -- revert followin activity with control
         activity_revert_control(l_following_activities(i), p_comment);
      end loop;

   exception
      when others then
           rollback to before_activity;
           raise_application_error(sqlcode, sqlerrm);
   end;

   -- activity_revert_control - Revert current activities if possible
   -- Parameters
   --            p_activity_id - id of activity
   --            p_comment    - comments
   procedure activity_revert_control(
                                      p_activity_id in activity.id%type
                                       , p_comment   in activity_history.comment_text%type default null
                                   )
   as
      l_activity             activity%rowtype;
   begin
      l_activity := read_activity(p_activity_id);

      -- check manual revert activity
      if get_proc_flow_manual_revert(l_activity.activity_type_id) = 'N' then

         -- if manual revert activity set to 'N' revert current activity
         activity_revert(p_activity_id, p_comment);
      else
         raise_application_error(-20000, 'Крок процесу з ідентифікатором '||p_activity_id||' має бути повернутий вручну');
      end if;
   end;

   -- activity_remove - Run current activity
   -- Parameters
   --             p_activity_id - id of activity
   --             p_comment    - comments
   procedure activity_remove(
                               p_activity_id in activity.id%type
                               , p_comment   in activity_history.comment_text%type default null
                            )
   is
      l_activity_type_row process_workflow%rowtype;
      l_activity_row activity%rowtype;

      l_can_remove_flag char(1 char);
      l_can_remove_explanation varchar2(32767 byte);

      l_following_activities number_list;
   begin

      l_activity_row := read_activity(p_activity_id, p_lock => true);
      l_activity_type_row := read_proc_flow(l_activity_row.activity_type_id);

      if l_activity_row.state_id not in (process_utl.ACT_STATE_CREATED, process_utl.ACT_STATE_REMOVED) then
          raise_application_error(-20099, 'Крок {' || l_activity_row.id || ' - ' || l_activity_type_row.activity_name || '} не в статусах Створений або Видалений - видалення неможливо');
      end if;
       
      if l_activity_row.state_id != process_utl.ACT_STATE_REMOVED then
        
         check_activity_can_(l_activity_row.id, l_activity_type_row.can_remove, l_can_remove_flag, l_can_remove_explanation);

         if (l_can_remove_flag <> 'Y') then
            raise_application_error(-20000, l_can_remove_explanation);
         end if;
  
         -- remove current activity
         if (l_activity_type_row.on_remove is not null) then
            execute immediate 'begin ' || l_activity_type_row.on_remove || '(:activity_id); end;'
            using p_activity_id;
         end if;

         set_activity_state(l_activity_row.id, ACT_STATE_REMOVED, p_comment);

      end if;

      -- Geting list of folloving activity
      l_following_activities := get_next_activities(p_activity_id);
      for i in 1..l_following_activities.count loop
         -- revert following activity with control
         activity_remove(l_following_activities(i), p_comment);
      end loop;

      -- if activity don`t have following activities ( is last)
      if l_following_activities.count = 0 then
         -- Check all activities is REMOVE
         if check_process_activity_not_st(l_activity_row.process_id, ACT_STATE_REMOVED) = 0 then
            -- set process state as CREATE
            set_process_state_id(l_activity_row.process_id, GC_PROCESS_STATE_CREATE, p_raise_ndf => true);
         end if;
      end if;

   /* На данный момент перехват исключений заблокирован
   exception
      when others then
           rollback to before_activity;
           bars_audit.log_error('process_utl.activity_remove (exception)',
                                sqlerrm || tools.crlf || dbms_utility.format_error_backtrace() ||
                                           tools.crlf || dbms_utility.format_call_stack(),
                                p_object_id => p_activity_id);

           set_activity_state(p_activity_id, ACT_STATE_FAILED, sqlerrm || tools.crlf || dbms_utility.format_error_backtrace());
   */
   end;

   -- process_create - Add new process with check right and return his id of null when occurred error
   -- Parameters
   --            p_proc_type_id      - id of type of process for new process
   --            p_process_name      - name of process
   --            p_process_data      - process data
   --            p_process_object_id - object id for process
   --            p_raise_ndf         - sign of the need to generate an exception
   function process_create(
                             p_proc_type_id        in process_type.id%type
                             , p_process_name      in process.process_name%type
                             , p_process_data      in process.process_data%type default null
                             , p_process_object_id in process.object_id%type    default null
                          )
   return process.id%type
   as
      l_process_id   process.id%type;
      l_proc_type    process_type%rowtype;

      l_can_create_flag char(1 char);
      l_can_create_explanation varchar2(32767 byte);
   begin
      if (p_proc_type_id is null) then
         raise_application_error(-20001, 'Тип процесу не вказано');
      end if;

      if (p_process_name is null) then
         raise_application_error(-20002, 'Найменування процесу не вказано');
      end if;

      l_proc_type := read_proc_type(p_proc_type_id, p_raise_ndf => true);

      if l_proc_type.is_active = 'N' then
         raise_application_error(-20002, 'Тип процесу не активный');
      end if;

      -- check can create process
      check_process_can_( p_process_data, l_proc_type.id, l_proc_type.can_create, l_can_create_flag, l_can_create_explanation);

      if l_can_create_flag = 'Y' then

         l_process_id := get_process_new_id();

         insert into process(id, process_type_id, process_name, state_id)
         values(l_process_id, p_proc_type_id, p_process_name, GC_PROCESS_STATE_CREATE);

         track_process (l_process_id, GC_PROCESS_STATE_CREATE);

         if p_process_object_id is not null then
            set_process_object_id(l_process_id, p_process_object_id, p_raise_ndf => true);
         end if;

         if p_process_data is not null then
            set_process_data(l_process_id, p_process_data, p_raise_ndf => true);
         end if;

         if l_proc_type.on_create is not null then
              -- Run procedure when created process
            execute immediate 'begin ' || l_proc_type.on_create || '(:p_process_id); end;'
            using l_process_id;
         end if;
      else
         raise_application_error(-20000, 'Неможливо створити процесс: '||l_can_create_explanation);
      end if;

      return l_process_id;
   end process_create;

   -- process_create - Add new process with check right and return his id
   -- Parameters
   --            p_proc_type_code    - Code of type of process
   --            p_proc_type_module  - Module of type of process
   --            p_process_data      - process data
   --            p_process_object_id - object id for process
   --            p_raise_ndf         - sign of the need to generate an exception
   function process_create(
                             p_proc_type_code      in process_type.process_code%type
                             , p_proc_type_module  in process_type.module_code%type
                             , p_process_name      in process.process_name%type
                             , p_process_data      in process.process_data%type default null
                             , p_process_object_id in process.object_id%type    default null
                          )
   return process.id%type
   as
      l_process_id   process.id%type;
      l_proc_type_id process_type.id%type;
   begin
      if (p_proc_type_module is null) then
         raise_application_error(-20001, 'Код модуля не вказано');
      end if;

      if (p_proc_type_code is null) then
         raise_application_error(-20002, 'Код типу процесу не вказано');
      end if;

      l_proc_type_id := get_proc_type_id(p_proc_type_code, p_proc_type_module, p_raise_ndf => true);

      l_process_id := process_create(
                                       l_proc_type_id
                                       , p_process_name
                                       , p_process_data
                                       , p_process_object_id
                                    );

      return l_process_id;
   end process_create;

   -- process_run - Move process to state RUN
   -- Parameters
   --            p_process_id - process id
   procedure process_run(
                           p_process_id   in process_type.id%type
                        )
   as
      l_proc_type    process_type%rowtype;
      l_process_row  process%rowtype;
      l_flow         t_proc_flow_dep_lst;
      l_activity_id  activity.id%type;

      l_primary_activity number_list;

      l_can_run_flag char(1 char);
      
      l_err_msg varchar2(32767);

   begin
      if (p_process_id is null) then
         l_err_msg := 'Ідентифікатор процесу не вказано';
         raise e_process_id;
      end if;

      -- lock process
      l_process_row := read_process(p_process_id, p_lock => true, p_raise_ndf => true);
      
      if (l_process_row.state_id != process_utl.GC_PROCESS_STATE_CREATE) then
         l_err_msg := 'Процес з ідентифікатором '||p_process_id||' не в статусі Створений';
         raise e_process_state;
      end if;

      -- get process type
      l_proc_type := read_proc_type(l_process_row.process_type_id, p_raise_ndf => true);

      -- check can run process
      check_process_can_(p_process_id, l_proc_type.can_run, l_can_run_flag, l_err_msg);

      savepoint before_process_run;

      if l_can_run_flag = 'Y' then
         if l_proc_type.on_run is not null then
            -- Run procedure when created process
            execute immediate 'begin ' || l_proc_type.on_run || '(:p_process_id); end;'
            using p_process_id;
         end if;

         set_process_state_id(p_process_id, GC_PROCESS_STATE_RUN, p_raise_ndf => true);

         -- Get list of process workflow with dependency for process type
         l_flow := get_proc_flow_dependence_list(l_proc_type.id);
         if l_flow.count > 0 then
            for i in 1..l_flow.count loop
               -- Create activity for process
               l_activity_id := activity_create(l_flow(i).following_activity_id, p_process_id, null, get_proc_flow_name(l_flow(i).following_activity_id));

               if l_flow(i).primary_activity_id != l_flow(i).following_activity_id then
                  --add activity dependency
                  add_activity_dependency(
                                            p_process_id
                                            , l_flow(i)
                                            , l_activity_id
                                         );
               end if;
            end loop;

            l_primary_activity := get_first_activities(p_process_id);
            for i in 1..l_primary_activity.count loop
                -- run primary activity
                activity_run_control(l_primary_activity(i));
            end loop;
         end if;

      else
         raise e_process_can;
      end if;
   exception
      when e_process_id then
           bars_audit.log_error('process_utl.process_run (exception)', l_err_msg, p_object_id => p_process_id);
           raise_application_error(-20000, l_err_msg);
      when e_process_state then
           bars_audit.log_error('process_utl.process_run (exception)', l_err_msg, p_object_id => p_process_id);
           raise_application_error(-20001, l_err_msg);
      when e_process_can then
           rollback to before_process_run;
           bars_audit.log_error('process_utl.process_run (exception)', l_err_msg, p_object_id => p_process_id);
           raise_application_error(-20002, 'Неможливо виконати процес: '||l_err_msg);
      when others then
           rollback to before_process_run;
           bars_audit.log_error('process_utl.process_run (exception)',
                                 sqlerrm || tools.crlf || dbms_utility.format_error_backtrace() ||
                                            tools.crlf || dbms_utility.format_call_stack(),
                                 p_object_id => p_process_id);
           raise_application_error(-20003, sqlerrm);
   end process_run;

   -- process_revert - Move process to state FAILURE
   -- Parameters
   --            p_process_id - process id
   --            p_comment    - comments
   procedure process_revert(
                              p_process_id in process_type.id%type
                              , p_comment  in varchar2 default null
                           )
   as
      l_proc_type    process_type%rowtype;
      l_process_row  process%rowtype;

      l_following_activity number_list;

      l_can_revert_flag char(1 char);

      l_err_msg varchar2(32767);
   begin
      if (p_process_id is null) then
         l_err_msg := 'Ідентифікатор процесу не вказано';
         raise e_process_id;
      end if;

      -- lock process
      l_process_row := read_process(p_process_id, p_lock => true, p_raise_ndf => true);

      -- get process type
      l_proc_type := read_proc_type(l_process_row.process_type_id, p_raise_ndf => true);

      -- check can revert process
      check_process_can_(p_process_id, l_proc_type.can_revert, l_can_revert_flag, l_err_msg);

      if l_can_revert_flag = 'Y' then

         if l_proc_type.on_revert is not null then
           -- Run procedure when reverted process
            execute immediate 'begin ' || l_proc_type.on_revert || '(:p_process_id); end;'
            using p_process_id;
         end if;

         -- get primary activities
         l_following_activity := get_first_activities(p_process_id);
         for i in 1..l_following_activity.count loop
            --  revert and remove activity
            activity_revert_control(l_following_activity(i), p_comment);
            activity_remove(l_following_activity(i), p_comment);
         end loop;
      else
         raise e_process_can;
      end if;
   exception
      when e_process_id then
           bars_audit.log_error('process_utl.process_revert (exception)', l_err_msg, p_object_id => p_process_id);
           raise_application_error(-20000, l_err_msg);
      when e_process_can then
           bars_audit.log_error('process_utl.process_revert (exception)', l_err_msg, p_object_id => p_process_id);
           raise_application_error(-20002, 'Неможливо повеннути процес: '||l_err_msg);
   end process_revert;

   -- process_remove - Move process to state DISCARD
   -- Parameters
   --            p_process_id - process id
   --            p_comment    - comments
   procedure process_remove(
                              p_process_id in process_type.id%type
                           )
   as
      l_proc_type    process_type%rowtype;
      l_process_row  process%rowtype;

      l_can_remove_flag char(1 char);

      l_err_msg varchar2(32767);
   begin
      if (p_process_id is null) then
         l_err_msg := 'Ідентифікатор процесу не вказано';
         raise e_process_id;
      end if;

      -- lock process
      l_process_row := read_process(p_process_id, p_lock => true, p_raise_ndf => true);

      if l_process_row.state_id != GC_PROCESS_STATE_CREATE then
         l_err_msg := 'Неможливо видалити процес: Просцес не в стані Cтворений';
         raise e_process_state;
      end if;

      -- get process type
      l_proc_type := read_proc_type(l_process_row.process_type_id, p_raise_ndf => true);

      -- check can revert process
      check_process_can_(p_process_id, l_proc_type.can_remove, l_can_remove_flag, l_err_msg);

      savepoint before_process_remove;
         
      if l_can_remove_flag = 'Y' then
         if l_proc_type.on_revert is not null then
            -- Run procedure when reverted process
            execute immediate 'begin ' || l_proc_type.on_remove || '(:p_process_id); end;'
            using p_process_id;
         end if;

         set_process_state_id(p_process_id, GC_PROCESS_STATE_DISCARD, p_raise_ndf => true);
      else
         raise e_process_can;
      end if;
   exception
     when e_process_id then
           bars_audit.log_error('process_utl.process_remove (exception)', l_err_msg, p_object_id => p_process_id);
           raise_application_error(-20000, l_err_msg);
     when e_process_state then
           bars_audit.log_error('process_utl.process_remove (exception)', l_err_msg, p_object_id => p_process_id);
           raise_application_error(-20001, l_err_msg);
     when e_process_can then
           rollback to before_process_remove;
           bars_audit.log_error('process_utl.process_remove (exception)', l_err_msg, p_object_id => p_process_id);
           raise_application_error(-20002, 'Неможливо видалити процес: '||l_err_msg);
      when others then
           rollback to before_process_remove;
           bars_audit.log_error('process_utl.process_remove (exception)',
                                 sqlerrm || tools.crlf || dbms_utility.format_error_backtrace() ||
                                            tools.crlf || dbms_utility.format_call_stack(),
                                 p_object_id => p_process_id);
   end process_remove;

   -- process_success - Move process to state SUCCESS
   -- Parameters
   --            p_process_id - process id
   procedure process_success(
                               p_process_id in process_type.id%type
                            )
   as
      l_process_row  process%rowtype;

      l_err_msg varchar2(32767);
   begin
      if (p_process_id is null) then
         l_err_msg := 'Ідентифікатор процесу не вказано';
         raise e_process_id;
      end if;

      -- lock process
      l_process_row := read_process(p_process_id, p_lock => true, p_raise_ndf => true);

      if check_process_activity_not_st(l_process_row.id, ACT_STATE_DONE) > 0 then
         l_err_msg := 'Не всі кроки процесу {' || l_process_row.process_name ||'} завершені';
         raise e_process_can;
      end if;
      savepoint before_process_success;

      set_process_state_id(p_process_id, GC_PROCESS_STATE_SUCCESS, p_raise_ndf => true);
   exception
     when e_process_id then
           bars_audit.log_error('process_utl.process_success (exception)', l_err_msg, p_object_id => p_process_id);
           raise_application_error(-20000, l_err_msg);
     when e_process_can then
           bars_audit.log_error('process_utl.process_success (exception)', l_err_msg, p_object_id => p_process_id);
           raise_application_error(-20002, l_err_msg);
      when others then
           rollback to before_process_success;
           bars_audit.log_error('process_utl.process_success (exception)',
                                 sqlerrm || tools.crlf || dbms_utility.format_error_backtrace() ||
                                            tools.crlf || dbms_utility.format_call_stack(),
                                 p_object_id => p_process_id);
   end process_success;

end PROCESS_UTL;
/

show err;

PROMPT *** Create  grants  ***
grant EXECUTE on PROCESS_UTL to BARS_ACCESS_DEFROLE;
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/PROCESS_UTL       ====== *** End ***
PROMPT ===================================================================================== 
