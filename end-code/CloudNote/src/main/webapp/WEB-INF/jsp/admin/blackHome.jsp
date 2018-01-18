<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/global/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="left.jsp"/>

<body style="margin-left: 220px;">

<!--主体-->
<div class="container" style="height: 1000px;text-align: center;width: 100%;">
    <h2 style="margin-bottom: 30px;">小黑屋</h2>
    <div id="toolbar" style="margin-right: 20px;">

        <button id="btn_delete" type="button" class="btn btn-default" onclick="delect_more()">
            <span class="glyphicon glyphicon-remove" aria-hidden="true">删除</span>
        </button>

    </div>
    <div style="width: 95%;float: right;margin-right: 50px;">
        <table id="blackHomeTable" class="table table-responsive table-bordered tab-content table-hover" style="margin-right: 10%;">
        </table>
    </div>
</div>

<script>
    // 注册事件
    window.operateEvents = {
        'click .cancelBlacklist': function (e, value, row, index) {
            var id = row.id;
            var msg = "确定要提前解除吗？";
            if (confirm(msg)){
                window.location.href='${ctx}/admin/cancelBlacklist?id=' + id;
            }else{
                return false;
            }
        },
        'click .delBlacklist': function (e, value, row, index) {
            var id = row.id;
            removeBlackList(id);
        }
    };

    function AddFunctionAlty(value, row, index) {
        if(row.status == "有效") {
            return ['  <button id="btn_detail" type="button" class="btn btn-default cancelBlacklist">\n' +
            '            <span class="glyphicon glyphicon-eye-open" aria-hidden="true" >解禁</span>\n' +
            '        </button>'].join("");
        } else if(row.status == "失效") {
            return ['  <button id="btn_delect" type="button" class="btn btn-default delBlacklist">\n' +
                '            <span class="glyphicon glyphicon-remove" aria-hidden="true" >删除</span>\n' +
                '        </button>'].join("");
        }
    }

    $(function () {
        sendGet('${ctx}/admin/prepareBlackHome',{},false,function (value) {
            $table = $('#blackHomeTable').bootstrapTable(
                {
                    data: value,   //最终的JSON数据放在这里
                    striped: true,
                    cache: false,
                    height:700,
                    toolbar:'#toolbar',
                    pagination: true,
                    sidePagination: "client",
                    pageNumber: 1,
                    pageSize: 10,
                    pageList: [5, 10, 20],
                    showColumns: true,
                    minimunCountColumns: 2,
                    sort: false,
                    sortOrder: "asc",
                    search: true,
                    showRefresh: true,
                    clickToSelect:true,
                    showToggle:true,
                    cardView: false,    //是否显示详细视图
                    detaView:false,
                    showExport: true,//显示导出按钮
                    exportTypes:  ['excel','json', 'xml', 'txt', 'sql'],
                    columns: [
                        {
                            field:"checked",
                            checkbox:true
                        },
                        {
                            field: 'tel',
                            title: 'tel',
                            align: 'center',
                            valign: 'center',
                            sortable: true
                        },
                        {
                            field: 'userName',
                            title: 'userName',
                            align: 'center',
                            valign: 'center',
                            sortable: true
                        },
                        {
                            field: 'illegalName',
                            title: 'illegalName',
                            align: 'center',
                            valign: 'center',
                            sortable: true
                        },
                        {
                            field: 'createDate',
                            title: 'createDate',
                            align: 'center',
                            valign: 'center',
                            sortable: true
                        },
                        {
                            field: 'endDate',
                            title: 'endDate',
                            align: 'center',
                            valign: 'center',
                            sortable: true
                        },
                        {
                            field: 'status',
                            title: 'status',
                            align: 'center',
                            valign: 'center',
                            sortable: true
                        },
                        {
                            field:"button",
                            title:"operate",
                            align: 'center',
                            formatter:AddFunctionAlty,
                            events:operateEvents
                        }
                    ]
                })
        },function (error) {
            toastr.error("系统错误");
            return false;
        });
    });

    function delect_more() {
        var row = $(blackHomeTable).bootstrapTable('getSelections');
        removeBlackList(row);
    }

    function removeBlackList(obj) {
        var msg = "确定要删除该条记录吗？";
        if (confirm(msg)){
            var ids = new Array();
            if(typeof (obj) == "string") {
                ids.push(obj);
            } else if (typeof (obj) == "object") {
                for(var i=0; i< obj.length; i++) {
                    ids.push(obj[i].id);
                }
            }
            window.location.href="${ctx}/admin/removeBlacklistRecord?ids=" + ids;
        }else{
            return false;
        }
    }
</script>
</body>
</html>