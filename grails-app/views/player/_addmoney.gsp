<g:form url="[action: 'addmoney']" class="form-horizontal" data-toggle="validator">
    <div class="modal fade" id="addMoneyModal" tabindex="-1" role="dialog" aria-labelledby="ourAddMoneyModal"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title"><g:message code="player.add.model.label"/></h4>
                </div>

                <div class="modal-body">

                    <div class="form-group">

                        <label for="current" class="col-sm-3 control-label"><g:message code="player.add.to.current.label"/> *</label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-euro"></span></span>
                                <g:field type="" name="current" required="" class="form-control" pattern="^(?=.+)(?:[1-9]\\d*|0)?(?:,\\d+)?\$"/>
                            </div>
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>


                    <g:hiddenField name="playerId" id="modalPlayerId"/>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><g:message
                            code="default.button.close.label"/></button>
                    <g:submitButton name="create" class="btn btn-success"
                                    value="${message(code: 'default.button.save.label', default: 'Save')}"/>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</g:form>